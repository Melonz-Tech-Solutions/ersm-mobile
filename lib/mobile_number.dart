import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'default/config.dart';
import 'verify_code.dart';

String mobileNumber = '';
class MobileNumberScreen extends StatefulWidget {
  @override
  _MobileNumberScreenState createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  TextEditingController _mobileNumberController = TextEditingController();
  
  _sendCode() async{
    Navigator.push(
      context, PageTransition(
        type: PageTransitionType.fade,
        child: VerifyCodeScreen(number: _mobileNumberController.text),
      )
    );

    //for when there is actual OTP

    // Http().showLoadingOverlay(context);
    // dynamic response = await Http(url: 'verification/otp', body: {
    //   'phone_number':_mobileNumberController.text
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
    //           fontSize: Config. title * Config.textMultiplier,
    //           fontFamily: 'Roboto'
    //         )
    //       )
    //     )
    //   );
    // }
    // else if (response is Response) {
    //   if (response.statusCode == 200) {
    //     setState(() {
    //       mobileNumber = _mobileNumberController.text;
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
    //               fontSize: Config. title * Config.textMultiplier,
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
    //               fontSize: Config. title * Config.textMultiplier,
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
            padding: EdgeInsets.symmetric(horizontal: 8 * Config.widthMultiplier),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2 * Config.heightMultiplier),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mobile Number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Config. subheader * Config.textMultiplier,
                        fontWeight: FontWeight.bold
                      )
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1 * Config.heightMultiplier),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Please enter your mobile number to receive an OTP',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Config. title * Config.textMultiplier,
                        fontWeight: FontWeight.normal
                      ),
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4 * Config.heightMultiplier),
                  child: Container(
                    height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                    margin: EdgeInsets.only(top: 1 * Config.heightMultiplier, bottom: 3 * Config.heightMultiplier),
                    padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular((DeviceUtil.isTablet?2:3) * Config.widthMultiplier)),
                      border: Border.all(color: Colors.black)
                    ),
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaleFactor: .8),
                      child: TextFormField(
                        controller: _mobileNumberController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.numberWithOptions(decimal: false),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                            fontSize: Config. title * Config.textMultiplier
                          )
                        ),
                        style: TextStyle(
                          fontSize: Config. title * Config.textMultiplier
                        ),
                      )
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4 * Config.heightMultiplier),
                    child: ButtonTheme(
                      height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                      minWidth: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          RegExp regex = RegExp(r'^(09|639)\d{9}$');
                          if (_mobileNumberController.text.isNotEmpty && regex.hasMatch(_mobileNumberController.text)) {
                            if (_mobileNumberController.text.length>0) _sendCode();
                          }
                          else
                          _scaffoldKey.currentState?.showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Color(0xFF323232),
                              content: Text(
                                'The phone number format is invalid.',
                                textScaleFactor: .8,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Config. title * Config.textMultiplier,
                                  fontFamily: 'Roboto'
                                )
                              )
                            )
                          );
                        },
                        color: Config.appColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        height: (DeviceUtil.isTablet?5:6) * Config.heightMultiplier,
                        padding: EdgeInsets.symmetric(horizontal: 2 * Config.widthMultiplier),
                        child: Text(
                          'Next',
                          textScaleFactor: .8,
                          style: TextStyle(
                            fontSize: Config. title * Config.textMultiplier,
                            color: Colors.white
                          ),
                        )
                      )
                    )
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}