import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/constant/appDimens.dart';
import 'package:login/constant/colors.dart';
import 'package:login/models/register_model.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/home_navigation.dart';
import 'package:login/screens/openpainter.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/utils/utility.dart';

class OTPVerfication extends StatefulWidget {
  String countrycode;
  String phone;
  OTPVerfication({required this.phone, required this.countrycode});
  @override
  _OTPVerficationScreenPageState createState() =>
      _OTPVerficationScreenPageState();
}

class _OTPVerficationScreenPageState extends State<OTPVerfication> {
  late Future<RegisterModel> registerAPI;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  FocusNode controller1fn = FocusNode();
  FocusNode controller2fn = FocusNode();
  FocusNode controller3fn = FocusNode();
  FocusNode controller4fn = FocusNode();
  FocusNode controller5fn = FocusNode();
  FocusNode controller6fn = FocusNode();
  static const double dist = 3.0;
  TextEditingController currController = TextEditingController();
  String otp = "";
  AppDimens? appDimens;
  bool isLoading = false;
  String _verificationId = "";
  bool autovalidate = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    currController = controller1;
    _verifyPhoneNumber();
    registerAPI = ApiService().getRegisterAPI(widget.phone);
  }

  void _verifyPhoneNumber() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Utility.showToast(msg: authException.message);
      print(authException.code);
      print(authException.message);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("codeAutoRetrievalTimeout");
      _verificationId = verificationId;
    };

    // final PhoneCodeSent codeSent =
    //     (String verificationId, [int forceResendingToken]) async {
    //   print("codeSent");
    //   print(verificationId);
    //   Utility.showToast(
    //       msg: "Please check your phone for the verification code.");
    //   _verificationId = verificationId;
    // };

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomeNavigation()),
      //     (route) => false);
      print("verificationCompleted");
    };

    if (kIsWeb) {
      await _auth
          .signInWithPhoneNumber(
        widget.countrycode + widget.phone,
      )
          .then((value) {
        _verificationId = value.verificationId;
        print('toekn' + "then");
      }).catchError((onError) {
        print(onError);
      });
    } else {
      await _auth
          .verifyPhoneNumber(
              phoneNumber: widget.countrycode + widget.phone,
              timeout: const Duration(seconds: 5),
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: (String verificationId, int? forceCodeResend) async {
                _verificationId = verificationId;
                print("token user${forceCodeResend}");
                print("token id " + verificationId);
              },
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
          .then((value) {
        print("then");
      }).catchError((onError) {
        print(onError);
      });
    }

    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  void _signInWithPhoneNumber(String otp) async {
    _showProgressDialog(true);
    if (await Utility.checkInternet()) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: otp,
        );
        final User? user = (await _auth.signInWithCredential(credential)).user;
        final User? currentUser = _auth.currentUser;
        assert(user!.uid == currentUser!.uid);

        _showProgressDialog(false);
        if (user != null) {
          print(user);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeNavigation()),
              (route) => false);
        } else {
          Utility.showToast(msg: "Sign in failed");
        }
      } catch (e) {
        print(e);

        Utility.showToast(msg: e.toString());
        _showProgressDialog(false);
      }
    } else {
      _showProgressDialog(false);
      Utility.showToast(msg: "No internet connection");
    }
  }

  _showProgressDialog(bool isloadingstate) {
    if (mounted)
      setState(() {
        isLoading = isloadingstate;
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
  }

  verifyOtp(String otpText) async {
    _signInWithPhoneNumber(otpText);
  }

  @override
  Widget build(BuildContext context) {
    appDimens = AppDimens(MediaQuery.of(context).size);

    List<Widget> widgetList = [
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            enabled: true,
            controller: controller1,
            autofocus: true,
            focusNode: controller1fn,
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, controller1fn, controller2fn);
              }
            },
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: appDimens!.text24, color: AstroColors.colorLightGrey),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, controller2fn, controller3fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, controller2fn, controller1fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: controller2,
            focusNode: controller2fn,
            enabled: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: appDimens!.text24, color: AstroColors.colorLightGrey),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, controller3fn, controller4fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, controller3fn, controller2fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: controller3,
            focusNode: controller3fn,
            textAlign: TextAlign.center,
            enabled: true,
            style: TextStyle(
                fontSize: appDimens!.text24, color: AstroColors.colorLightGrey),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, controller4fn, controller5fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, controller4fn, controller3fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: controller4,
            focusNode: controller4fn,
            enabled: true,
            style: TextStyle(
                fontSize: appDimens!.text24, color: AstroColors.colorLightGrey),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            onChanged: (ct) {
              if (ct.length > 0) {
                _fieldFocusChange(context, controller5fn, controller6fn);
              } else if (ct.length == 0) {
                _fieldFocusChange(context, controller5fn, controller4fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            controller: controller5,
            focusNode: controller5fn,
            textAlign: TextAlign.center,
            enabled: true,
            style: TextStyle(
                fontSize: appDimens!.text24, color: AstroColors.colorLightGrey),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: dist, left: dist),
        child: Container(
          alignment: Alignment.center,
          child: TextField(
            onChanged: (ct) {
              if (ct.length == 0) {
                _fieldFocusChange(context, controller6fn, controller5fn);
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            controller: controller6,
            focusNode: controller6fn,
            enabled: true,
            style: TextStyle(
                fontSize: appDimens!.text24, color: AstroColors.colorLightGrey),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: CustomPaint(
                painter: OpenPainter(),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 120,
              child: CustomPaint(
                painter: OpenPainter(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 8),
                  child: Text(
                    'OTP Verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: appDimens!.paddingw16),
                  child: Visibility(
                    visible: widget.phone == null ? false : true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.countrycode + " " + widget.phone,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AstroColors.colorLightGrey,
                            fontSize: appDimens!.text20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.edit),
                          color: AstroColors.colorLightGrey,
                          iconSize: appDimens!.iconsize,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: GridView.count(
                    crossAxisCount: 6,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 1,
                    scrollDirection: Axis.vertical,
                    children: List<Container>.generate(
                      6,
                      (int index) => Container(
                        child: widgetList[index],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 50.0, left: 50.0, top: 40),
                  child: SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AstroColors.appColor,
                        textStyle: const TextStyle(color: Colors.white),
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side:
                                const BorderSide(color: AstroColors.appColor)),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _onButtonClick();
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _verifyPhoneNumber();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: appDimens!.paddingw6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Text(
                          "Didn't receive " + "SMS? ",
                          style: TextStyle(
                            color: AstroColors.colorLightGrey,
                            fontSize: appDimens!.text16,
                          ),
                        ),
                        Text(
                          "Resend",
                          style: TextStyle(
                            color: AstroColors.colorLightGrey,
                            fontSize: appDimens!.text16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            isLoading ? Utility.progress(context) : Container(),
          ],
        ),
      ),
    );
  }

  _onButtonClick() {
    performLogin(widget.phone);
    if (currController.text.trim() == "" ||
        controller1.text.trim() == "" ||
        controller2.text.trim() == "" ||
        controller3.text.trim() == "" ||
        controller4.text.trim() == "" ||
        controller5.text.trim() == "" ||
        controller6.text.trim() == "") {
      Utility.showToast(msg: "Please enter valid verification code.");
    } else {
      verifyOtp(controller1.text.trim() +
          controller2.text.trim() +
          controller3.text.trim() +
          controller4.text.trim() +
          controller5.text.trim() +
          controller6.text.trim());
    }
  }

  performLogin(String phone) {
    FocusManager.instance.primaryFocus?.unfocus();
    ApiService().getRegisterAPI(phone).then((response) {
      if (response.success == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeNavigation()),
            (route) => false);
      } else {}
    }).catchError((error) {});
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void deleteText() {
    if (currController.text.length == 0) {
    } else {
      currController.text = "";
      currController = controller3;
      return;
    }

    if (currController == controller1) {
      controller1.text = "";
    } else if (currController == controller2) {
      controller1.text = "";
      currController = controller1;
    } else if (currController == controller3) {
      controller2.text = "";
      currController = controller2;
    } else if (currController == controller4) {
      controller3.text = "";
      currController = controller3;
    } else if (currController == controller5) {
      controller4.text = "";
      currController = controller4;
    } else if (currController == controller6) {
      controller5.text = "";
      currController = controller5;
    }
  }
}
