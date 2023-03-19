import 'package:flutter/material.dart';
import 'package:login/constant/colors.dart';

class AstroStyles {
  static const fontWeight400FontSize13 = TextStyle(
      color: AstroColors.textColorGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12);

  static const fw600FontSize14TextColorGrey = TextStyle(
      color: AstroColors.textColorGrey,
      fontWeight: FontWeight.w600,
      fontSize: 14);

  static const amtPayment = TextStyle(
      color: AstroColors.colorBlack, fontWeight: FontWeight.bold, fontSize: 15);

  static const titleTextStyle = TextStyle(
    color: AstroColors.textColorGrey,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

  static const fontWeight400FontSize12 = TextStyle(
      color: AstroColors.textColorGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12);

  static const fontWeight400FontSize12SecondaryColor = TextStyle(
      color: AstroColors.secondaryColor,
      fontWeight: FontWeight.w600,
      fontSize: 16);

  static const fontWaight400PrimaryColorViewAll = TextStyle(
    color: AstroColors.colorBlack,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static const fontWaight400TextColor = TextStyle(
    color: AstroColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static const titleBlog = TextStyle(
    color: AstroColors.colorBlack,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static const fw600ColorBlack = TextStyle(
    color: AstroColors.colorBlack,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static const detailsBlogsList = TextStyle(
    color: AstroColors.textColorGrey,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static ButtonStyle addToCartButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AstroColors.colorBlack),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      )));

  static ButtonStyle cancelButtonLightStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AstroColors.colorWhite),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: const BorderSide(color: AstroColors.borderColorGrey, width: 1),
      )));
}
