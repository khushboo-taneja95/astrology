import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/dimens.dart';

class ToolbarWithTitleAndBackbutton extends StatelessWidget {
  final String title;
  final Function? backFn;
  const ToolbarWithTitleAndBackbutton({
    Key? key,
    required this.title,
    this.backFn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        title,
        style: const TextStyle(
          color: AstroColors.textColorGrey,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
