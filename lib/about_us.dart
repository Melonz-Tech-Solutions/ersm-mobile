import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/detailed_guide_screen.dart';
import 'package:zamboangaemergency/detailed_hotlines_screen.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  Telephony telephony = Telephony.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ScaffoldMessenger(
          key: _scaffoldKey,
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 2 * Config.heightMultiplier),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'ABOUT US',
                        textScaleFactor: .8,
                        style: TextStyle(
                            fontSize: Config.header * Config.textMultiplier,
                            fontWeight: FontWeight.bold),
                      ))),
              Expanded(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 16 * Config.heightMultiplier,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: 1 * Config.heightMultiplier,
                                  top: 2 * Config.heightMultiplier),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'VISION STATEMENT',
                                    textScaleFactor: .8,
                                    style: TextStyle(
                                        fontSize: Config.subheader *
                                            Config.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Safer, adaptive and disaster resilient Zamboangueno communities towards sustainable development.',
                                textScaleFactor: .8,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize:
                                        Config.title * Config.textMultiplier,
                                    fontWeight: FontWeight.normal),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: 1 * Config.heightMultiplier,
                                  top: 2 * Config.heightMultiplier),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'MISSION STATEMENT',
                                    textScaleFactor: .8,
                                    style: TextStyle(
                                        fontSize: Config.subheader *
                                            Config.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                  textScaleFactor: .8,
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: Config.title *
                                              Config.textMultiplier,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text:
                                              '• DISASTER PREVENTION AND MITIGATION.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                '\nAvoid hazards and mitigate their potential impact by reducing vulnerabilities and exposure and enhancing capacities of communities.\n\n'),
                                        TextSpan(
                                          text: '• DISASTER RESPONSE.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                '\nProvide life preservation and meet the basic subsistence need of affected population based on acceptable standards during or immediately after a disaster. \n\n'),
                                        TextSpan(
                                          text:
                                              '• DISASTER REHABILITATION AND RECOVERY.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                '\nRestore and improve facilities and living conditions and capabilities of communities and reduce risks in accordance with the building back better principle \n\n'),
                                        TextSpan(
                                          text: '• PUBLIC SAFETY.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                '\nTo maintain peace and order to prevent and suppress lawlessness, disorder, riot, violence, rebellion or sedition for the general welfare and its habitants, shall prioritize a public safety project that will provide a Command Center System (C2) and Incident Response Management System (IRMS) for the city'),
                                      ]))),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: 1 * Config.heightMultiplier,
                                  top: 2 * Config.heightMultiplier),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'SERVICE PLEDGE',
                                    textScaleFactor: .8,
                                    style: TextStyle(
                                        fontSize: Config.subheader *
                                            Config.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'This office performs the mandated duties and responsibilities as stipulated in RA. 10121 and Citv Ordinance No. 433 series 2016 with a sense of urgency and dedication and civil service over and above of what is required given the emerging challenges brought by disasters and we are happy that in our own little wav we are able to assist other offices in making our city compliant to the four (4) DRRM thematic areas: Disaster Prevention & Mitigation, Disaster Preparedness Disaster Response and Disaster Rehabilitation & Recovery.',
                                textScaleFactor: .8,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize:
                                        Config.title * Config.textMultiplier,
                                    fontWeight: FontWeight.normal),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: 1 * Config.heightMultiplier,
                                  top: 2 * Config.heightMultiplier),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'CONTACT US',
                                    textScaleFactor: .8,
                                    style: TextStyle(
                                        fontSize: Config.subheader *
                                            Config.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      'Facebook Page',
                                      textScaleFactor: .8,
                                      style: TextStyle(
                                          fontSize: Config.title *
                                              Config.textMultiplier,
                                          color: Config.appColor,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    'https://www.facebook.com/zcdrrmo/',
                                    textAlign: TextAlign.end,
                                    textScaleFactor: .8,
                                    style: TextStyle(
                                        fontSize: Config.title *
                                            Config.textMultiplier,
                                        color: Config.appColor),
                                  ),
                                )
                              ]),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1 * Config.heightMultiplier),
                              child: Divider(
                                color: Colors.black26,
                                height: 0.1 * Config.heightMultiplier,
                                thickness: 0.1 * Config.heightMultiplier,
                              )),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Address',
                                  textScaleFactor: .8,
                                  style: TextStyle(
                                      fontSize:
                                          Config.title * Config.textMultiplier,
                                      color: Config.appColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Expanded(
                                  child: Text(
                                    'ZCDRRMO Complex, Legionaire St., Zone 4, Zamboanga City',
                                    textAlign: TextAlign.end,
                                    textScaleFactor: .8,
                                    style: TextStyle(
                                        fontSize: Config.title *
                                            Config.textMultiplier,
                                        color: Config.appColor),
                                  ),
                                )
                              ]),
                        ],
                      ))),
            ],
          )),
        ));
  }
}
