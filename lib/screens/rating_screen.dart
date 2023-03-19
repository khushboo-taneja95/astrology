import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/screens/home_navigation.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _rating = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ToolbarWithTitleAndBackbutton(title: 'Rate the Services'),
            rateField(),
          ],
        ),
      ),
    );
  }

  Widget rateField() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RatingBar(
                  initialRating: 3,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 30,
                  ratingWidget: RatingWidget(
                    full: SvgPicture.asset('assets/rating_filled.svg'),
                    half: SvgPicture.asset('assets/rating_filled.svg'),
                    empty: SvgPicture.asset('assets/rating_empty.svg'),
                  ),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    _rating = rating;
                    SchedulerBinding.instance!.addPostFrameCallback((_) {
                      setState(() {});
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                getRating(_rating),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                    color: AstroColors.appColor),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AstroColors.colorBlack),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "How was the Call Quality?",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 40,
                            left: 40,
                            bottom: 20,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AstroColors.paymentButton,
                            ),
                            onPressed: () {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          // builder: (context) => HomeNavigation()));
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  color: AstroColors.aboutUsCardBackgroud,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getRating(var rating) {
    String ratingText = "";
    if (rating == 1.0) {
      ratingText = "VERY BAD";
    } else if (rating == 2.0) {
      ratingText = "BAD";
    } else if (rating == 3.0) {
      ratingText = "AVERAGE";
    } else if (rating == 4.0) {
      ratingText = "GOOD";
    } else if (rating == 5.0) {
      ratingText = "EXCELLENT";
    }
    return ratingText;
  }
}
