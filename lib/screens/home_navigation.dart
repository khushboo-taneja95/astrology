import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/screens/about_us.dart';
import 'package:login/screens/astrology_list.dart';
import 'package:login/screens/blogs_list.dart';
import 'package:login/screens/consultation_history.dart';
import 'package:login/screens/edit_profile.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/notification_list.dart';
import 'package:login/screens/recharge_wallet_screen.dart';
import 'package:login/screens/wallet_screen.dart';
import 'package:login/screens/webview_in_app.dart';
import 'package:login/utils/navigation_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class HomeNavigation extends StatefulWidget {
  HomeNavigation({Key? key, this.index}) : super(key: key);
  int? index;
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation>
    with SingleTickerProviderStateMixin {
  double finalAngle = 0.0;

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 5000))
        ..repeat();

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];
  // final List<Widget> _widgetOptions = [

  //    HomeScreen(),
  //   const BlogsList(),
  //   const AstrologyListScreen(),
  //   const RechargeWalletScreen(),
  //   const EditProfileScreen(),
  // ];
  @override
  void initState() {
    _widgetOptions = [
      HomeScreen(
        callBack: onTabTapped,
      ),
      const BlogsList(),
      const AstrologyListScreen(),
      const RechargeWalletScreen(),
      const EditProfileScreen(),
    ];
    _selectedIndex = widget.index ?? 0;
    super.initState();
  }

  void onTabTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Row(
            children: [
              // Transform.rotate(
              //   angle: finalAngle,
              //   child: Image.asset(
              //     'assets/icon_logo.png',
              //     width: 50,
              //   ),
              // ),
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 0.5 * math.pi,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/icon_logo.png',
                  width: 50,
                ),
              ),
              Image.asset(
                'assets/name_lgo.png',
                width: 140,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            // InkWell(
            //   onTap: () {
            //     print("object");
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 8),
            //     child: Container(
            //       width: 80,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: const BorderRadius.all(Radius.circular(50)),
            //         border: Border.all(
            //           color: Colors.black,
            //         ),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: const [
            //           Text(
            //             '₹ 0  ',
            //             style: TextStyle(color: Colors.black, fontSize: 14),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            )
          ]),
      drawer: Drawer(
        child: getDrawer(),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AstroColors.bottomTapColor,
        elevation: 16,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AstroColors.bottomTapUnselectedColor,
        unselectedItemColor: AstroColors.bottomTapUnselectedColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/home.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            activeIcon: SvgPicture.asset(
              "assets/home.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/ic_blog.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            activeIcon: SvgPicture.asset(
              "assets/ic_blog.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/ic_consult.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            activeIcon: SvgPicture.asset(
              "assets/ic_consult.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            label: 'Consult',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/store.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            activeIcon: SvgPicture.asset(
              "assets/store.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            label: 'Recharge',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/ic_profile.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            activeIcon: SvgPicture.asset(
              "assets/ic_profile.svg",
              height: 22,
              width: 22,
              color: AstroColors.colorBlack,
            ),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  Widget getDrawer() {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/ic_about.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text("About Us"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AboutUs()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      'assets/ic_consult.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text('Consultation History'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ConsultationHistory()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      'assets/ic_wallet.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text('Wallet History'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WalletScreen()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      'assets/ic_terms.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text('Terms & Conditions'),
                    onTap: () {
                      NavigationUtil().pushNavigate(
                          context,
                          const WebviewInApp(
                            toolbarTitle: "Terms & Conditions",
                            pageURL: AstroString.termsConditionsURL,
                          ));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      'assets/ic_notifications.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text('Notifications'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Image.asset(
                      'assets/ic_supports.png',
                      width: 24,
                      height: 24,
                    ),
                    title: const Text('Support Us'),
                    onTap: () {
                      launch('tel:${AstroString.supportNo}');
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
