import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/detailed_guide_screen.dart';

class GuideScreen extends StatefulWidget {
  @override
  _GuideScreenState createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
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
                Text(
                  'GUIDES',
                  textScaleFactor: .8,
                  style: TextStyle(
                    fontSize: Config. header * Config.textMultiplier,
                    fontWeight: FontWeight.bold
                  ),
                ),
                MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: .8),
                  child: TabBar(
                    labelColor: Config.appColor,
                    overlayColor: MaterialStateProperty.all(Config.appColor),
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Config.appColor,
                    labelStyle: TextStyle(
                      fontSize: Config. title * Config.textMultiplier,
                      color: Config.appColor
                    ),
                    tabs: [
                      Tab(
                        text: 'Disaster Preparedness',
                      ),
                      Tab(
                        text: 'First Aid'
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1 * Config.heightMultiplier),
                        child:SingleChildScrollView(
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
                                          child: DetailedGuideScreen(details: {'text': 'Emergency Bag', 'pages': 1, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['emergency.jpg']}),
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
                                      'Emergency Bag',
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
                                          child: DetailedGuideScreen(details: {'text': 'Typhoon', 'pages': 3, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['typhoon1.jpg', 'typhoon2.jpg', 'typhoon3.jpg']}),
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
                                      'Typhoon',
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
                                          child: DetailedGuideScreen(details: {'text': 'Flood', 'pages': 3, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['flood1.jpg', 'flood2.jpg', 'flood3.jpg']}),
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
                                      'Flood',
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
                                          child: DetailedGuideScreen(details: {'text': 'Storm Surge', 'pages': 3, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['storm1.jpg', 'storm2.jpg', 'storm3.jpg']}),
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
                                      'Storm Surge',
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
                                          child: DetailedGuideScreen(details: {'text': 'Landslide', 'pages': 3, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['landslide1.jpg', 'landslide2.jpg', 'landslide3.jpg']}),
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
                                      'Landslide',
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
                                          child: DetailedGuideScreen(details: {'text': 'Fire', 'pages': 2, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['fire1.jpg', 'fire2.jpg']}),
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
                                      'Fire',
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
                                          child: DetailedGuideScreen(details: {'text': 'Earthquake', 'pages': 3, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['earthquake1.jpg', 'earthquake2.jpg', 'earthquake3.jpg']}),
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
                                      'Earthquake',
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
                                          child: DetailedGuideScreen(details: {'text': 'Tsunami', 'pages': 3, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['tsunami1.jpg', 'tsunami2.jpg', 'tsunami3.jpg']}),
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
                                      'Tsunami',
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
                                          child: DetailedGuideScreen(details: {'text': 'Active Shooting', 'pages': 3, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['shooting1.jpg', 'shooting2.jpg', 'shooting3.jpg']}),
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
                                      'Active Shooting',
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
                                          child: DetailedGuideScreen(details: {'text': 'Terrorism', 'pages': 1, 'prefix': 'assets/images/disaster_preparedness/', 'images': ['terrorism.jpg']}),
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
                                      'Terrorism',
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
                      Padding(
                        padding: EdgeInsets.only(top: 1 * Config.heightMultiplier),
                        child:SingleChildScrollView(
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
                                          child: DetailedGuideScreen(details: {'text': 'First Aid Kit', 'pages': 1, 'prefix': 'assets/images/first_aid/', 'images': ['kit.jpg']}),
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
                                      'First Aid Kit',
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
                                          child: DetailedGuideScreen(details: {'text': 'Severe Bleeding', 'pages': 4, 'prefix': 'assets/images/first_aid/', 'images': ['bleeding1.jpg', 'bleeding2.jpg', 'bleeding3.jpg', 'bleeding4.jpg']}),
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
                                      'Severe Bleeding',
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
                                          child: DetailedGuideScreen(details: {'text': 'Broken Bones', 'pages': 3, 'prefix': 'assets/images/first_aid/', 'images': ['broken1.jpg', 'broken2.jpg', 'broken3.jpg']}),
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
                                      'Broken Bones',
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
                                          child: DetailedGuideScreen(details: {'text': 'Burns', 'pages': 3, 'prefix': 'assets/images/first_aid/', 'images': ['burn1.jpg', 'burn2.jpg', 'burn3.jpg']}),
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
                                      'Burns',
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
                                          child: DetailedGuideScreen(details: {'text': 'Stroke', 'pages': 2, 'prefix': 'assets/images/first_aid/', 'images': ['stroke1.jpg', 'stroke2.jpg']}),
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
                                      'Stroke',
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
                                          child: DetailedGuideScreen(details: {'text': 'CPR', 'pages': 2, 'prefix': 'assets/images/first_aid/', 'images': ['cpr1.jpg', 'cpr2.jpg']}),
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
                                      'CPR',
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
                                          child: DetailedGuideScreen(details: {'text': 'Choking', 'pages': 1, 'prefix': 'assets/images/first_aid/', 'images': ['choking.jpg']}),
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
                                      'Choking',
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
                                          child: DetailedGuideScreen(details: {'text': 'Heatstroke', 'pages': 1, 'prefix': 'assets/images/first_aid/', 'images': ['heatstroke.jpg']}),
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
                                      'Heatstroke',
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
                                          child: DetailedGuideScreen(details: {'text': 'Snake Bites', 'pages': 1, 'prefix': 'assets/images/first_aid/', 'images': ['snake.jpg']}),
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
                                      'Snake Bites',
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
                                          child: DetailedGuideScreen(details: {'text': 'Drowning', 'pages': 1, 'prefix': 'assets/images/first_aid/', 'images': ['drowning.jpg']}),
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
                                      'Drowning',
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
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         Container(
                          
                //         )
                //       ],
                //     ),
                //   ),
                // )
              ],
            )
          )
        ),
      )
    );
  }
}
