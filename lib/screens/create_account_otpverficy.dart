import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/dimens.dart';
import 'package:login/screens/openpainter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreateAccountVerfication extends StatefulWidget {
  const CreateAccountVerfication({Key? key}) : super(key: key);

  @override
  State<CreateAccountVerfication> createState() =>
      _CreateAccountVerficationState();
}

class _CreateAccountVerficationState extends State<CreateAccountVerfication> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: SvgPicture.asset(
                  "assets/ic_back_button.svg",
                  height: AstroDimens.backArrowHeight,
                  width: AstroDimens.backArrowWidth,
                ),
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
                const Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 8),
                  child: Text(
                    'OTP Verfication',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    'Enter the OTP sent +91xxxxxxxxxx',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 35, top: 80, right: 35, bottom: 0),
                  child: Container(child: enterOTPWidget()),
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
                            side: const BorderSide(
                                color: AstroColors.appColor)),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget enterOTPWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.phone,
        mainAxisAlignment: MainAxisAlignment.center,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 48,
            fieldWidth: 46,
            fieldOuterPadding: const EdgeInsets.only(left: 5, right: 5),
            activeFillColor: AstroColors.colorWhite,
            activeColor: AstroColors.otpInputBorderColor,
            inactiveFillColor: AstroColors.otpInputBorderColor,
            inactiveColor: AstroColors.otpInputBorderColor,
            selectedColor: AstroColors.otpInputBorderColor,
            selectedFillColor: AstroColors.otpInputBorderColor,
            errorBorderColor: AstroColors.otpInputBorderColor),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: false,
        controller: otpController,
        onCompleted: (v) {},
        onChanged: (value) {},
      ),
    );
  }
}
