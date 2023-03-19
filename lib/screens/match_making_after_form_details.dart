import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/astrology_list_model.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/astrology_list.dart';
import 'package:login/screens/astrology_list_details.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class MatchMakingFormDetails extends StatefulWidget {
  const MatchMakingFormDetails({Key? key}) : super(key: key);

  @override
  State<MatchMakingFormDetails> createState() => _MatchMakingFormDetailsState();
}

class _MatchMakingFormDetailsState extends State<MatchMakingFormDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const ToolbarWithTitleAndBackbutton(
                title: 'Match Making Form Screen'),
            compatiblityScore(),
            summaryDetails(),
            getDosh(),
            getRecommededAstrology(),
          ],
        ),
      )),
    );
  }

  Widget compatiblityScore() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Compatiblity score of G with gg is ",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            " 31 %",
            style: TextStyle(
                color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget summaryDetails() {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      decoration: const BoxDecoration(
        color: AstroColors.aboutUsCardBackgroud,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Summary',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Your compatiblity score is 31 out of 100. There is average compatibility.",
                    style: TextStyle(
                      color: AstroColors.textColorGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDosh() {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      color: Colors.grey.shade200,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          height: 190.0,
          viewportFraction: 1,
        ),
        items: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.pink.shade100,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Mangal Dosh',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 15, bottom: 10.0),
                    child: Text(
                      'If you feel that you are burdened with debt. Or if you are having difficulty retaining money and end up spending it as soon as you get it.  ',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.arrow_back),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getRecommededAstrology() {
    return FutureBuilder<AstrologyListModel>(
        future: ApiService().getAstrologyList(),
        builder:
            (BuildContext context, AsyncSnapshot<AstrologyListModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              if (snapshot.error == AstroString.noInternet) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
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
              return astrlogyList(snapshot.data!);
            }
          }
        });
  }

  Widget astrlogyList(AstrologyListModel astroList) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Recommeded Astrology",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AstrologyListScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.pinkAccent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  height: 40,
                  width: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: const Center(
                        child: Text(
                          'View All',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              child: GridView.builder(
                itemCount: astroList.data!.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _astrologySlider(astroList.data!.data![index]);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _astrologySlider(AstrologyLst horscopeSlider) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AstrologyDetails(
                    itemID: horscopeSlider.id.toString(),
                  )));
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  horscopeSlider.image.toString(),
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        horscopeSlider.name.toString(),
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Exp: ' + horscopeSlider.experience.toString() + ' yrs',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${horscopeSlider.expertise!.join(', ')}',
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                        child: RatingBarIndicator(
                          rating: 4.5,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: Colors.grey.withOpacity(0.15),
                height: 55,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            '₹ ' + horscopeSlider.chatPerMinute.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                           Padding(
                            padding: EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: Icon(
                              Icons.call,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                           SizedBox(
                            width: 10,
                          ),
                           Icon(
                            Icons.message,
                            color: Colors.grey,
                            size: 20,
                          ),
                           SizedBox(
                            width: 10,
                          ),
                          // const Spacer(),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 8.0),
                          //   child: Text(
                          //     horscopeSlider.active.toString(),
                          //     style: const TextStyle(
                          //         color: Colors.green,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 12),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
