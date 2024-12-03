// @dart=2.9
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/default/http.dart';
import 'package:zamboangaemergency/guides_screen.dart';
import 'package:zamboangaemergency/home_screen.dart';
import 'package:zamboangaemergency/hotlines_screen.dart';
import 'package:zamboangaemergency/login_screen.dart';
import 'package:zamboangaemergency/notifications.dart';

import 'about_us.dart';
import 'default/firebase_settings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _page = 0;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  var homeScreenPage = HomeScreen();

  SharedPreferences _sharedPreferences;

  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    _configure();
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page?.toInt();
      });
    });
  }

  _configure() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    if (_sharedPreferences?.getString('token') != null) {
      setState(() {
        _loggedIn = true;
      });
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  _showLogoutDialog() {
    showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(.4),
        builder: (_) => new AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Logout',
                  textAlign: TextAlign.left,
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    fontSize: Config.title * Config.textMultiplier,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              content: Text('Are you sure?',
                  textAlign: TextAlign.left,
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    fontSize: Config.title * Config.textMultiplier,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  )),
              actions: [
                TextButton(
                  child: Text('No',
                      textAlign: TextAlign.left,
                      textScaleFactor: 0.8,
                      style: TextStyle(
                        fontSize: Config.title * Config.textMultiplier,
                        color: Config.appColor,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _scaffoldKey.currentState?.removeCurrentSnackBar();
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('Yes',
                      textAlign: TextAlign.left,
                      textScaleFactor: 0.8,
                      style: TextStyle(
                        fontSize: Config.title * Config.textMultiplier,
                        color: Config.appColor,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _scaffoldKey.currentState?.removeCurrentSnackBar();
                    Navigator.pop(context);
                    _logout();
                  },
                ),
              ],
            ));
  }

  _logout() async {
    FirebaseSettings().revokeToken();
    Http().logout();
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.clear();
    setState(() {
      _loggedIn = false;
    });
    if (_page == 0) homeScreenPage.homeScreenState.reset('logout');
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     PageTransition(
    //         type: PageTransitionType.leftToRight,
    //         child: LoginScreen(successreg: false)),
    //     (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ScaffoldMessenger(
              key: _scaffoldKey,
              child: SafeArea(
                  child: Column(children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: (DeviceUtil.isTablet ? 6 : 6) *
                          Config.widthMultiplier,
                      right: (DeviceUtil.isTablet ? 6 : 6) *
                          Config.widthMultiplier,
                      top: (DeviceUtil.isTablet ? 2 : 2) *
                          Config.heightMultiplier),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: onPageChanged,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      homeScreenPage,
                      NotificationsScreen(),
                      GuideScreen(),
                      HotlinesScreen(),
                      AboutUsScreen(),
                    ],
                  ),
                )),
                Container(
                    height:
                        (DeviceUtil.isTablet ? 6 : 8) * Config.heightMultiplier,
                    child: Material(
                        color: Config.appColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                color:
                                    _page == 0 ? Colors.white : Config.appColor,
                                height: (DeviceUtil.isTablet ? 6 : 8) *
                                    Config.heightMultiplier,
                                width: (DeviceUtil.isTablet ? 14 : 16) *
                                    Config.widthMultiplier,
                                child: IconButton(
                                    onPressed: () {
                                      if (_page != 0)
                                        setState(() {
                                          _pageController.jumpToPage(0);
                                        });
                                    },
                                    icon: Icon(
                                      Icons.home_rounded,
                                      size: 6 * Config.imageSizeMultiplier,
                                      color: _page == 0
                                          ? Config.appColor
                                          : Colors.white,
                                    ))),
                            if (_loggedIn)
                              Container(
                                  color: _page == 1
                                      ? Colors.white
                                      : Config.appColor,
                                  height: (DeviceUtil.isTablet ? 6 : 8) *
                                      Config.heightMultiplier,
                                  width: (DeviceUtil.isTablet ? 14 : 16) *
                                      Config.widthMultiplier,
                                  child: IconButton(
                                      onPressed: () {
                                        if (_page != 1)
                                          setState(() {
                                            _pageController.jumpToPage(1);
                                          });
                                      },
                                      icon: Icon(
                                        Icons.notifications,
                                        size: 6 * Config.imageSizeMultiplier,
                                        color: _page == 1
                                            ? Config.appColor
                                            : Colors.white,
                                      ))),
                            Container(
                                color:
                                    _page == 2 ? Colors.white : Config.appColor,
                                height: (DeviceUtil.isTablet ? 6 : 8) *
                                    Config.heightMultiplier,
                                width: (DeviceUtil.isTablet ? 14 : 16) *
                                    Config.widthMultiplier,
                                child: IconButton(
                                    onPressed: () {
                                      if (_page != 2)
                                        setState(() {
                                          _pageController.jumpToPage(2);
                                        });
                                    },
                                    icon: Icon(
                                      Icons.menu_book,
                                      size: 6 * Config.imageSizeMultiplier,
                                      color: _page == 2
                                          ? Config.appColor
                                          : Colors.white,
                                    ))),
                            Container(
                                color:
                                    _page == 3 ? Colors.white : Config.appColor,
                                height: (DeviceUtil.isTablet ? 6 : 8) *
                                    Config.heightMultiplier,
                                width: (DeviceUtil.isTablet ? 14 : 16) *
                                    Config.widthMultiplier,
                                child: IconButton(
                                    onPressed: () {
                                      if (_page != 3)
                                        setState(() {
                                          _pageController.jumpToPage(3);
                                        });
                                    },
                                    icon: Icon(
                                      Icons.phone_enabled,
                                      size: 6 * Config.imageSizeMultiplier,
                                      color: _page == 3
                                          ? Config.appColor
                                          : Colors.white,
                                    ))),
                            Container(
                                color:
                                    _page == 4 ? Colors.white : Config.appColor,
                                height: (DeviceUtil.isTablet ? 6 : 8) *
                                    Config.heightMultiplier,
                                width: (DeviceUtil.isTablet ? 14 : 16) *
                                    Config.widthMultiplier,
                                child: IconButton(
                                    onPressed: () {
                                      if (_page != 4)
                                        setState(() {
                                          _pageController.jumpToPage(4);
                                        });
                                    },
                                    icon: Icon(
                                      Icons.info,
                                      size: 6 * Config.imageSizeMultiplier,
                                      color: _page == 4
                                          ? Config.appColor
                                          : Colors.white,
                                    ))),
                            if (_loggedIn)
                              Container(
                                child: IconButton(
                                    onPressed: () {
                                      _showLogoutDialog();
                                    },
                                    icon: Icon(
                                      Icons.logout_rounded,
                                      size: 6 * Config.imageSizeMultiplier,
                                      color: Colors.white,
                                    )),
                              )
                          ],
                        )))
              ]))),
        ));
  }
}
