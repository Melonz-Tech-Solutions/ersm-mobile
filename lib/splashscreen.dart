import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'default/firebase_settings.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  _configure() async {
    await FirebaseSettings().updateToken();
    Navigator.pushReplacement(
      context, PageTransition(
        type: PageTransitionType.fade,
        child: MainScreen()
      )
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {_configure();});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldMessenger(
        key: _scaffoldKey,
        child: SafeArea(
          child: Center(
            child: Image(
              height: 40 * Config.imageSizeMultiplier,
              width: 40 * Config.imageSizeMultiplier,
              image: AssetImage(
                'assets/images/logo.png'
              )
            )
          )
        ),
      )
    );
  }
}
