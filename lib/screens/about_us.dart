import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/about_us_model.dart';
import 'package:login/network/api_service.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/utils/navigation_util.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

import 'webview_in_app.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  CommonFunctions commonFunctions = CommonFunctions.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ToolbarWithTitleAndBackbutton(title: "About Us"),
            FutureBuilder<AboutUsModel>(
                future: ApiService().getAboutUs(),
                builder: (BuildContext context,
                    AsyncSnapshot<AboutUsModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      if (snapshot.error == AstroString.noInternet) {
                        WidgetsBinding.instance!
                            .addPostFrameCallback((timeStamp) {
                          CommonFunctions.instance
                              .showSnackBar(context, AstroString.noInternet);
                        });
                      } else {
                        SchedulerBinding.instance!.addPostFrameCallback((_) {
                          CommonFunctions.instance
                              .showSnackBar(context, snapshot.error.toString());
                        });
                      }
                      return Container(
                        height: 30.0,
                      );
                    } else {
                      return listData(snapshot.data!);
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget listData(AboutUsModel aboutUsModel) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTitle(aboutUsModel),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(AboutUsModel aboutUsModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              CommonFunctions.instance.parseHtmlString(aboutUsModel.data!),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Follow Us on',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    commonFunctions
                        .launchInBrowser(Uri.parse(AstroString.facebookURL));
                  },
                  child: Image.asset(
                    'assets/ic_facebook.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    NavigationUtil().pushNavigate(
                        context,
                        const WebviewInApp(
                          toolbarTitle: "Youtube",
                          pageURL: AstroString.youtubeURL,
                        ));
                  },
                  child: Image.asset(
                    'assets/ic_youtube.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    NavigationUtil().pushNavigate(
                        context,
                        const WebviewInApp(
                          toolbarTitle: "Instagram",
                          pageURL: AstroString.instagramURL,
                        ));
                  },
                  child: Image.asset(
                    'assets/ic_instagram.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkResponse(
                  onTap: () {
                    commonFunctions
                        .launchInBrowser(Uri.parse(AstroString.linkedURL));
                  },
                  child: Image.asset(
                    'assets/ic_linked.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
