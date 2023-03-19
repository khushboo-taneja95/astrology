import 'dart:developer' as devtools show log;

import 'package:login/constant/colors.dart';
import 'package:login/models/astrology_details_model.dart' as Astro show Data;
import 'package:flutter/material.dart';
import 'package:login/network/api_service.dart';
import 'package:login/utils/utility.dart';

class ConnectCallWidget extends StatefulWidget {
  final Astro.Data astroDetails;
  const ConnectCallWidget({
    Key? key,
    required this.astroDetails,
  }) : super(key: key);

  @override
  State<ConnectCallWidget> createState() => _ConnectCallWidgetState();
}

class _ConnectCallWidgetState extends State<ConnectCallWidget> {
  ApiService apiService = ApiService();
  // there will be three states,
  // 0: not connected, 1: connecting, 2: completed
  int connectionState = 0;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: totalWidth * .1,
      ),
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      child: Container(
        height: totalHeight > 200 ? 200 : totalHeight,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        child: Stack(
          children: mainWidget(context),
        ),
      ),
    );
  }

  List<Widget> mainWidget(BuildContext context) {
    // by default only title and message will be displayed...
    List<Widget> widgetList = [
      mainTitle(),
      messageWidget(),
    ];

    // if call is not connected or is completed then show action buttons.
    if (connectionState == 2 || connectionState == 0) {
      widgetList.add(
        actionButtons(context),
      );
    }

    return widgetList;
  }

  Widget messageWidget() {
    return Positioned(
      bottom: connectionState == 1 ? 0 : 40,
      top: 27,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            mainMessage(),
          ],
        ),
      ),
    );
  }

  Widget mainMessage() {
    if (connectionState == 0) {
      return RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Are you sure you want to connect a call with ',
            ),
            TextSpan(
              text: widget.astroDetails.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(
              text: '? ',
            ),
            const TextSpan(
              text: 'Balance will be deducted from your wallet.',
            ),
          ],
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      );
    } else if (connectionState == 1) {
      return RichText(
        text: const TextSpan(
          text:
              'Your call is being connected with astrologer, please pickup your phone on ring.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return RichText(
        text: const TextSpan(
          text:
              'Your call has been completed, your wallet balance will be adjusted sortly.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      );
    }
  }

  Widget actionButtons(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          connectionState == 2
              ? Container()
              : Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AstroColors.colorGreen,
                    ),
                    onPressed: connectTheCall,
                    child: const Text(
                      "Connect",
                      style: TextStyle(
                        color: AstroColors.bottomTapColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                ),
          connectionState == 2 ? Container() : const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AstroColors.colorRed,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                connectionState == 2 ? 'Go Back' : 'Cancel',
                style: const TextStyle(
                  color: AstroColors.bottomTapColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainTitle() {
    return const Positioned(
      top: 5,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 20,
        child: Text(
          'Connect Call',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ),
    );
  }

  connectTheCall() async {
    try {
      setState(() {
        connectionState = 1;
      });
      dynamic response =
          await apiService.placeCallWithAstrologer(widget.astroDetails.id!);
      print(response);
    } catch (e) {
      devtools.log('$e');
      setState(() {
        connectionState = 0;
      });
      Utility.showToast(
        msg: "Error while placing your call, please try again later.",
      );
    }
  }
}
