import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/screens/about_us.dart';
import 'package:login/screens/consultation_history.dart';
import 'package:login/screens/edit_profile.dart';
import 'package:login/screens/wallet_screen.dart';
import 'package:login/screens/webview_in_app.dart';
import 'package:login/utils/navigation_util.dart';
import 'package:login/widgets/toolbar_with_title.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ToolbarWithTitle(title: "Profile"),
              profile(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AstroColors.aboutUsCardBackgroud,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Total Balance ",
                                style: TextStyle(
                                  color: AstroColors.colorBlack,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                " ₹ 0",
                                style: TextStyle(
                                  color: AstroColors.colorBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              aboutUsOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget profile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
                child: Image.asset('assets/ic_contact.png'),
                backgroundColor: AstroColors.appColor),
            Positioned(
              right: -16,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Colors.white),
                    ),
                    primary: Colors.white,
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {
                    NavigationUtil()
                        .pushNavigate(context, const EditProfileScreen());
                  },
                  child: Image.asset(
                    'assets/ic_edit.png',
                    color: Colors.black,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget aboutUsOptions() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 24,
        left: 40,
        right: 40,
      ),
      child: Column(
        children: [
          InkResponse(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutUs()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: AstroColors.colorWhite,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AstroColors.containerBorderColor),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(3, 4),
                    blurRadius: 7,
                    color: AstroColors.colorBlack15Trans,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 20.0),
                child: Row(
                  children: [
                    const Text(
                      "About Us",
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/ic_next.svg",
                      height: 15.0,
                      width: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: InkResponse(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: AstroColors.colorWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: AstroColors.containerBorderColor),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(3, 4),
                      blurRadius: 7,
                      color: AstroColors.colorBlack15Trans,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20.0),
                  child: Row(
                    children: [
                      const Text(
                        "Recharge History",
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        "assets/ic_next.svg",
                        height: 15.0,
                        width: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkResponse(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ConsultationHistory()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: AstroColors.colorWhite,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AstroColors.containerBorderColor),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(3, 4),
                    blurRadius: 7,
                    color: AstroColors.colorBlack15Trans,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 20.0),
                child: Row(
                  children: [
                    const Text(
                      "Consultation History",
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/ic_next.svg",
                      height: 15.0,
                      width: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkResponse(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WalletScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: AstroColors.colorWhite,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AstroColors.containerBorderColor),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(3, 4),
                    blurRadius: 7,
                    color: AstroColors.colorBlack15Trans,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 20.0),
                child: Row(
                  children: [
                    const Text(
                      "Wallet History",
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/ic_next.svg",
                      height: 15.0,
                      width: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkResponse(
            onTap: () {
              NavigationUtil().pushNavigate(
                  context,
                  const WebviewInApp(
                    toolbarTitle: "Terms & Conditions",
                    pageURL: AstroString.termsConditionsURL,
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: AstroColors.colorWhite,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AstroColors.containerBorderColor),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(3, 4),
                    blurRadius: 7,
                    color: AstroColors.colorBlack15Trans,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 20.0),
                child: Row(
                  children: [
                    const Text(
                      "Terms & Conditions",
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/ic_next.svg",
                      height: 15.0,
                      width: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
