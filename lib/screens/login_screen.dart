import 'package:flutter/material.dart';
import 'package:login/constant/appDimens.dart';
import 'package:login/constant/colors.dart';
import 'package:login/screens/openpainter.dart';
import 'package:login/screens/otp_verfication.dart';
import 'package:login/utils/utility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AppDimens? appDimens;
  TextEditingController textEditingController = TextEditingController();
  Size? size;
  MediaQueryData? mediaQuerydata;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuerydata = MediaQuery.of(context);
    size = MediaQuery.of(context).size;
    appDimens = new AppDimens(size!);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Image.asset(
                  "assets/astro_logo.png",
                  height: 110,
                  width: 120,
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
                  child: Text(
                    "Welcome!\nPlease enter your mobile number to log in.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: appDimens!.paddingw20,
                ),
                emailMobileView(),
                SizedBox(
                  height: appDimens!.paddingw20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 50.0, left: 50.0, top: 40),
                  child: SizedBox(
                    height: 50,
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
                        'Send OTP',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        continueClick();
                      },
                    ),
                  ),
                ),
                Spacer(),
                Spacer(),
                Container(
                  width: size!.width,
                  margin: EdgeInsets.only(bottom: appDimens!.paddingw16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: appDimens!.paddingw18,
                      ),
                    ],
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

  Widget emailMobileView() {
    return Container(
      margin: EdgeInsets.only(
        left: appDimens!.paddingw16 * 2,
        right: appDimens!.paddingw16 * 2,
        bottom: appDimens!.paddingw16,
      ),
      decoration: BoxDecoration(
        color: AstroColors.colorWhite,
        border: Border.all(color: AstroColors.colorBlack, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: appDimens!.paddingw6,
              right: appDimens!.paddingw6,
            ),
            child: Text(
              "+91",
              style: TextStyle(
                  fontSize: appDimens!.text16,
                  color: AstroColors.colorLightGrey),
            ),
          ),
          const Text(
            "|",
            style: TextStyle(fontSize: 33, color: Colors.grey),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: appDimens!.paddingw6,
            ),
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(
                  fontSize: appDimens!.text16,
                  color: AstroColors.colorLightGrey),
              controller: textEditingController,
              maxLength: 10,
              decoration: const InputDecoration(
                hintText: "Mobile Number",
                counterText: "",
                hintStyle: TextStyle(color: AstroColors.colorLightGrey),
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
            ),
          )
        ],
      ),
    );
  }

  continueClick() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerfication(
          phone: textEditingController.text,
          countrycode: "+91",
        ),
      ),
    );
  }
}
