import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/constant/styles.dart';
import 'package:login/models/astrology_list_model.dart' as Astro
    show AstrologyListModel, AstrologyLst;
import 'package:login/models/languages_model.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/astrology_list_details.dart';
import 'package:login/utils/commom_functions.dart';

class AstrologyListScreen extends StatefulWidget {
  const AstrologyListScreen({Key? key}) : super(key: key);

  @override
  State<AstrologyListScreen> createState() => _AstrologyListScreenState();
}

enum SortBy { lowToHigh, hignToLow, notSelected }

class _AstrologyListScreenState extends State<AstrologyListScreen> {
  ScrollController scrollController = ScrollController();
  SortBy selectedShot = SortBy.notSelected;
  late Future<LanguagesModel> filterResponse;
  String sort = "none";
  List<Astro.AstrologyLst> _completeList = [];
  bool isSomeLeft = true;
  int page = 1;
  ApiService apiService = ApiService();
  Future<List<Astro.AstrologyLst>>? _simpleFuture;
  double lastScrollPosition = 0.0;

  Future<List<Astro.AstrologyLst>> initialize() async {
    if (isSomeLeft) {
      try {
        Astro.AstrologyListModel response = await apiService.getAstrologyList(
          page: page,
        );

        if (response.data != null &&
            response.data!.data != null &&
            response.data!.data!.isNotEmpty) {
          setState(() {
            _completeList.insertAll(0, response.data!.data!);
            page++;
            if (response.data!.data!.length < 10) {
              isSomeLeft = false;
            }
          });
        }

        return _completeList;
      } catch (e) {
        devtools.log('$e');
      }
    }

    scrollController.position.setPixels(
      scrollController.position.maxScrollExtent,
    );
    return _completeList;
  }

  checkIsAtLast() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      print('is at bottom');
      setState(() {
        _simpleFuture = initialize();
        lastScrollPosition = scrollController.position.pixels;
      });
    }
  }

  @override
  void initState() {
    _simpleFuture = initialize();
    scrollController.addListener(checkIsAtLast);
    super.initState();
    filterResponse = ApiService().getLanguageFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sortAndFilter(),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: getAstrology(),
            ),
          ],
        ),
      ),
    );
  }

  Widget sortAndFilter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InkResponse(
              onTap: () {
                showFilterOptions();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 48,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/ic_filters.svg',
                          height: 12,
                          width: 12,
                          color: AstroColors.colorBlack,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: Text(
                            "Filters",
                            style: AstroStyles.fw600ColorBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkResponse(
              onTap: () {
                sortBySheet(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 48,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/ic_sort.svg',
                          height: 12,
                          width: 12,
                          color: AstroColors.colorBlack,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          "Sort",
                          style: AstroStyles.fw600ColorBlack,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showFilterOptions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bCtx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSheetState) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .48,
                    child: FutureBuilder<LanguagesModel>(
                      future: filterResponse,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 25, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Languages ",
                                      style: AstroStyles.fw600ColorBlack,
                                    ),
                                    InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 24,
                                        color: AstroColors.colorLightGrey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .38,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.data!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            // SvgPicture.asset(
                                            //   "assets/radio_enabled.svg",
                                            //   width: 12,
                                            //   height: 12,
                                            // ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 4),
                                                Text(
                                                  snapshot.data!.data![index],
                                                  style: AstroStyles
                                                      .fontWaight400PrimaryColorViewAll,
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Container(
                    color: AstroColors.filterBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 6.0, bottom: 6.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 36,
                            child: ElevatedButton(
                                style: AstroStyles.cancelButtonLightStyle,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "CLOSE",
                                  style: TextStyle(
                                      color: AstroColors.colorBlack,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              style: AstroStyles.addToCartButtonStyle,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("APPLY",
                                  style: TextStyle(
                                      color: AstroColors.textColorWhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  void sortBySheet(context) {
    showModalBottomSheet(
      backgroundColor: AstroColors.colorWhite,
      context: context,
      builder: (BuildContext bc) {
        return SizedBox(
          height: 216,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sort By",
                      style: AstroStyles.fw600ColorBlack,
                    ),
                    InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: AstroColors.colorLightGrey,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: const Text(
                    'Price - Low to High',
                    style: AstroStyles.fw600ColorBlack,
                  ),
                  leading: Radio<SortBy>(
                    value: SortBy.lowToHigh,
                    groupValue: selectedShot,
                    onChanged: (SortBy? value) {
                      selectedShot = value!;
                      sort = "asc";
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Price - High to Low',
                    style: AstroStyles.fw600ColorBlack,
                  ),
                  leading: Radio<SortBy>(
                    value: SortBy.hignToLow,
                    groupValue: selectedShot,
                    onChanged: (SortBy? value) {
                      selectedShot = value!;
                      sort = "desc";
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getAstrology() {
    return FutureBuilder<List<Astro.AstrologyLst>>(
      future: _simpleFuture!,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Astro.AstrologyLst>> snapshot,
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
            return astrologersList(snapshot.data!);
          }
        }
      },
    );
  }

  Future<void> refrsh() async {
    setState(() {});
  }

  Widget astrologersList(List<Astro.AstrologyLst> astroList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: refrsh,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: astroList.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return astrologyCardList(astroList[index]);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.0),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
        ),
      ),
    );
  }

  Widget astrologyCardList(Astro.AstrologyLst horscopeSlider) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AstrologyDetails(
                itemID: horscopeSlider.id.toString(),
              ),
            ),
          );
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
                        '${horscopeSlider.languages!.join(', ')}',
                        maxLines: 2,
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
                              fontWeight: FontWeight.bold,
                            ),
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
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Available',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
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
          ],
        ),
      ),
    );
  }
}
