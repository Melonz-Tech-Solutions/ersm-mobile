// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/default/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zamboangaemergency/main.dart';
import 'default/location.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreenState homeScreenState;

  @override
  HomeScreenState createState() {
    homeScreenState = HomeScreenState();
    return homeScreenState;
  }

  getState() => homeScreenState;
}

class HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  SharedPreferences _sharedPreferences;

  String _username = 'User';

  bool _loggedIn;
  bool _activeIncident = false;
  bool _activeResponder = false;
  bool _uploaded = false;

  List _responderTypes = [];
  List<int> _responderIDs = [];

  LocationData _locationData;
  Location location;

  File _imageFile;
  Uint8List _image;

  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController _googleMapController;
  CameraPosition _userCameraPosition;

  final Set<Marker> _markers = {};

  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  Timer _locationTimer;
  Timer _checkActiveTimer;

  int _incidentID = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _configure();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_locationTimer != null) _locationTimer.cancel();
    if (_checkActiveTimer != null) _checkActiveTimer.cancel();
    if (_googleMapController != null) _googleMapController.dispose();
    super.dispose();
  }

  reset(String type) async {
    setState(() {
      if (type == 'logout') {
        _username = 'User';
        _loggedIn = false;
        _activeIncident = false;
        _activeResponder = false;
      }

      _markers.clear();
      polylineCoordinates.clear();
      polylines.clear();
      _image = null;
      _imageFile = null;
      _uploaded = false;

      _responderTypes.clear();
      _responderIDs.clear();
    });
    if (type != 'resolved') await _checkActiveIncident(false);
    // else {
    //   setState(() {
    //     _image = null;
    //     _imageFile = null;
    //     _uploaded = false;
    //   });
    // }
  }

  _configure() async {
    Http().showLoadingOverlay(context);
    List<Map<String, dynamic>> resTypes =
        await database.query('responder_types');
    if (resTypes.isNotEmpty) {
      setState(() {
        _responderTypes = new List.from(resTypes);
      });
    }
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences?.getString('token') != null) {
      setState(() {
        _loggedIn = true;
        _username = _sharedPreferences?.getString('username');
      });
    } else {
      setState(() {
        _loggedIn = false;
      });
    }

    if (_loggedIn) {
      _initFirebase();
      await _getLocation(false);
      Navigator.pop(context);
      await _checkActiveIncident(false);
      _locationTimer = Timer.periodic(
          Duration(seconds: 25), (Timer t) async => await _getLocation(false));
      _checkActiveTimer = Timer.periodic(
          Duration(seconds: 10),
          (Timer t) async =>
              {if (_activeIncident) await _checkActiveIncident(false)});
    } else {
      Navigator.pop(context);
    }
  }

  _getLocation(bool load) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var data = await CustomLocator().getLocation();
    if (data != 'Service not enabled' && data != 'Permission denied') {
      bool update = false;
      if (_locationData != null) {
        update = Geolocator.distanceBetween(_locationData.latitude,
                _locationData.longitude, data.latitude, data.longitude) >
            5;
      } else
        update = true;
      setState(() {
        _locationData = data;
      });
      if (_googleMapController != null)
        _googleMapController
            .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_locationData.latitude, _locationData.longitude),
          zoom: 15,
        )));
      if (update) _updateLatLng();
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF323232),
          content: Text('Can\'t fetch location',
              textScaleFactor: .8,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Config.title * Config.textMultiplier,
                  fontFamily: 'Poppins'))));
    }
  }

  _checkActiveIncident(bool load) async {
    if (load) Http().showLoadingOverlay(context);
    var response = await Http(url: 'incidents').getWithHeader();
    if (response is String) {
      if (load) Navigator.pop(context);
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          backgroundColor: Color(0xFF323232),
          content: Text(response,
              textScaleFactor: .8,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Config.title * Config.textMultiplier,
                  fontFamily: 'Roboto'))));
      return;
    } else if (response is Response) {
      if (response.statusCode != 200) {
        if (load) Navigator.pop(context);
        try {
          Map<String, dynamic> body = json.decode(response.body);
          _scaffoldKey.currentState?.showSnackBar(SnackBar(
              backgroundColor: Color(0xFF323232),
              content: Text(
                  body.containsKey('errors')
                      ? jsonDecode(response.body)['errors'][
                              jsonDecode(response.body)['errors']
                                  .keys
                                  .toList()[0]][0]
                          .toString()
                      : (body['message'] ?? 'Something went wrong'),
                  textScaleFactor: .8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Config.title * Config.textMultiplier,
                      fontFamily: 'Roboto'))));
          return;
        } catch (error) {
          _scaffoldKey.currentState?.showSnackBar(SnackBar(
              backgroundColor: Color(0xFF323232),
              content: Text('Something went wrong',
                  textScaleFactor: .8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Config.title * Config.textMultiplier,
                      fontFamily: 'Roboto'))));
          return;
        }
      } else {
        List incidents = new List.from(json.decode(response.body));
        if (incidents.isNotEmpty) {
          dynamic latestIncident = incidents[0];
          if (latestIncident['status'] != 'RESOLVED') {
            List responderIDs = new List.from(_responderIDs);
            List incidentResponders =
                new List.from(latestIncident['incident_responders']);
            incidentResponders.forEach((incidentResponder) async {
              if (!responderIDs
                      .contains(incidentResponder['responder']['id']) &&
                  incidentResponder['enroute_at'] == null) {
                responderIDs.add(incidentResponder['responder']['id']);
              }
              http.Response response;
              if (incidentResponder['responder']['responder_type_id'] == 1)
                response = await http.get(
                  Uri.parse(
                      'https://res.cloudinary.com/dreame-rs-it-solutions-inc/image/upload/v1657354624/emergency/medic_avzucj.ico'),
                );
              if (incidentResponder['responder']['responder_type_id'] == 2)
                response = await http.get(
                  Uri.parse(
                      'https://res.cloudinary.com/dreame-rs-it-solutions-inc/image/upload/v1657354542/emergency/police_zi49gd.ico'),
                );
              if (incidentResponder['responder']['responder_type_id'] == 3)
                response = await http.get(
                  Uri.parse(
                      'https://res.cloudinary.com/dreame-rs-it-solutions-inc/image/upload/v1657354624/emergency/fire_czl4xc.ico'),
                );
              final marker = await getBytesFromAsset(response.bodyBytes, 100);
              _markers.add(Marker(
                  markerId:
                      MarkerId(incidentResponder['responder']['id'].toString()),
                  icon: BitmapDescriptor.fromBytes(marker),
                  position: LatLng(
                      double.parse(incidentResponder['responder']['latitude']),
                      double.parse(
                          incidentResponder['responder']['longitude']))));
              _createPolylines(
                  LatLng(
                      double.parse(incidentResponder['responder']['latitude']),
                      double.parse(
                          incidentResponder['responder']['longitude'])),
                  incidentResponder['responder']['id']);
            });

            Uint8List bytes;
            if (_responderIDs.isEmpty && latestIncident['image'] != null) {
              if (Uri.parse(latestIncident['image']).path.isNotEmpty) {
                final ByteData imageData =
                    await NetworkAssetBundle(Uri.parse(latestIncident['image']))
                        .load("");
                bytes = imageData.buffer.asUint8List();
              }
            }

            setState(() {
              _incidentID = latestIncident['id'];
              _responderIDs = new List.from(responderIDs);
              _activeIncident = true;
              if (_responderIDs.isNotEmpty) _activeResponder = true;
              if (bytes != null && !_uploaded) _image = bytes;
              if (bytes != null) _uploaded = true;
              // else {
              //   _image = null;
              //   _imageFile = null;
              //   _uploaded = false;
              // }
            });
            if (load) Navigator.pop(context);
          } else {
            if (_activeIncident == true) {
              reset('resolved');
            }
            setState(() {
              _activeIncident = false;
              _activeResponder = false;
            });
            _loadresponderTypes(false);
          }
        } else {
          setState(() {
            _activeIncident = false;
            _activeResponder = false;
          });
          _loadresponderTypes(false);
        }
      }
    }
  }

  Future<Uint8List> getBytesFromAsset(Uint8List path, int width) async {
    ui.Codec codec = await ui.instantiateImageCodec(path, targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  _createPolylines(LatLng responderLocation, int responderID) async {
    polylinePoints = PolylinePoints();
    polylineCoordinates = [];

    PolylineId id = PolylineId(responderID.toString());
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCxoOo7lNMaJJstAqdGZVsfjZa_BV0uHeM',
      PointLatLng(responderLocation.latitude, responderLocation.longitude),
      PointLatLng(_locationData.latitude, _locationData.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        if (point.latitude != _locationData.latitude &&
            point.longitude != _locationData.longitude)
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    Polyline polyline = Polyline(
      polylineId: id,
      color: Config.appColor,
      points: polylineCoordinates,
      width: 3,
    );

    setState(() {
      polylines[id] = polyline;
    });
    return;
  }

  _loadresponderTypes(bool load) async {
    if (load) Http().showLoadingOverlay(context);
    dynamic response = await Http(url: 'responderTypes').getWithHeader();
    if (response is String) {
      if (load) Navigator.pop(context);
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          backgroundColor: Color(0xFF323232),
          content: Text(response,
              textScaleFactor: .8,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Config.title * Config.textMultiplier,
                  fontFamily: 'Roboto'))));
      return;
    } else if (response is Response) {
      if (response.statusCode != 200) {
        if (load) Navigator.pop(context);
        try {
          Map<String, dynamic> body = json.decode(response.body);
          _scaffoldKey.currentState?.showSnackBar(SnackBar(
              backgroundColor: Color(0xFF323232),
              content: Text(
                  body.containsKey('errors')
                      ? jsonDecode(response.body)['errors'][
                              jsonDecode(response.body)['errors']
                                  .keys
                                  .toList()[0]][0]
                          .toString()
                      : (body['message'] ?? 'Something went wrong'),
                  textScaleFactor: .8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Config.title * Config.textMultiplier,
                      fontFamily: 'Roboto'))));
          return;
        } catch (error) {
          _scaffoldKey.currentState?.showSnackBar(SnackBar(
              backgroundColor: Color(0xFF323232),
              content: Text('Something went wrong',
                  textScaleFactor: .8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Config.title * Config.textMultiplier,
                      fontFamily: 'Roboto'))));
          return;
        }
      } else {
        // setState(() {
        //   _responderTypes = new List.from(json.decode(response.body));
        // });
        List.from(json.decode(response.body)).forEach((responderType) {
          database.insert(
              'responder_types',
              {
                'id': responderType['id'],
                'name': responderType['name'],
                'description': responderType['description'],
                'map_icon': responderType['map_icon'],
                'nav_icon': responderType['nav_icon'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace);
        });
        List<Map<String, dynamic>> resTypes =
            await database.query('responder_types');
        if (resTypes.isNotEmpty) {
          setState(() {
            _responderTypes = new List.from(resTypes);
          });
        }
        if (load) Navigator.pop(context);
      }
    }
  }

  _updateLatLng() async {
    dynamic response = await Http(
        url: 'residents/${_sharedPreferences.getInt('role-id')}',
        body: {
          'latitude': _locationData.latitude,
          'longitude': _locationData.longitude,
          'username': _sharedPreferences.getString('username'),
          'first_name': _sharedPreferences.getString('first_name'),
          'middle_name': _sharedPreferences.getString('middle_name'),
          'last_name': _sharedPreferences.getString('last_name'),
          'contact_number': _sharedPreferences.getString('contact_number'),
          'status': _sharedPreferences.getString('status'),
          'address': _sharedPreferences.getString('address'),
        }).putWithHeader();
    if (response is String) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF323232),
          content: Text(
            response,
            textScaleFactor: .8,
            style: TextStyle(
              color: Colors.white,
              fontSize: Config.title * Config.textMultiplier,
            ),
          ),
        ),
      );
    } else if (response is Response) {
      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF323232),
            content: Text(
              json.decode(response.body)['message'],
              textScaleFactor: .8,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: Config.title * Config.textMultiplier,
              ),
            ),
          ),
        );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     behavior: SnackBarBehavior.floating,
        //     backgroundColor: Color(0xFF323232),
        //     content: Text(
        //       'Updated',
        //       textScaleFactor: .8,
        //       style: TextStyle(
        //         fontFamily: 'Poppins',
        //         color: Colors.white,
        //         fontSize: Config. title * Config.textMultiplier,
        //       ),
        //     ),
        //   ),
        // );
      }
    }
    return;
  }

  _initFirebase() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['notif'] == 'false') {
        _checkActiveIncident(false);
      }
    });
  }

  _createEmergency(String name) async {
    Http().showLoadingOverlay(context);
    dynamic response = await Http(
        url: 'residents/${_sharedPreferences.getInt('role-id')}/incidents',
        body: {
          // 'incident_type_id': id,
          'type': name,
          'latitude': _locationData.latitude,
          'longitude': _locationData.longitude,
          'requested_at': DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now()),
          'description': 'none',
          'casualties': 0,
          'address': 'none',
          'others': 'none'
        }).postWithHeader();
    if (response is String) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF323232),
          content: Text(
            response,
            textScaleFactor: .8,
            style: TextStyle(
              color: Colors.white,
              fontSize: Config.title * Config.textMultiplier,
            ),
          ),
        ),
      );
    } else if (response is Response) {
      if (response.statusCode != 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF323232),
            content: Text(
              json.decode(response.body)['message'],
              textScaleFactor: .8,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: Config.title * Config.textMultiplier,
              ),
            ),
          ),
        );
      } else {
        setState(() {
          _activeIncident = true;
          _incidentID = json.decode(response.body)['id'];
        });
        Navigator.pop(context);
        _showSuccessDialog();
      }
    }
  }

  _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
              height: 40 * Config.imageSizeMultiplier,
              width: 20 * Config.imageSizeMultiplier,
              color: Colors.transparent,
              child: Center(
                  child: Container(
                      color: Colors.white,
                      height: 70 * Config.imageSizeMultiplier,
                      width: 70 * Config.imageSizeMultiplier,
                      padding: EdgeInsets.symmetric(
                          horizontal: 6 * Config.widthMultiplier),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'EMERGENCY REPORT SENT!',
                            textScaleFactor: .8,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Config.header * Config.textMultiplier,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Your report has been sent to the ZCDRRMO Operation Center. A dispatcher will contact you in a few minutes',
                            textScaleFactor: .8,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Config.title * Config.textMultiplier,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Config.appColor,
                            size: 15 * Config.imageSizeMultiplier,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 2 * Config.heightMultiplier,
                                  bottom: 1 * Config.heightMultiplier),
                              child: ButtonTheme(
                                  height: (DeviceUtil.isTablet ? 5 : 6) *
                                      Config.heightMultiplier,
                                  minWidth: (DeviceUtil.isTablet ? 10 : 16) *
                                      Config.widthMultiplier,
                                  child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: Config.appColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height: (DeviceUtil.isTablet ? 5 : 6) *
                                          Config.heightMultiplier,
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              2 * Config.widthMultiplier),
                                      child: Text(
                                        'OKAY',
                                        textScaleFactor: .8,
                                        style: TextStyle(
                                            fontSize: Config.title *
                                                Config.textMultiplier,
                                            color: Colors.white),
                                      )))),
                        ],
                      )))),
        ),
      ),
    );
  }

  _uploadImages() async {
    Http().showLoadingOverlay(context);
    dynamic response = await Http(url: 'incidents/$_incidentID', body: {
      'image':
          "data:image/png;base64,${base64.encode(_imageFile.readAsBytesSync())}",
    }).putWithHeader();
    print(response.request);
    if (response is String) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF323232),
          content: Text(
            response,
            textScaleFactor: .8,
            style: TextStyle(
              color: Colors.white,
              fontSize: Config.title * Config.textMultiplier,
            ),
          ),
        ),
      );
    } else if (response is Response) {
      if (response.statusCode != 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF323232),
            content: Text(
              json.decode(response.body)['message'],
              textScaleFactor: .8,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: Config.title * Config.textMultiplier,
              ),
            ),
          ),
        );
      } else {
        setState(() {
          _uploaded = true;
        });
        Navigator.pop(context);
      }
    }
  }

  _showChoiceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Material(
        color: Colors.transparent,
        child: Container(
            height: 20 * Config.imageSizeMultiplier,
            width: 30 * Config.imageSizeMultiplier,
            color: Colors.transparent,
            child: Center(
                child: Container(
                    color: Colors.white,
                    height: 50 * Config.imageSizeMultiplier,
                    width: 80 * Config.imageSizeMultiplier,
                    padding: EdgeInsets.symmetric(
                        horizontal: 6 * Config.widthMultiplier),
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: 2 * Config.heightMultiplier),
                              child: Text(
                                'Choose Action',
                                textScaleFactor: .8,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        Config.header * Config.textMultiplier,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ImagePicker.pickImage(
                                              source: ImageSource.gallery)
                                          .then((file) {
                                        setState(() {
                                          _imageFile = file;
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 14 * Config.imageSizeMultiplier,
                                      width: 14 * Config.imageSizeMultiplier,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Config.appColor),
                                      child: Icon(
                                        Icons.image_rounded,
                                        color: Colors.white,
                                        size: 8 * Config.imageSizeMultiplier,
                                      ),
                                    )),
                                Text(
                                  'Upload picture',
                                  textScaleFactor: .8,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          Config.title * Config.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ]),
                              Column(children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ImagePicker.pickImage(
                                              source: ImageSource.camera)
                                          .then((file) {
                                        setState(() {
                                          _imageFile = file;
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 14 * Config.imageSizeMultiplier,
                                      width: 14 * Config.imageSizeMultiplier,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Config.appColor),
                                      child: Icon(
                                        Icons.camera_rounded,
                                        color: Colors.white,
                                        size: 8 * Config.imageSizeMultiplier,
                                      ),
                                    )),
                                Text(
                                  'Take a picture',
                                  textScaleFactor: .8,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          Config.title * Config.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ]),
                            ],
                          )
                        ])))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldMessenger(
          key: _scaffoldKey,
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (_loggedIn != null && !_activeIncident)
                if (_loggedIn)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back,',
                              textScaleFactor: .8,
                              style: TextStyle(
                                  fontSize:
                                      Config.title * Config.textMultiplier,
                                  color: Colors.black54),
                            ),
                            Text(
                              _username,
                              textScaleFactor: .8,
                              style: TextStyle(
                                  fontSize:
                                      Config.subheader * Config.textMultiplier,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                      Spacer(),
                      Container(
                        height: 14 * Config.imageSizeMultiplier,
                        width: 14 * Config.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Config.appColor,
                        ),
                        child: Icon(Icons.person_rounded, color: Colors.white),
                      )
                    ],
                  ),
              if (_loggedIn != null && !_activeIncident)
                Padding(
                    padding: EdgeInsets.only(
                        top: (DeviceUtil.isTablet ? 8 : 20) *
                            Config.heightMultiplier),
                    child: Text(
                      'Do you want to report an emergency?',
                      textScaleFactor: .8,
                      style: TextStyle(
                          fontSize: Config.subheader * Config.textMultiplier,
                          fontWeight: FontWeight.bold),
                    )),
              if (_loggedIn != null && !_activeIncident)
                if (_loggedIn)
                  Padding(
                      padding: EdgeInsets.only(
                          top: (DeviceUtil.isTablet ? 1 : 1) *
                              Config.heightMultiplier),
                      child: Text(
                        'Press the button to call for help from the nearest emergency response team',
                        textScaleFactor: .8,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Config.title * Config.textMultiplier,
                        ),
                      )),
              if (_loggedIn != null && !_activeIncident)
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 2 * Config.heightMultiplier),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (_loggedIn)
                              for (dynamic responderType in _responderTypes)
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1 * Config.heightMultiplier),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            maximumSize:
                                                MaterialStateProperty.all(
                                                    Size.fromWidth(86 *
                                                        Config
                                                            .widthMultiplier)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Config.appColor)),
                                        onPressed: () {
                                          _createEmergency(
                                              responderType['name']);
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 14 *
                                                    Config.imageSizeMultiplier,
                                                width: 14 *
                                                    Config.imageSizeMultiplier,
                                                margin: EdgeInsets.only(
                                                    right: 4 *
                                                        Config.widthMultiplier,
                                                    top: 2 *
                                                        Config.heightMultiplier,
                                                    bottom: 2 *
                                                        Config
                                                            .heightMultiplier),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            (DeviceUtil.isTablet
                                                                    ? 2
                                                                    : 3) *
                                                                Config
                                                                    .widthMultiplier)),
                                                    color: Colors.white),
                                                child: Icon(
                                                  MdiIcons.fromString(
                                                      responderType['nav_icon']
                                                          .substring(
                                                              4,
                                                              responderType[
                                                                      'nav_icon']
                                                                  .length)),
                                                  color: Config.appColor,
                                                )
                                                // child: Image.network(responderType['image'])
                                                ),
                                            Expanded(
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            responderType[
                                                                'name'],
                                                            textScaleFactor: .8,
                                                            style: TextStyle(
                                                                fontSize: Config
                                                                        .title *
                                                                    Config
                                                                        .textMultiplier,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 0.5 *
                                                                        Config
                                                                            .heightMultiplier),
                                                            child: Text(
                                                              responderType[
                                                                  'description'],
                                                              textScaleFactor:
                                                                  .8,
                                                              style: TextStyle(
                                                                  fontSize: Config
                                                                          .subtitle *
                                                                      Config
                                                                          .textMultiplier,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )
                                                        ]))),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                            )
                                          ],
                                        )))
                            else
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 2 * Config.heightMultiplier,
                                    bottom: 1 * Config.heightMultiplier,
                                    left: 10 * Config.widthMultiplier,
                                    right: 10 * Config.widthMultiplier),
                                child: ButtonTheme(
                                  height: (DeviceUtil.isTablet ? 5 : 6) *
                                      Config.heightMultiplier,
                                  minWidth: double.infinity,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .leftToRight,
                                              child: LoginScreen(
                                                  successreg: false)));
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side: BorderSide(color: Config.appColor),
                                    ),
                                    height: (DeviceUtil.isTablet ? 5 : 6) *
                                        Config.heightMultiplier,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2 * Config.widthMultiplier),
                                    child: Text(
                                      'Login to report an emergency',
                                      textScaleFactor: .8,
                                      style: TextStyle(
                                          fontSize: Config.title *
                                              Config.textMultiplier,
                                          color: Config.appColor),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )),
                ),
              if (_loggedIn != null && _activeIncident)
                TextButton(
                    onPressed: () async {
                      reset('');
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2 * Config.widthMultiplier),
                              height: 5 * Config.heightMultiplier,
                              width: 20 * Config.widthMultiplier,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          2 * Config.widthMultiplier),
                                      bottomLeft: Radius.circular(
                                          2 * Config.widthMultiplier)),
                                  border: Border.all(color: Config.appColor)),
                              child: Text(
                                'Refresh',
                                textScaleFactor: 0.8,
                                style: TextStyle(
                                    fontSize:
                                        Config.title * Config.textMultiplier),
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2 * Config.widthMultiplier),
                            height: 5 * Config.heightMultiplier,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        2 * Config.widthMultiplier),
                                    bottomRight: Radius.circular(
                                        2 * Config.widthMultiplier)),
                                border: Border.all(color: Config.appColor)),
                            child: Icon(
                              Icons.refresh,
                              color: Config.appColor,
                            ),
                          )
                        ])),
              if (_loggedIn != null && _activeIncident && !_activeResponder)
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                      if (!_activeResponder)
                        Container(
                          child: AvatarGlow(
                            glowColor: Config.appColor.withOpacity(0.8),
                            endRadius: (DeviceUtil.isTablet ? 8 : 24) *
                                Config.heightMultiplier,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 100),
                            child: ButtonTheme(
                                height: (DeviceUtil.isTablet ? 20 : 46) *
                                    Config.imageSizeMultiplier,
                                minWidth: (DeviceUtil.isTablet ? 20 : 46) *
                                    Config.imageSizeMultiplier,
                                child: MaterialButton(
                                    onPressed: () {
                                      // _showEmergencyModal();
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          100 * Config.widthMultiplier),
                                    ),
                                    color: Config.appColor,
                                    child: Text(
                                      'Waiting...',
                                      textScaleFactor: .8,
                                      style: TextStyle(
                                          fontSize: Config.subheader *
                                              Config.textMultiplier,
                                          color: Colors.white),
                                    ))),
                          ),
                        ),
                      if (_image == null && _imageFile == null)
                        Text(
                          'You may choose to upload or take image of the incident to report while waiting for the responder to arrive',
                          textScaleFactor: .8,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Config.title * Config.textMultiplier,
                              color: Colors.black),
                        ),
                      if (_image == null && _imageFile == null)
                        TextButton(
                            onPressed: () async {
                              _showChoiceDialog();
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              2 * Config.widthMultiplier),
                                      height: 5 * Config.heightMultiplier,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  2 * Config.widthMultiplier),
                                              bottomLeft: Radius.circular(
                                                  2 * Config.widthMultiplier)),
                                          border: Border.all(
                                              color: Config.appColor)),
                                      child: Text(
                                        'Choose Image',
                                        textScaleFactor: 0.8,
                                        style: TextStyle(
                                            fontSize: Config.title *
                                                Config.textMultiplier),
                                      )),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2 * Config.widthMultiplier),
                                    height: 5 * Config.heightMultiplier,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                2 * Config.widthMultiplier),
                                            bottomRight: Radius.circular(
                                                2 * Config.widthMultiplier)),
                                        border:
                                            Border.all(color: Config.appColor)),
                                    child: Icon(
                                      Icons.image,
                                      color: Config.appColor,
                                    ),
                                  )
                                ])),
                      if (_image != null && !_activeResponder)
                        Container(
                            margin: EdgeInsets.only(
                                right: 1 * Config.widthMultiplier),
                            height: 30 * Config.imageSizeMultiplier,
                            width: 50 * Config.imageSizeMultiplier,
                            child: Image.memory(_image,
                                fit: BoxFit.cover,
                                width: 50 * Config.imageSizeMultiplier)),
                      if (_imageFile != null && !_activeResponder)
                        Container(
                            margin: EdgeInsets.only(
                                right: 1 * Config.widthMultiplier),
                            height: 30 * Config.imageSizeMultiplier,
                            width: 50 * Config.imageSizeMultiplier,
                            child: Image.file(
                              _imageFile,
                              fit: BoxFit.cover,
                              width: 50 * Config.imageSizeMultiplier,
                            )),
                      if ((_image != null || _imageFile != null) &&
                          !_uploaded &&
                          !_activeResponder)
                        TextButton(
                            onPressed: () async {
                              _uploadImages();
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              2 * Config.widthMultiplier),
                                      height: 5 * Config.heightMultiplier,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  2 * Config.widthMultiplier),
                                              bottomLeft: Radius.circular(
                                                  2 * Config.widthMultiplier)),
                                          border: Border.all(
                                              color: Config.appColor)),
                                      child: Text(
                                        'Upload Image',
                                        textScaleFactor: 0.8,
                                        style: TextStyle(
                                            fontSize: Config.title *
                                                Config.textMultiplier),
                                      )),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2 * Config.widthMultiplier),
                                    height: 5 * Config.heightMultiplier,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                2 * Config.widthMultiplier),
                                            bottomRight: Radius.circular(
                                                2 * Config.widthMultiplier)),
                                        border:
                                            Border.all(color: Config.appColor)),
                                    child: Icon(
                                      Icons.upload,
                                      color: Config.appColor,
                                    ),
                                  )
                                ])),
                      if (_uploaded && !_activeResponder)
                        Text(
                          'Image Uploaded!',
                          textScaleFactor: 0.8,
                          style: TextStyle(
                              fontSize: Config.title * Config.textMultiplier,
                              color: Colors.black),
                        )
                    ]))),
              if (_loggedIn != null && _activeIncident && _activeResponder)
                Expanded(
                    child: Padding(
                        padding:
                            EdgeInsets.only(top: 2 * Config.heightMultiplier),
                        child: GoogleMap(
                          polylines: Set<Polyline>.of(polylines.values),
                          onTap: (latlng) {},
                          markers: _markers,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                          zoomGesturesEnabled: true,
                          gestureRecognizers: Set()
                            ..add(Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer())),
                          mapType: MapType.terrain,
                          initialCameraPosition: _userCameraPosition ??
                              CameraPosition(
                                target: _locationData == null
                                    ? LatLng(6.9041682, 122.0757389)
                                    : LatLng(_locationData.latitude,
                                        _locationData.longitude),
                                zoom: 15,
                              ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                            setState(() {
                              _googleMapController = controller;
                            });
                          },
                        )))
            ],
          ))),
    );
  }
}
