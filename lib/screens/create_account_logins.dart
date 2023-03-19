import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/dimens.dart';
import 'package:login/screens/openpainter.dart';
import 'package:login/screens/otp_verfication.dart';

class CreateOTPScreen extends StatelessWidget {
  const CreateOTPScreen({Key? key}) : super(key: key);

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
                Padding(
                  padding:
                      const EdgeInsets.only(left: 35, top: 32, right: 35, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: '+91',
                            prefixIcon: SvgPicture.asset(
                              "assets/flag.svg",
                              height: 10,
                              width: 10,
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Enter your number",
                            filled: false,
                          ),
                        ),
                        flex: 5,
                      ),
                    ],
                  ),
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
                        'Send OTP',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>  OTPVerfication()));
                      },
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
}
