import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/dimens.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFunctions {
  CommonFunctions._privateConstructor();
  static final CommonFunctions instance = CommonFunctions._privateConstructor();

  showSnackBar(BuildContext context, String message) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      SnackBar snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

   Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  String formatTimestamp(int timestamp) {
    var format = DateFormat('dd MMMM, yyyy');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }

  main(int timeDate) {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);
  }

  String parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  AppBar buildAppBar(String titleText, BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: AstroColors.colorWhite,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkResponse(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/ic_back_button.svg',
                height: AstroDimens.backArrowHeight,
                width: AstroDimens.backArrowWidth,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        titleText,
        style: const TextStyle(
            color: AstroColors.textColorGrey,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
    );
  }
}
