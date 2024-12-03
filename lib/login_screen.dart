// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamboangaemergency/default/config.dart';
import 'package:zamboangaemergency/default/firebase_settings.dart';
import 'package:zamboangaemergency/default/http.dart';
import 'package:zamboangaemergency/mobile_number.dart';
import 'package:zamboangaemergency/registration.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool successreg;
  LoginScreen({Key key, this.successreg}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  SharedPreferences _sharedPreferences;

  FocusNode _passwordFocus = FocusNode();

  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  _check() async {
    FocusScope.of(context).unfocus();
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _login();
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

  _login() async {
    Http().showLoadingOverlay(context);
    dynamic response = await Http(url: 'auth/login', body: {
      'username': _usernameController.text,
      'password': _passwordController.text
    }).postNoHeader();
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
      if (response.statusCode != 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF323232),
            content: Text(
              json.decode(response.body).runtimeType == String
                  ? json.decode(response.body)
                  : json.decode(response.body)['message'],
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
        Map<String, dynamic> body = json.decode(response.body);
        if (body['roles'][0] == 'resident') {
          if (body.containsKey('token')) {
            _sharedPreferences.setString('token', body['token']);
            _sharedPreferences.setInt(
              'id',
              int.parse(
                body['user']['id'].toString(),
              ),
            );
            _sharedPreferences.setString('username', body['user']['username']);
            _sharedPreferences.setString(
                'first_name', body['profile']['first_name']);
            _sharedPreferences.setString(
                'middle_name', body['profile']['middle_name']);
            _sharedPreferences.setString(
                'last_name', body['profile']['last_name']);
            // _sharedPreferences.setString('contact_number', '09759458361');
            _sharedPreferences.setString(
                'contact_number', body['profile']['contact_number']);
            _sharedPreferences.setString('address', body['profile']['address']);
            _sharedPreferences.setString('status', body['profile']['status']);
            _sharedPreferences.setInt('role-id', body['profile']['id']);
            _sharedPreferences.setString('role', 'resident');
            FirebaseSettings().updateToken();

            Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: MainScreen(),
                ));
          } else if (!body.containsKey('token') &&
              body.containsKey('message')) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color(0xFF323232),
                content: Text(
                  body['message'],
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
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color(0xFF323232),
                content: Text(
                  'Invalid Credentials',
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
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Color(0xFF323232),
              content: Text(
                'Invalid Credentials',
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
    }
  }

  _configure() async {
    Http().showLoadingOverlay(context);
    if (widget.successreg)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF323232),
          content: Text(
            'Your account is under review. You\'ll be able to use it once it gets approved',
            textScaleFactor: .8,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: Config.title * Config.textMultiplier,
            ),
          ),
        ),
      );
    _sharedPreferences = await SharedPreferences.getInstance();
    // _sharedPreferences.setBool('not-first-open', false);
    if (_sharedPreferences.getString('token') != null) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: MainScreen(),
          ));
    } else
      Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _configure();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: MainScreen(),
              ));
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ScaffoldMessenger(
              key: _scaffoldKey,
              child: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    // ButtonTheme(
                    //   height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                    //   minWidth: double.infinity,
                    //   child: MaterialButton(
                    //     onPressed: () {
                    //       _check();
                    //     },
                    //     color: Config.appColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(10))
                    //     ),
                    //     height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                    //     padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                    //     child: Text(
                    //       'Skip',
                    //       textScaleFactor: .8,
                    //       style: TextStyle(
                    //         fontSize: Config. title * Config.textMultiplier,
                    //         color: Colors.white
                    //       ),
                    //     )
                    //   )
                    // ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: MainScreen(),
                              ));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Config.appColor,
                        )),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: (DeviceUtil.isTablet ? 20 : 10) *
                                    Config.widthMultiplier),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 6 * Config.heightMultiplier),
                                    child: Image(
                                      image:
                                          AssetImage('assets/images/logo.png'),
                                      height: 30 * Config.imageSizeMultiplier,
                                      width: 30 * Config.imageSizeMultiplier,
                                    )),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Username',
                                      textScaleFactor: .8,
                                      style: TextStyle(
                                          fontSize: Config.title *
                                              Config.textMultiplier),
                                    )),
                                Container(
                                    height: (DeviceUtil.isTablet ? 5 : 6) *
                                        Config.heightMultiplier,
                                    margin: EdgeInsets.only(
                                        top: 1 * Config.heightMultiplier,
                                        bottom: 3 * Config.heightMultiplier),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2 * Config.widthMultiplier),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                (DeviceUtil.isTablet ? 2 : 3) *
                                                    Config.widthMultiplier)),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: .8),
                                        child: TextFormField(
                                          controller: _usernameController,
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
                                                  fontSize: Config.title *
                                                      Config.textMultiplier)),
                                          style: TextStyle(
                                              fontSize: Config.title *
                                                  Config.textMultiplier),
                                        ))),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Password',
                                      textScaleFactor: .8,
                                      style: TextStyle(
                                          fontSize: Config.title *
                                              Config.textMultiplier),
                                    )),
                                Container(
                                    height: (DeviceUtil.isTablet ? 5 : 6) *
                                        Config.heightMultiplier,
                                    margin: EdgeInsets.only(
                                        top: 1 * Config.heightMultiplier),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2 * Config.widthMultiplier),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                (DeviceUtil.isTablet ? 2 : 3) *
                                                    Config.widthMultiplier)),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Row(children: [
                                      Expanded(
                                          child: MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      textScaleFactor: .8),
                                              child: TextFormField(
                                                controller: _passwordController,
                                                focusNode: _passwordFocus,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                                  hintText: 'Password',
                                                  hintStyle: TextStyle(
                                                      fontSize: Config.title *
                                                          Config
                                                              .textMultiplier),
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
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forgot Password?',
                                          textScaleFactor: .8,
                                          style: TextStyle(
                                              fontSize: Config.subtitle *
                                                  Config.textMultiplier,
                                              color: Config.appColor,
                                              fontWeight: FontWeight.bold),
                                        ))),
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
                                            height:
                                                (DeviceUtil.isTablet ? 5 : 6) *
                                                    Config.heightMultiplier,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    2 * Config.widthMultiplier),
                                            child: Text(
                                              'Login',
                                              textScaleFactor: .8,
                                              style: TextStyle(
                                                  fontSize: Config.title *
                                                      Config.textMultiplier,
                                                  color: Colors.white),
                                            )))),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Don\'t have an account yet?',
                                        textScaleFactor: .8,
                                        style: TextStyle(
                                          fontSize: Config.subtitle *
                                              Config.textMultiplier,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: RegistrationScreen(),
                                                ));
                                          },
                                          child: Text(
                                            'Create an acount',
                                            textScaleFactor: .8,
                                            style: TextStyle(
                                                fontSize: Config.subtitle *
                                                    Config.textMultiplier,
                                                color: Config.appColor,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ]),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).viewInsets.bottom -
                                                  100 <
                                              0
                                          ? 0
                                          : MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom -
                                              100,
                                ),
                              ],
                            ))),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            height: 4 * Config.heightMultiplier,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Made with ',
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Config.subtitle *
                                          Config.textMultiplier),
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: Config.appColor,
                                  size: 4 * Config.imageSizeMultiplier,
                                ),
                                Text(
                                  ' by Dreame.rs IT Solutions Inc.',
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Config.subtitle *
                                          Config.textMultiplier),
                                ),
                              ],
                            )))
                  ]))),
        ));
  }
}
