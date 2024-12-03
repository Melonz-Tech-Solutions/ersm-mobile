import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/detailed_guide_screen.dart';
import 'package:zamboangaemergency/detailed_hotlines_screen.dart';

class HotlinesScreen extends StatefulWidget {
  @override
  _HotlinesScreenState createState() => _HotlinesScreenState();
}

class _HotlinesScreenState extends State<HotlinesScreen> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2 * Config.heightMultiplier),
                  child: Text(
                    'EMERGENCY HOTLINES',
                    textScaleFactor: .8,
                    style: TextStyle(
                      fontSize: Config. header * Config.textMultiplier,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.5 * Config.heightMultiplier, bottom: 0.5 * Config.heightMultiplier),
                          child: ButtonTheme(
                            height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                            minWidth: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push( 
                                  context, PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DetailedHotlinesScreen(details: '911/117'),
                                  )
                                );
                              },
                              // color: Config.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Config.appColor)
                              ),
                              height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                              padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                              child: Text(
                                '911/117',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: Config. title * Config.textMultiplier,
                                  color: Config.appColor
                                ),
                              )
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5 * Config.heightMultiplier, bottom: 0.5 * Config.heightMultiplier),
                          child: ButtonTheme(
                            height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                            minWidth: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push( 
                                  context, PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DetailedHotlinesScreen(details: 'ZCDRRMO Hotlines'),
                                  )
                                );
                              },
                              // color: Config.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Config.appColor)
                              ),
                              height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                              padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                              child: Text(
                                'ZCDRRMO Hotlines',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: Config. title * Config.textMultiplier,
                                  color: Config.appColor
                                ),
                              )
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5 * Config.heightMultiplier, bottom: 0.5 * Config.heightMultiplier),
                          child: ButtonTheme(
                            height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                            minWidth: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push( 
                                  context, PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DetailedHotlinesScreen(details: 'Police Stations'),
                                  )
                                );
                              },
                              // color: Config.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Config.appColor)
                              ),
                              height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                              padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                              child: Text(
                                'Police Stations',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: Config. title * Config.textMultiplier,
                                  color: Config.appColor
                                ),
                              )
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5 * Config.heightMultiplier, bottom: 0.5 * Config.heightMultiplier),
                          child: ButtonTheme(
                            height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                            minWidth: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push( 
                                  context, PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DetailedHotlinesScreen(details: 'Ambulances'),
                                  )
                                );
                              },
                              // color: Config.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Config.appColor)
                              ),
                              height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                              padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                              child: Text(
                                'Ambulances',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: Config. title * Config.textMultiplier,
                                  color: Config.appColor
                                ),
                              )
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5 * Config.heightMultiplier, bottom: 0.5 * Config.heightMultiplier),
                          child: ButtonTheme(
                            height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                            minWidth: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push( 
                                  context, PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DetailedHotlinesScreen(details: 'Fire Stations'),
                                  )
                                );
                              },
                              // color: Config.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Config.appColor)
                              ),
                              height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                              padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                              child: Text(
                                'Fire Stations',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: Config. title * Config.textMultiplier,
                                  color: Config.appColor
                                ),
                              )
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5 * Config.heightMultiplier, bottom: 0.5 * Config.heightMultiplier),
                          child: ButtonTheme(
                            height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                            minWidth: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push( 
                                  context, PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DetailedHotlinesScreen(details: 'Hospitals'),
                                  )
                                );
                              },
                              // color: Config.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Config.appColor)
                              ),
                              height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                              padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                              child: Text(
                                'Hospitals',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: Config. title * Config.textMultiplier,
                                  color: Config.appColor
                                ),
                              )
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5 * Config.heightMultiplier, bottom: 0.5 * Config.heightMultiplier),
                          child: ButtonTheme(
                            height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                            minWidth: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push( 
                                  context, PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DetailedHotlinesScreen(details: 'Joint Task Force Zamboanga'),
                                  )
                                );
                              },
                              // color: Config.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Config.appColor)
                              ),
                              height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                              padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                              child: Text(
                                'Joint Task Force Zamboanga',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: Config. title * Config.textMultiplier,
                                  color: Config.appColor
                                ),
                              )
                            )
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5 * Config.heightMultiplier, bottom: 0.5 * Config.heightMultiplier),
                          child: ButtonTheme(
                            height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                            minWidth: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push( 
                                  context, PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DetailedHotlinesScreen(details: 'City Health Office Operation Center'),
                                  )
                                );
                              },
                              // color: Config.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Config.appColor)
                              ),
                              height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                              padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                              child: Text(
                                'City Health Office Operation Center',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  fontSize: Config. title * Config.textMultiplier,
                                  color: Config.appColor
                                ),
                              )
                            )
                          )
                        ),
                      ],
                    ),
                  )
                ),
              ],
            )
          )
        ),
      )
    );
  }
}
