import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/astrology_details_model.dart';
import 'package:login/models/astrology_details_model.dart' as Astro show Data;
import 'package:login/network/api_service.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/widgets/connect_call_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AstrologyDetails extends StatefulWidget {
  final String itemID;
  const AstrologyDetails({Key? key, required this.itemID}) : super(key: key);

  @override
  State<AstrologyDetails> createState() => _AstrologyDetailsState();
}

class _AstrologyDetailsState extends State<AstrologyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonFunctions.instance.buildAppBar(
        'Astrology Details Screen',
        context,
      ),
      body: SafeArea(
        child: HomePage(
          itemID: widget.itemID,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String itemID;

  const HomePage({Key? key, required this.itemID}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;
  var _collapsedHeight = 200.0;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    var _collapsedHeight = 200.0;
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          FutureBuilder<AstrologyDetailsModel>(
            future: ApiService().getAstrologyListDetails(widget.itemID),
            builder: (
              BuildContext context,
              AsyncSnapshot<AstrologyDetailsModel> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  if (snapshot.error == AstroString.noInternet) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      CommonFunctions.instance.showSnackBar(
                        context,
                        AstroString.noInternet,
                      );
                    });
                  } else {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      CommonFunctions.instance.showSnackBar(
                        context,
                        snapshot.error.toString(),
                      );
                    });
                  }
                  return Container(
                    height: 30.0,
                  );
                } else {
                  return sliding(snapshot.data!);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget sliding(AstrologyDetailsModel astrologyDetailsModel) {
    return SlidingUpPanel(
      minHeight: _collapsedHeight,
      maxHeight: _panelHeightOpen,
      parallaxEnabled: true,
      parallaxOffset: .5,
      body: astroImage(astrologyDetailsModel),
      panelBuilder: (sc) => _panel(sc, astrologyDetailsModel),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
    );
  }

  Widget astroImage(AstrologyDetailsModel astrologyDetailsModel) {
    return Image(
      image: NetworkImage(
        astrologyDetailsModel.data!.image.toString(),
      ),
      fit: BoxFit.cover,
    );
  }

  Widget _panel(
      ScrollController sc, AstrologyDetailsModel astrologyDetailsModel) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18.0,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    astrologyDetailsModel.data!.name.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Exp: ' +
                        astrologyDetailsModel.data!.experience.toString() +
                        ' yrs',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15.0),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       astrologyDetailsModel.data!.skills.toString(),
              //       style: const TextStyle(color: Colors.black, fontSize: 14),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15.0),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       astrologyDetailsModel.data!.expertise.toString(),
              //       style: const TextStyle(color: Colors.black, fontSize: 14),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Language: " +
                        astrologyDetailsModel.data!.languages!.join(', '),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: RatingBarIndicator(
                    rating: 4.5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18.0,
          ),
          Container(
            color: Colors.grey.withOpacity(0.15),
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.call,
                        color: AstroColors.colorGreen,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.message,
                      color: Colors.orange,
                      size: 20,
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text('Charges'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            '₹ ' +
                                astrologyDetailsModel.data!.chatPerMinute
                                    .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8,
              top: 8,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Expertise',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${astrologyDetailsModel.data!.expertise!.join(', ')}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8,
              top: 8,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Skills',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${astrologyDetailsModel.data!.skills!.join(', ')}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AstroColors.appColor,
              ),
              onPressed: () => connectCall(astrologyDetailsModel.data!),
              child: const Text(
                "Connect Call",
                style: TextStyle(
                  color: AstroColors.aboutUsCardBackgroud,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          // Container(
          //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: const [
          //       Text("Description",
          //           style:
          //               TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          //       SizedBox(
          //         height: 12.0,
          //       ),
          //       Text(
          //         """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. etropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n\nPittsburgh is located in the southwest of the state, at the confluence of the Allegheny, Monongahela, and Ohio rivers. Pittsburgh is known both as "the Steel City" for its more than 300 steel-related businesses and as the "City of Bridges" for its 446 bridges. The city features 30 skyscrapers, two inclined railways, a pre-revolutionary fortification and the Point State Park at the confluence of the rivers. The city developed as a vital link of the Atlantic coast and Midwest, as the mineral-rich Allegheny Mountains made the area coveted by the French and British empires, Virginians, Whiskey Rebels, and Civil War raiders.
          //       """,
          //         softWrap: true,
          //       ),
          //     ],
          //   ),
          // ),
          // const Divider(),
          // const SizedBox(
          //   height: 5,
          // ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
          //   child: Text("Reviews",
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 15,
          //     right: 15,
          //   ),
          //   child: SizedBox(
          //     height: 70,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             const Padding(
          //               padding: EdgeInsets.only(left: 8.0),
          //               child: CircleAvatar(
          //                 child: Icon(
          //                   Icons.contact_page,
          //                   color: Colors.white,
          //                   size: 20,
          //                 ),
          //               ),
          //             ),
          //             const SizedBox(
          //               width: 20,
          //             ),
          //             Column(
          //               children: [
          //                 Text(
          //                   astrologyDetailsModel.data!.reviews.toString(),
          //                   style: const TextStyle(color: Colors.red),
          //                 ),
          //                 RatingBarIndicator(
          //                   rating: 4.5,
          //                   itemBuilder: (context, index) => const Icon(
          //                     Icons.star,
          //                     color: Colors.amber,
          //                   ),
          //                   itemCount: 5,
          //                   itemSize: 14.0,
          //                   direction: Axis.horizontal,
          //                 ),
          //                 const Text(
          //                   'today',
          //                   style:
          //                       TextStyle(color: Colors.black, fontSize: 14),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  connectCall(Astro.Data data) async {
    await showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ConnectCallWidget(astroDetails: data);
      },
    );
  }
}
