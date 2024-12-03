// @dart=2.9
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zamboangaemergency/default/config.dart';

class DetailedHotlinesScreen extends StatefulWidget {
  final String details;

  DetailedHotlinesScreen({Key key, this.details}) : super(key: key);
  @override
  _DetailedHotlinesScreenState createState() => _DetailedHotlinesScreenState();
}

class _DetailedHotlinesScreenState extends State<DetailedHotlinesScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  Telephony telephony = Telephony.instance;

  _showChoiceDialog(String number) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Material(
        color: Colors.transparent,
        child: Container(
            height: 20 * Config.imageSizeMultiplier,
            width: 20 * Config.imageSizeMultiplier,
            color: Colors.transparent,
            child: Center(
                child: Container(
                    color: Colors.white,
                    height: 50 * Config.imageSizeMultiplier,
                    width: 60 * Config.imageSizeMultiplier,
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
                                      // _showMessagingDialog('09752974512');
                                      _showMessagingDialog(number);
                                    },
                                    child: Container(
                                      height: 14 * Config.imageSizeMultiplier,
                                      width: 14 * Config.imageSizeMultiplier,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Config.appColor),
                                      child: Icon(
                                        Icons.message_rounded,
                                        color: Colors.white,
                                        size: 8 * Config.imageSizeMultiplier,
                                      ),
                                    )),
                                Text(
                                  'Send SMS',
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
                                      Uri url =
                                          Uri(scheme: "tel", path: number);
                                      if (canLaunchUrlString(url.toString()) !=
                                          null) {
                                        launchUrlString(url.toString());
                                      } else {}
                                    },
                                    child: Container(
                                      height: 14 * Config.imageSizeMultiplier,
                                      width: 14 * Config.imageSizeMultiplier,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Config.appColor),
                                      child: Icon(
                                        Icons.phone_enabled_rounded,
                                        color: Colors.white,
                                        size: 8 * Config.imageSizeMultiplier,
                                      ),
                                    )),
                                Text(
                                  'Call Hotline',
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

  _showMessagingDialog(String number) {
    TextEditingController _message = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Material(
        color: Colors.transparent,
        child: Container(
            height: 40 * Config.imageSizeMultiplier,
            width: 20 * Config.imageSizeMultiplier,
            color: Colors.transparent,
            child: Center(
                child: Container(
                    color: Colors.white,
                    height: 70 * Config.imageSizeMultiplier,
                    width: 80 * Config.imageSizeMultiplier,
                    padding: EdgeInsets.symmetric(
                        horizontal: 6 * Config.widthMultiplier),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Enter your message!',
                          textScaleFactor: .8,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Config.header * Config.textMultiplier,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Note: This messaging service uses your default Sim to send a message. Data charges will apply',
                          textScaleFactor: .8,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Config.title * Config.textMultiplier,
                              color: Colors.black45,
                              fontWeight: FontWeight.normal),
                        ),
                        Container(
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
                                  controller: _message,
                                  maxLines: 3,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'Message',
                                      hintStyle: TextStyle(
                                          fontSize: Config.title *
                                              Config.textMultiplier)),
                                  style: TextStyle(
                                      fontSize:
                                          Config.title * Config.textMultiplier),
                                ))),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 1 * Config.heightMultiplier,
                                bottom: 1 * Config.heightMultiplier),
                            child: ButtonTheme(
                                height: (DeviceUtil.isTablet ? 5 : 6) *
                                    Config.heightMultiplier,
                                minWidth: (DeviceUtil.isTablet ? 10 : 16) *
                                    Config.widthMultiplier,
                                child: MaterialButton(
                                    onPressed: () {
                                      telephony.sendSms(
                                          to: number,
                                          message: _message.text,
                                          statusListener: (SendStatus status) {
                                            if (status == SendStatus.SENT) {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Color(0xFF323232),
                                                      content: Text(
                                                          'Message sent!',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              fontFamily:
                                                                  'Poppins'))));
                                            }
                                          });
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
                                      'SEND',
                                      textScaleFactor: .8,
                                      style: TextStyle(
                                          fontSize: Config.title *
                                              Config.textMultiplier,
                                          color: Colors.white),
                                    )))),
                      ],
                    )))),
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
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2 * Config.heightMultiplier),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 2 * Config.heightMultiplier),
                            child: Text(
                              widget.details,
                              textScaleFactor: .8,
                              style: TextStyle(
                                  fontSize:
                                      Config.header * Config.textMultiplier,
                                  color: Config.appColor,
                                  fontWeight: FontWeight.bold),
                            ))),
                    if (widget.details == '911/117')
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'Hotlines',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Column(children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    onPressed: () {
                                                      Uri url = Uri(
                                                          scheme: "tel",
                                                          path: '062992 3187');
                                                      if (canLaunchUrl(url) !=
                                                          null) {
                                                        launchUrl(url);
                                                      } else {}
                                                    },
                                                    child: Text(
                                                      '992 3187',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    onPressed: () {
                                                      Uri url = Uri(
                                                          scheme: "tel",
                                                          path: '062992 3164');
                                                      if (canLaunchUrl(url) !=
                                                          null) {
                                                        launchUrl(url);
                                                      } else {}
                                                    },
                                                    child: Text(
                                                      '992 3164',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '992 3187',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062992 3187');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])
                                          ],
                                        ))
                                  ]))),
                    if (widget.details == 'ZCDRRMO Hotlines')
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'ZCDRRMO Operations',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Column(children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '955 9601',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062955 9601');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '926 1848',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062926 1848');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '926 1849',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062926 1849');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '990 1171',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062990 1171');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'COVID19 Transport',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '0926 091 2492',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    _showChoiceDialog(
                                                        '0926 091 2492');
                                                  },
                                                ))
                                          ])),
                                ],
                              ))),
                    if (widget.details == 'Police Stations')
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'Zamboanga City Police Office',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '0977 855 8138',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    _showChoiceDialog(
                                                        '0977 855 8138');
                                                  },
                                                ))
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 1 Vitali ',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '0935 604 4139',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    _showChoiceDialog(
                                                        '0935 604 4139');
                                                  },
                                                ))
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 2 Curuan',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '0935 457 2483',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    _showChoiceDialog(
                                                        '0935 457 2483');
                                                  },
                                                )),
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 3 Sangali',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                      ),
                                                      child: Text(
                                                        '955 0156',
                                                        textScaleFactor: .8,
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                    .subheader *
                                                                Config
                                                                    .textMultiplier,
                                                            color: Config
                                                                .appColor),
                                                      ),
                                                      onPressed: () {
                                                        Uri url = Uri(
                                                            scheme: "tel",
                                                            path: '0629550156');
                                                        if (canLaunchUrlString(
                                                                url.toString()) !=
                                                            null) {
                                                          launchUrlString(
                                                              url.toString());
                                                        } else {}
                                                      }),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier),
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                      ),
                                                      child: Text(
                                                        '0917 146 2240',
                                                        textScaleFactor: .8,
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                    .subheader *
                                                                Config
                                                                    .textMultiplier,
                                                            color: Config
                                                                .appColor),
                                                      ),
                                                      onPressed: () {
                                                        _showChoiceDialog(
                                                            '0917 146 2240');
                                                      },
                                                    )),
                                              ],
                                            )
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 4 Culianan',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier),
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                      ),
                                                      child: Text(
                                                        '955 0255',
                                                        textScaleFactor: .8,
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                    .subheader *
                                                                Config
                                                                    .textMultiplier,
                                                            color: Config
                                                                .appColor),
                                                      ),
                                                      onPressed: () {
                                                        Uri url = Uri(
                                                            scheme: "tel",
                                                            path:
                                                                '062955 0255');
                                                        if (canLaunchUrlString(
                                                                url.toString()) !=
                                                            null) {
                                                          launchUrlString(
                                                              url.toString());
                                                        } else {}
                                                      },
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier),
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                      ),
                                                      child: Text(
                                                        '0975 333 8826',
                                                        textScaleFactor: .8,
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                    .subheader *
                                                                Config
                                                                    .textMultiplier,
                                                            color: Config
                                                                .appColor),
                                                      ),
                                                      onPressed: () {
                                                        _showChoiceDialog(
                                                            '0975 333 8826');
                                                      },
                                                    )),
                                              ],
                                            )
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 5 Divisoria',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier),
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                      ),
                                                      child: Text(
                                                        '955 6887',
                                                        textScaleFactor: .8,
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                    .subheader *
                                                                Config
                                                                    .textMultiplier,
                                                            color: Config
                                                                .appColor),
                                                      ),
                                                      onPressed: () {
                                                        Uri url = Uri(
                                                            scheme: "tel",
                                                            path:
                                                                '062955 6887');
                                                        if (canLaunchUrlString(
                                                                url.toString()) !=
                                                            null) {
                                                          launchUrlString(
                                                              url.toString());
                                                        } else {}
                                                      },
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier),
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                      ),
                                                      child: Text(
                                                        '0917 677 8907',
                                                        textScaleFactor: .8,
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                    .subheader *
                                                                Config
                                                                    .textMultiplier,
                                                            color: Config
                                                                .appColor),
                                                      ),
                                                      onPressed: () {
                                                        _showChoiceDialog(
                                                            '0917 677 8907');
                                                      },
                                                    )),
                                              ],
                                            )
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 6 Tetuan',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '991 0678',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      Uri url = Uri(
                                                          scheme: "tel",
                                                          path: '062991 0678');
                                                      if (canLaunchUrlString(
                                                              url.toString()) !=
                                                          null) {
                                                        launchUrlString(
                                                            url.toString());
                                                      } else {}
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0997 746 5666',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0997 746 5666');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 7 Sta. Maria',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '985 1001',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      Uri url = Uri(
                                                          scheme: "tel",
                                                          path: '062985 1001');
                                                      if (canLaunchUrlString(
                                                              url.toString()) !=
                                                          null) {
                                                        launchUrlString(
                                                            url.toString());
                                                      } else {}
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0917 307 8098',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0917 307 8098');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 8 Sinunuc',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '0906 853 9806',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    _showChoiceDialog(
                                                        '0906 853 9806');
                                                  },
                                                ))
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 9 Ayala',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '982 0001',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      Uri url = Uri(
                                                          scheme: "tel",
                                                          path: '062982 0001');
                                                      if (canLaunchUrlString(
                                                              url.toString()) !=
                                                          null) {
                                                        launchUrlString(
                                                            url.toString());
                                                      } else {}
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier),
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                      ),
                                                      child: Text(
                                                        '0998 967 3931',
                                                        textScaleFactor: .8,
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                    .subheader *
                                                                Config
                                                                    .textMultiplier,
                                                            color: Config
                                                                .appColor),
                                                      ),
                                                      onPressed: () {
                                                        _showChoiceDialog(
                                                            '0998 967 3931');
                                                      },
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier),
                                                    child: TextButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                      ),
                                                      child: Text(
                                                        '0917 864 8553',
                                                        textScaleFactor: .8,
                                                        style: TextStyle(
                                                            fontSize: Config
                                                                    .subheader *
                                                                Config
                                                                    .textMultiplier,
                                                            color: Config
                                                                .appColor),
                                                      ),
                                                      onPressed: () {
                                                        _showChoiceDialog(
                                                            '0917 864 8553');
                                                      },
                                                    ))
                                              ],
                                            )
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 10 Labuan',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '0917 309 3887',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    _showChoiceDialog(
                                                        '0917 309 3887');
                                                  },
                                                ))
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'PS - 11 Central',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '0917 701 6340',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    _showChoiceDialog(
                                                        '0917 701 6340');
                                                  },
                                                ))
                                          ])),
                                ],
                              ))),
                    if (widget.details == 'Ambulances')
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Philippine Red Cross',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0916 587 3555',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0916 587 3555');
                                                    },
                                                  ))
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Rescue 2',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '991 2471',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062991 2471');
                                                          if (canLaunchUrlString(
                                                                  url.toString()) !=
                                                              null) {
                                                            launchUrlString(
                                                                url.toString());
                                                          } else {}
                                                        },
                                                      )),
                                                ],
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'SAFE EMS',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0945 367 3642',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0945 367 3642');
                                                    },
                                                  )),
                                            ])),
                                  ]))),
                    if (widget.details == 'Fire Stations')
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Central Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '991 2267',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062991 2267');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Ayala Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '955 5200',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062955 5200');
                                                          if (canLaunchUrlString(
                                                                  url.toString()) !=
                                                              null) {
                                                            launchUrlString(
                                                                url.toString());
                                                          } else {}
                                                        },
                                                      )),
                                                ],
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Boalan Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '099 770 31365',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '099 770 31365');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Calarian Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0917 106 2795',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0917 106 2795');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Culianan Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0975 295 3599',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0975 295 3599');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Guiwan Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '957 4372',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062957 4372');
                                                          if (canLaunchUrlString(
                                                                  url.toString()) !=
                                                              null) {
                                                            launchUrlString(
                                                                url.toString());
                                                          } else {}
                                                        },
                                                      )),
                                                ],
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Labuan Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0977 8034 232',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0977 8034 232');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Lunzuran Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0936 154 5366',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0936 154 5366');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Mampang Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0975 074 1376',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0975 074 1376');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Manicahan Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0975 031 3372',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0975 031 3372');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Mercedes Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0966 130 6100',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0966 130 6100');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Putik Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '310 9707',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062310 9707');
                                                          if (canLaunchUrlString(
                                                                  url.toString()) !=
                                                              null) {
                                                            launchUrlString(
                                                                url.toString());
                                                          } else {}
                                                        },
                                                      )),
                                                ],
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Quiniput Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0975 197 3009',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0975 197 3009');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Recodo Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0936 256 7071',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0936 256 7071');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'San Jose Gusu Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '991 9919',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062991 9919');
                                                          if (canLaunchUrlString(
                                                                  url.toString()) !=
                                                              null) {
                                                            launchUrlString(
                                                                url.toString());
                                                          } else {}
                                                        },
                                                      )),
                                                ],
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Sangali Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0977 803 0417',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0977 803 0417');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Sta Catalina Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '957 3160',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062957 3160');
                                                          if (canLaunchUrlString(
                                                                  url.toString()) !=
                                                              null) {
                                                            launchUrlString(
                                                                url.toString());
                                                          } else {}
                                                        },
                                                      )),
                                                ],
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Sta Maria Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0926 095 9479',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0926 095 9479');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Talisayan Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0936 462 2070',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0936 462 2070');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Tetuan Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0906 444 7816',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0906 444 7816');
                                                    },
                                                  )),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Tumaga Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '991 5809',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062991 5809');
                                                          if (canLaunchUrlString(
                                                                  url.toString()) !=
                                                              null) {
                                                            launchUrlString(
                                                                url.toString());
                                                          } else {}
                                                        },
                                                      )),
                                                ],
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Vitali Fire Station',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1 *
                                                          Config
                                                              .heightMultiplier),
                                                  child: TextButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .zero),
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size.zero),
                                                    ),
                                                    child: Text(
                                                      '0999 918 4646',
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          fontSize: Config
                                                                  .subheader *
                                                              Config
                                                                  .textMultiplier,
                                                          color:
                                                              Config.appColor),
                                                    ),
                                                    onPressed: () {
                                                      _showChoiceDialog(
                                                          '0999 918 4646');
                                                    },
                                                  )),
                                            ])),
                                  ]))),
                    if (widget.details == 'Hospitals')
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Brent Hospital',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '990 1963',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062990 1963');
                                                          if (canLaunchUrl(
                                                                  url) !=
                                                              null) {
                                                            launchUrl(url);
                                                          } else {}
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '992 5996',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062992 5996');
                                                          if (canLaunchUrl(
                                                                  url) !=
                                                              null) {
                                                            launchUrl(url);
                                                          } else {}
                                                        },
                                                      ),
                                                    ),
                                                  ])
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Ciudad Medical Zamboanga',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '992 7330',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062992 7330');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'West Metro Medical Center',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '991 2506',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062991 2506');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Universidad de Zamboanga Medical Center',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '990 1733',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062990 1733');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Zamboanga Peninsula Medical Center',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '955 4579',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062955 4579');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Zamboanga Puericulture Center',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '991 0379',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062991 0379');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Zamboanga Doctors Hospital',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '991 1929',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062991 1929');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Zamboanga City Medical Center',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '991 0052',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062991 0052');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Mindanao Central Sanitarium General Hospital',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '926 0155',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062926 0155');
                                                          if (canLaunchUrl(
                                                                  url) !=
                                                              null) {
                                                            launchUrl(url);
                                                          } else {}
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 1 *
                                                              Config
                                                                  .heightMultiplier),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                        ),
                                                        child: Text(
                                                          '957 1494',
                                                          textScaleFactor: .8,
                                                          style: TextStyle(
                                                              fontSize: Config
                                                                      .subheader *
                                                                  Config
                                                                      .textMultiplier,
                                                              color: Config
                                                                  .appColor),
                                                        ),
                                                        onPressed: () {
                                                          Uri url = Uri(
                                                              scheme: "tel",
                                                              path:
                                                                  '062957 1494');
                                                          if (canLaunchUrl(
                                                                  url) !=
                                                              null) {
                                                            launchUrl(url);
                                                          } else {}
                                                        },
                                                      ),
                                                    ),
                                                  ])
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                1 * Config.heightMultiplier,
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: 0.1 * Config.heightMultiplier,
                                          thickness:
                                              0.1 * Config.heightMultiplier,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                6 * Config.widthMultiplier),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Labuan General Hospital',
                                                textScaleFactor: .8,
                                                style: TextStyle(
                                                    fontSize: Config.title *
                                                        Config.textMultiplier,
                                                    color: Config.appColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '982 0029',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062982 0029');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            ])),
                                  ]))),
                    if (widget.details == 'Joint Task Force Zamboanga')
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            'Hotlines',
                                            textScaleFactor: .8,
                                            style: TextStyle(
                                                fontSize: Config.title *
                                                    Config.textMultiplier,
                                                color: Config.appColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          Spacer(),
                                          Column(children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1 *
                                                      Config.heightMultiplier),
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062983 0177');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                  child: Text(
                                                    '983 0177',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1 *
                                                      Config.heightMultiplier),
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  onPressed: () {
                                                    Uri url = Uri(
                                                        scheme: "tel",
                                                        path: '062922 5120');
                                                    if (canLaunchUrl(url) !=
                                                        null) {
                                                      launchUrl(url);
                                                    } else {}
                                                  },
                                                  child: Text(
                                                    '922 5120',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  )),
                                            ),
                                          ])
                                        ],
                                      ))
                                ],
                              ))),
                    if (widget.details == 'City Health Office Operation Center')
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * Config.heightMultiplier,
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Divider(
                                        color: Colors.black26,
                                        height: 0.1 * Config.heightMultiplier,
                                        thickness:
                                            0.1 * Config.heightMultiplier,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              6 * Config.widthMultiplier),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              'CHO OpCen',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Config.appColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Spacer(),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1 *
                                                        Config
                                                            .heightMultiplier),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets
                                                                .zero),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.zero),
                                                  ),
                                                  child: Text(
                                                    '0975 073 0151',
                                                    textScaleFactor: .8,
                                                    style: TextStyle(
                                                        fontSize: Config
                                                                .subheader *
                                                            Config
                                                                .textMultiplier,
                                                        color: Config.appColor),
                                                  ),
                                                  onPressed: () {
                                                    _showChoiceDialog(
                                                        '0975 073 0151');
                                                  },
                                                ))
                                          ]))
                                ],
                              ))),
                  ]))),
        ));
  }
}
