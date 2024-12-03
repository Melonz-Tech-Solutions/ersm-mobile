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
import 'package:zamboangaemergency/detailer_notification_screen.dart';

import 'default/http.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  RefreshController _smartRefreshController = RefreshController();
  List _notifications = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadNotifications();
    });
  }

  _loadNotifications() async {
    Http().showLoadingOverlay(context);
    dynamic response = await Http(url: 'notifications').getWithHeader();
    if (response is String) {
      Navigator.pop(context);
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
        Navigator.pop(context);
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
        setState(() {
          _notifications = new List.from(json.decode(response.body));
        });
        Navigator.pop(context);
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
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: 2 * Config.heightMultiplier),
                          child: Text(
                            'NOTIFICATIONS',
                            textScaleFactor: .8,
                            style: TextStyle(
                                fontSize: Config.header * Config.textMultiplier,
                                fontWeight: FontWeight.bold),
                          )),
                      if (_notifications.length > 0)
                        Expanded(
                            child: SmartRefresher(
                                physics: BouncingScrollPhysics(),
                                controller: _smartRefreshController,
                                onRefresh: () async {
                                  await _loadNotifications();
                                  _smartRefreshController.refreshCompleted();
                                },
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      for (var notification in _notifications)
                                        Column(children: [
                                          ButtonTheme(
                                              height: (DeviceUtil.isTablet
                                                      ? 5
                                                      : 6) *
                                                  Config.heightMultiplier,
                                              minWidth: double.infinity,
                                              child: MaterialButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              DetailedNotificationScreen(
                                                                  details: {
                                                                'image':
                                                                    notification[
                                                                            'data']
                                                                        [
                                                                        'image'],
                                                                'title':
                                                                    notification[
                                                                            'data']
                                                                        [
                                                                        'title'],
                                                                'created_at':
                                                                    notification[
                                                                        'created_at'],
                                                                'body':
                                                                    notification[
                                                                            'data']
                                                                        ['body']
                                                              }),
                                                        ));
                                                  },
                                                  height: (DeviceUtil.isTablet
                                                          ? 5
                                                          : 6) *
                                                      Config.heightMultiplier,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2 *
                                                          Config
                                                              .widthMultiplier),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 1 *
                                                            Config
                                                                .heightMultiplier,
                                                        horizontal: 1 *
                                                            Config
                                                                .widthMultiplier),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  '${notification['data']['title']} ',
                                                                  textScaleFactor:
                                                                      .8,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: Config
                                                                              .title *
                                                                          Config
                                                                              .textMultiplier,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  DateFormat(
                                                                          'MMM d, yyyy h:mm a')
                                                                      .format(DateTime
                                                                          .parse(
                                                                              notification['created_at'])),
                                                                  textScaleFactor:
                                                                      .8,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize: Config
                                                                              .subtitle *
                                                                          Config
                                                                              .textMultiplier,
                                                                      color: Colors
                                                                          .black54),
                                                                )
                                                              ]),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical: 0.5 *
                                                                          Config
                                                                              .heightMultiplier),
                                                              child: Text(
                                                                '${notification['data']['body']}',
                                                                textScaleFactor:
                                                                    .8,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize: Config
                                                                            .subtitle *
                                                                        Config
                                                                            .textMultiplier,
                                                                    color: Colors
                                                                        .black54),
                                                              )),
                                                        ]),
                                                  ))),
                                          Divider(
                                            color: Config.appColor,
                                            thickness:
                                                0.1 * Config.heightMultiplier,
                                          ),
                                        ])
                                    ],
                                  ),
                                )))
                      else
                        Expanded(
                            child: Center(
                          child: Text(
                            'No notifications',
                            textScaleFactor: .8,
                            style: TextStyle(
                              fontSize: Config.title * Config.textMultiplier,
                            ),
                          ),
                        ))
                    ],
                  ))),
        ));
  }
}
