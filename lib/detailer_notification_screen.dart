// @dart=2.9
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/detailed_guide_screen.dart';
import 'package:zamboangaemergency/detailed_hotlines_screen.dart';

import 'default/http.dart';

class DetailedNotificationScreen extends StatefulWidget {
  final dynamic details;

  DetailedNotificationScreen({Key key, this.details}) : super(key: key);
  @override
  _DetailedNotificationScreenState createState() =>
      _DetailedNotificationScreenState();
}

class _DetailedNotificationScreenState
    extends State<DetailedNotificationScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ScaffoldMessenger(
          key: _scaffoldKey,
          child: SafeArea(
              child: DefaultTabController(
                  length: 2,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2 * Config.widthMultiplier),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 2 * Config.heightMultiplier),
                              child: Text(
                                '${widget.details['title']}',
                                textScaleFactor: .8,
                                style: TextStyle(
                                    fontSize:
                                        Config.header * Config.textMultiplier,
                                    fontWeight: FontWeight.bold),
                              )),
                          Text(
                            DateFormat('MMM d, yyyy h:mm a').format(
                                DateTime.parse(widget.details['created_at'])),
                            textScaleFactor: .8,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize:
                                    Config.subtitle * Config.textMultiplier,
                                color: Colors.black54),
                          ),
                          if (widget.details['image'] != null)
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1 * Config.heightMultiplier),
                                child: SizedBox(
                                    child: Image.network(
                                  'http://${Http().ip}${widget.details['image']}',
                                  fit: BoxFit.fitWidth,
                                ))),
                          Expanded(
                              child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1 * Config.heightMultiplier,
                                        horizontal: 1 * Config.widthMultiplier),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0.5 *
                                                      Config.heightMultiplier),
                                              child: Text(
                                                widget.details['body'],
                                                textScaleFactor: .8,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontSize: Config.subtitle *
                                                        Config.textMultiplier,
                                                    color: Colors.black),
                                              )),
                                        ]),
                                  )))
                        ],
                      )))),
        ));
  }
}
