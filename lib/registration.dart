// @dart=2.9
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/default/http.dart';
import 'default/location.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final String number;
  final String image;
  RegistrationScreen({Key key, this.number, this.image}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  LocationData _locationData;

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _middlenameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  FocusNode _middlenameFocus = FocusNode();
  FocusNode _lastnameFocus = FocusNode();
  FocusNode _usernameFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    _configure();
  }

  _configure() async {
    _getLocation();
  }

  _getLocation() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Http().showLoadingOverlay(context);
    });
    dynamic data = await CustomLocator().getLocation();
    if (data != 'Service not enabled' && data != 'Permission denied') {
      setState(() {
        _locationData = data;
      });
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
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

  _check() async {
    FocusScope.of(context).unfocus();
    if (_firstnameController.text.isNotEmpty &&
        _lastnameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
      _register();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF323232),
          content: Text(
            'Fill up fields properly',
            textScaleFactor: .8,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: Config.title * Config.textMultiplier,
            ),
          ),
        ),
      );
    }
  }

  _register() async {
    Http().showLoadingOverlay(context);
    Map requestBody = {
      'first_name': _firstnameController.text,
      'last_name': _lastnameController.text,
      'contact_number': widget.number,
      'username': _usernameController.text,
      'password': _passwordController.text,
      'address': _addressController.text,
      'latitude': _locationData.latitude,
      'longitude': _locationData.longitude,
      'status': 'PENDING',
      // 'valid_id': "data:image/png;base64,${widget.image}"
    };
    if (_middlenameController.text.isNotEmpty)
      requestBody.addAll({'middle_name': _middlenameController.text});
    dynamic response =
        await Http(url: 'register/resident', body: requestBody).postNoHeader();
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
      dynamic body = json.decode(response.body);
      if (response.statusCode != 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF323232),
            content: Text(
              body.runtimeType == String
                  ? body
                  : body['errors'][body['errors'].keys.first][0],
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
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                child: LoginScreen(successreg: true)),
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldMessenger(
          key: _scaffoldKey,
          child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: (DeviceUtil.isTablet ? 20 : 10) *
                          Config.widthMultiplier,
                      vertical: 2 * Config.heightMultiplier),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'First Name',
                            textScaleFactor: .8,
                            style: TextStyle(
                                fontSize: Config.title * Config.textMultiplier),
                          )),
                      Container(
                          height: (DeviceUtil.isTablet ? 5 : 6) *
                              Config.heightMultiplier,
                          margin: EdgeInsets.only(
                              top: 1 * Config.heightMultiplier,
                              bottom: 1 * Config.heightMultiplier),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2 * Config.widthMultiplier),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  (DeviceUtil.isTablet ? 2 : 3) *
                                      Config.widthMultiplier)),
                              border: Border.all(color: Colors.black)),
                          child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: .8),
                              child: TextFormField(
                                controller: _firstnameController,
                                onFieldSubmitted: (string) {
                                  FocusScope.of(context)
                                      .requestFocus(_middlenameFocus);
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'First Name',
                                    hintStyle: TextStyle(
                                        fontSize: Config.title *
                                            Config.textMultiplier)),
                                style: TextStyle(
                                    fontSize:
                                        Config.title * Config.textMultiplier),
                              ))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Middle Name',
                            textScaleFactor: .8,
                            style: TextStyle(
                                fontSize: Config.title * Config.textMultiplier),
                          )),
                      Container(
                          height: (DeviceUtil.isTablet ? 5 : 6) *
                              Config.heightMultiplier,
                          margin: EdgeInsets.only(
                              top: 1 * Config.heightMultiplier,
                              bottom: 1 * Config.heightMultiplier),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2 * Config.widthMultiplier),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  (DeviceUtil.isTablet ? 2 : 3) *
                                      Config.widthMultiplier)),
                              border: Border.all(color: Colors.black)),
                          child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: .8),
                              child: TextFormField(
                                controller: _middlenameController,
                                focusNode: _middlenameFocus,
                                onFieldSubmitted: (string) {
                                  FocusScope.of(context)
                                      .requestFocus(_lastnameFocus);
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: 'Middle Name',
                                  hintStyle: TextStyle(
                                      fontSize:
                                          Config.title * Config.textMultiplier),
                                ),
                                style: TextStyle(
                                    fontSize:
                                        Config.title * Config.textMultiplier),
                              ))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Last Name',
                            textScaleFactor: .8,
                            style: TextStyle(
                                fontSize: Config.title * Config.textMultiplier),
                          )),
                      Container(
                          height: (DeviceUtil.isTablet ? 5 : 6) *
                              Config.heightMultiplier,
                          margin: EdgeInsets.only(
                              top: 1 * Config.heightMultiplier,
                              bottom: 1 * Config.heightMultiplier),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2 * Config.widthMultiplier),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  (DeviceUtil.isTablet ? 2 : 3) *
                                      Config.widthMultiplier)),
                              border: Border.all(color: Colors.black)),
                          child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: .8),
                              child: TextFormField(
                                controller: _lastnameController,
                                focusNode: _lastnameFocus,
                                onFieldSubmitted: (string) {
                                  FocusScope.of(context)
                                      .requestFocus(_addressFocus);
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: 'Last Name',
                                  hintStyle: TextStyle(
                                      fontSize:
                                          Config.title * Config.textMultiplier),
                                ),
                                style: TextStyle(
                                    fontSize:
                                        Config.title * Config.textMultiplier),
                              ))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Address',
                            textScaleFactor: .8,
                            style: TextStyle(
                                fontSize: Config.title * Config.textMultiplier),
                          )),
                      Container(
                          height: (DeviceUtil.isTablet ? 5 : 6) *
                              Config.heightMultiplier,
                          margin: EdgeInsets.only(
                              top: 1 * Config.heightMultiplier,
                              bottom: 1 * Config.heightMultiplier),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2 * Config.widthMultiplier),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  (DeviceUtil.isTablet ? 2 : 3) *
                                      Config.widthMultiplier)),
                              border: Border.all(color: Colors.black)),
                          child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: .8),
                              child: TextFormField(
                                controller: _addressController,
                                focusNode: _addressFocus,
                                onFieldSubmitted: (string) {
                                  FocusScope.of(context)
                                      .requestFocus(_usernameFocus);
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: 'Address',
                                  hintStyle: TextStyle(
                                      fontSize:
                                          Config.title * Config.textMultiplier),
                                ),
                                style: TextStyle(
                                    fontSize:
                                        Config.title * Config.textMultiplier),
                              ))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            textScaleFactor: .8,
                            style: TextStyle(
                                fontSize: Config.title * Config.textMultiplier),
                          )),
                      Container(
                          height: (DeviceUtil.isTablet ? 5 : 6) *
                              Config.heightMultiplier,
                          margin: EdgeInsets.only(
                              top: 1 * Config.heightMultiplier,
                              bottom: 1 * Config.heightMultiplier),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2 * Config.widthMultiplier),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  (DeviceUtil.isTablet ? 2 : 3) *
                                      Config.widthMultiplier)),
                              border: Border.all(color: Colors.black)),
                          child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: .8),
                              child: TextFormField(
                                controller: _usernameController,
                                focusNode: _usernameFocus,
                                onFieldSubmitted: (string) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocus);
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                      fontSize:
                                          Config.title * Config.textMultiplier),
                                ),
                                style: TextStyle(
                                    fontSize:
                                        Config.title * Config.textMultiplier),
                              ))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            textScaleFactor: .8,
                            style: TextStyle(
                                fontSize: Config.title * Config.textMultiplier),
                          )),
                      Container(
                          height: (DeviceUtil.isTablet ? 5 : 6) *
                              Config.heightMultiplier,
                          margin: EdgeInsets.only(
                              top: 1 * Config.heightMultiplier,
                              bottom: 1 * Config.heightMultiplier),
                          padding: EdgeInsets.symmetric(
                              horizontal: 2 * Config.widthMultiplier),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  (DeviceUtil.isTablet ? 2 : 3) *
                                      Config.widthMultiplier)),
                              border: Border.all(color: Colors.black)),
                          child: Row(children: [
                            Expanded(
                                child: MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(textScaleFactor: .8),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      focusNode: _passwordFocus,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            fontSize: Config.title *
                                                Config.textMultiplier),
                                      ),
                                      obscureText: _hidePassword,
                                      style: TextStyle(
                                          fontSize: Config.title *
                                              Config.textMultiplier),
                                    ))),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _hidePassword = !_hidePassword;
                                  });
                                },
                                icon: Icon(_hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off))
                          ])),
                      Padding(
                          padding: EdgeInsets.only(
                              top: 2 * Config.heightMultiplier,
                              bottom: 1 * Config.heightMultiplier),
                          child: ButtonTheme(
                              height: (DeviceUtil.isTablet ? 5 : 6) *
                                  Config.heightMultiplier,
                              minWidth: double.infinity,
                              child: MaterialButton(
                                  onPressed: () {
                                    _check();
                                  },
                                  color: Config.appColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  height: (DeviceUtil.isTablet ? 5 : 6) *
                                      Config.heightMultiplier,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2 * Config.widthMultiplier),
                                  child: Text(
                                    'Register',
                                    textScaleFactor: .8,
                                    style: TextStyle(
                                        fontSize: Config.title *
                                            Config.textMultiplier,
                                        color: Colors.white),
                                  )))),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      )
                    ],
                  ))))),
    );
  }
}
