// @dart=2.9
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zamboangaemergency/valid_id.dart';

import 'default/config.dart';

String OTPCode = '';

class VerifyCodeScreen extends StatefulWidget {
  final String number;
  VerifyCodeScreen({Key key, this.number}) : super(key: key);
  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  TextEditingController _codeController = TextEditingController();

  _checkCode() async {
    if (_codeController.text == '111111') {
      Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ValidIDScreen(number: widget.number),
          ));
    } else {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF323232),
          content: Text('Invalid OTP',
              textScaleFactor: .8,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Config.title * Config.textMultiplier,
                  fontFamily: 'Roboto'))));
    }

    // for when there is actual OTP

    // Http().showLoadingOverlay(context);
    // dynamic response = await Http(url: 'verification/otp/check', body: {
    //   'phone_number': mobileNumber,
    //   'code': _codeController.text,
    // }).getNoHeader();

    // if (response is String) {
    //   Navigator.pop(context);
    //   _scaffoldKey.currentState?.showSnackBar(
    //     SnackBar(
    //       behavior: SnackBarBehavior.floating,
    //       backgroundColor: Color(0xFF323232),
    //       content: Text(
    //         response,
    //         textScaleFactor: .8,
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontfontSize: 1.8 * textMultiplier,
    //           fontFamily: 'Roboto'
    //         )
    //       )
    //     )
    //   );
    // }
    // else if (response is Response) {
    //   if (response.statusCode == 200) {
    //     setState(() {
    //       OTPCode = _codeController.text;
    //     });
    //     Navigator.pop(context);
    //     registrationProcess.currentState!.nextPage();
    //   }
    //   else {
    //     Navigator.pop(context);
    //     try{
    //       _scaffoldKey.currentState?.showSnackBar(
    //         SnackBar(
    //           behavior: SnackBarBehavior.floating,
    //           backgroundColor: Color(0xFF323232),
    //           content: Text(
    //             jsonDecode(response.body)['errors'][jsonDecode(response.body)['errors'].keys.toList()[0]][0].toString(),
    //             textScaleFactor: .8,
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontfontSize: 1.8 * textMultiplier,
    //               fontFamily: 'Roboto'
    //             )
    //           )
    //         )
    //       );
    //     }
    //     catch(error) {
    //       _scaffoldKey.currentState?.showSnackBar(
    //         SnackBar(
    //           behavior: SnackBarBehavior.floating,
    //           backgroundColor: Color(0xFF323232),
    //           content: Text(
    //             'Something went wrong',
    //             textScaleFactor: .8,
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontfontSize: 1.8 * textMultiplier,
    //               fontFamily: 'Roboto'
    //             )
    //           )
    //         )
    //       );
    //     }
    //   }
    // }
  }

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
                                  child: Text('Verification',
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
                                      'Please enter OTP sent to your number to proceed',
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
                              child: PinCodeTextField(
                                appContext: context,
                                animationType: AnimationType.fade,
                                length: 6,
                                onChanged: (string) {},
                                controller: _codeController,
                                pinTheme: PinTheme(
                                  activeColor: Config.appColor,
                                  inactiveColor: Config.appColor,
                                  activeFillColor: Config.appColor,
                                  inactiveFillColor: Config.appColor,
                                  selectedFillColor: Config.appColor,
                                  selectedColor: Config.appColor,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(
                                      1 * Config.imageSizeMultiplier),
                                  fieldHeight: 5 * Config.heightMultiplier,
                                  fieldWidth: 10 * Config.widthMultiplier,
                                ),
                                cursorColor: Colors.transparent,
                                animationDuration: Duration(milliseconds: 300),
                                backgroundColor: Colors.transparent,
                                enableActiveFill: false,
                                keyboardType: TextInputType.number,
                                onSubmitted: (string) {
                                  FocusScope.of(context).unfocus();
                                },
                              )),
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
                                            FocusScope.of(context).unfocus();
                                            _checkCode();
                                            // registrationProcess.currentState!.nextPage();
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
