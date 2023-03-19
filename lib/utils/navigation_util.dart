import 'package:flutter/material.dart';

class NavigationUtil {
  static final NavigationUtil _navigationUtil = NavigationUtil._internal();

  factory NavigationUtil() {
    return _navigationUtil;
  }

  NavigationUtil._internal();

  pushNavigate(BuildContext ctx, Widget screen, {Function? onResumeCallback}) {
    Navigator.of(ctx)
        .push(
      MaterialPageRoute(
        builder: (BuildContext context) => screen,
      ),
    )
        .then((value) {
      if (onResumeCallback != null) {
        onResumeCallback();
      }
    });
  }

  popAndPushNavigate(BuildContext ctx, Widget screen) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (BuildContext context) => screen,
      ),
    );
  }

  pushNameAndRemoveUntillNavigate(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);
  }

  popNavigate(BuildContext context) {
    Navigator.pop(context);
  }

  popUntil(BuildContext context, Widget screen) {
    Navigator.of(context).popUntil((route) => false);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
