// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zamboangaemergency/registration.dart';

import 'default/config.dart';

String OTPCode = '';

class ValidIDScreen extends StatefulWidget {
  final String number;
  ValidIDScreen({Key key, this.number}) : super(key: key);
  @override
  _ValidIDScreenState createState() => _ValidIDScreenState();
}

class _ValidIDScreenState extends State<ValidIDScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  TextEditingController _codeController = TextEditingController();
  File _image;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8 * Config.widthMultiplier),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 2 * Config.heightMultiplier),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Valid ID',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Config.subheader *
                                            Config.textMultiplier,
                                        fontWeight: FontWeight.bold,
                                      )))),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 1 * Config.heightMultiplier),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Please upload a valid ID to proceed',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Config.title *
                                            Config.textMultiplier,
                                        fontWeight: FontWeight.normal,
                                      )))),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 4 * Config.heightMultiplier),
                              child: TextButton(
                                  onPressed: () async {
                                    ImagePicker.pickImage(
                                            source: ImageSource.gallery)
                                        .then((file) {
                                      setState(() {
                                        _image = file;
                                      });
                                    });
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    2 * Config.widthMultiplier),
                                            height: 4 * Config.heightMultiplier,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(2 *
                                                        Config.widthMultiplier),
                                                    bottomLeft: Radius.circular(2 *
                                                        Config
                                                            .widthMultiplier)),
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
                                              horizontal:
                                                  2 * Config.widthMultiplier),
                                          height: 4 * Config.heightMultiplier,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(2 *
                                                      Config.widthMultiplier),
                                                  bottomRight: Radius.circular(
                                                      2 *
                                                          Config
                                                              .widthMultiplier)),
                                              border: Border.all(
                                                  color: Config.appColor)),
                                          child: Icon(
                                            Icons.image,
                                            color: Config.appColor,
                                          ),
                                        )
                                      ]))),
                          if (_image != null)
                            Container(
                                height: 40 * Config.heightMultiplier,
                                child: Image.file(_image)),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 4 * Config.heightMultiplier),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Ink(
                                        height: 6 * Config.heightMultiplier,
                                        width: 40 * Config.widthMultiplier,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            // _sendCode();
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Config.appColor),
                                              shadowColor:
                                                  MaterialStateProperty.all(
                                                      Config.appColor),
                                              alignment: Alignment.center,
                                              // padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 4 * Config.widthMultiplier, horizontal: 10 * Config.widthMultiplier)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(1 *
                                                              Config
                                                                  .imageSizeMultiplier)))),
                                          child: Text('Back',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Config.title *
                                                    Config.textMultiplier,
                                                fontWeight: FontWeight.normal,
                                              )),
                                        )),
                                    Ink(
                                        height: 6 * Config.heightMultiplier,
                                        width: 40 * Config.widthMultiplier,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: RegistrationScreen(
                                                      number: widget.number,
                                                      image: base64.encode(_image
                                                          .readAsBytesSync())),
                                                ));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Config.appColor),
                                              shadowColor:
                                                  MaterialStateProperty.all(
                                                      Config.appColor),
                                              alignment: Alignment.center,
                                              // padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 4 * Config.widthMultiplier, horizontal: 10 * Config.widthMultiplier)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(1 *
                                                              Config
                                                                  .imageSizeMultiplier)))),
                                          child: Text('Next',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Config.title *
                                                    Config.textMultiplier,
                                                fontWeight: FontWeight.normal,
                                              )),
                                        )),
                                  ]))
                        ])))));
  }
}
