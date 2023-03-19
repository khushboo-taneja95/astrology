import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/screens/create_account.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/openpainter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                Padding(
                  padding:
                      const EdgeInsets.only(right: 40.0, left: 40.0, top: 60),
                  child: Container(
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
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const LoginScreen()));
                      },
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                // const Text(
                //   'Or',
                //   style: TextStyle(fontSize: 18),
                //   textAlign: TextAlign.center,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       right: 40.0, left: 40.0, top: 20, bottom: 20),
                //   child: Container(
                //     height: 50,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         primary: AstroColors.customPainterColor,
                //         textStyle: const TextStyle(color: Colors.white),
                //         padding: const EdgeInsets.only(top: 12, bottom: 12),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15.0),
                //             side: const BorderSide(
                //                 color: AstroColors.customPainterColor)),
                //       ),
                //       child: const Text(
                //         'Signup',
                //         style: TextStyle(
                //             fontSize: 20, fontWeight: FontWeight.bold),
                //       ),
                //       onPressed: () {
                //         Navigator.of(context).push(MaterialPageRoute(
                //             builder: (context) => CreateAccountScreen()));
                //       },
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 60),
                // Center(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Container(color: Colors.grey, width: 60, height: 4),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       const Text(
                //         "Or",
                //         style: TextStyle(color: Colors.grey, fontSize: 20),
                //       ),
                //       SizedBox(width: 10),
                //       Container(color: Colors.grey, width: 60, height: 4),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       right: 40.0, left: 40.0, top: 10, bottom: 20),
                //   child: Container(
                //     height: 50,
                //     child: ElevatedButton.icon(
                //       icon: SvgPicture.asset(
                //         "assets/google_icon.svg",
                //         height: 24,
                //         width: 24,
                //       ),
                //       style: ElevatedButton.styleFrom(
                //         primary: Colors.white,
                //         textStyle: const TextStyle(color: Colors.white),
                //         padding: const EdgeInsets.only(top: 12, bottom: 12),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(25.0),
                //             side: const BorderSide(color: Colors.black)),
                //       ),
                //       label: const Text(
                //         'Login with Google',
                //         style: TextStyle(
                //           fontSize: 20,
                //           color: Colors.black,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       onPressed: () {},
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
