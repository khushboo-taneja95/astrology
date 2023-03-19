import 'package:flutter/material.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/dimens.dart';

class ToolbarWithTitle extends StatelessWidget {
  final String title;
  final Function? backFn;
  const ToolbarWithTitle({
    Key? key,
    required this.title,
    this.backFn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54 + AstroDimens.backArrowHeight,
      child: Container(
        decoration: const BoxDecoration(
          color: AstroColors.colorWhite,
          border: Border(
            bottom: BorderSide(
              color: AstroColors.dividerColor,
              width: 1,
            ),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 70.0, right: 60.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AstroColors.textColorGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
