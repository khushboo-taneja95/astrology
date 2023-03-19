import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/astrology_list_model.dart';
import 'package:login/models/blogs_homepage_model.dart';
import 'package:login/models/categories_model.dart';
import 'package:login/models/home_banner_models.dart';
import 'package:login/models/horscope_models.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/astrology_list_details.dart';
import 'package:login/screens/blogs_details.dart';
import 'package:login/screens/home_navigation.dart';
import 'package:login/screens/horscope_details.dart';
import 'package:login/screens/recharge_wallet_screen.dart';
import 'package:login/screens/astrology_list.dart';
import 'package:login/screens/panchang_screen.dart';
import 'package:login/utils/commom_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.callBack});
  final Function(int)? callBack;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<HomeBanner> homeBanners;
  late Future<SkillsCategoriesModel> sliderCategory;
  late Future<BlogsHomePageModel> slider;
  late Future<HorscopeModel> horscopeSlider;

  @override
  void initState() {
    super.initState();
    homeBanners = ApiService().getHomeBannerSections();
    sliderCategory = ApiService().getCategoriesSlider();
    slider = ApiService().getBlogsHomePageList();
    horscopeSlider = ApiService().getHorscopeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getCategories(),
            const Divider(),
            getHomeBanners(),
            const Divider(),
            getSkillSliders(),
            const Divider(),
            getRecommededAstrology(),
            const Divider(),
            offerBanners(),
            const Divider(),
            getHorscope(),
            const Divider(),
            getTredingBanners(),
          ],
        ),
      ),
    );
  }

  Widget getSkillSliders() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PanchangScreen()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/panchang.png',
                  // width: 120.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeNavigation(
                          index: 3,
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/recharge_offer.png',
                  // width: 120.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget getSkillSliders() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8.0, right: 8),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           height: (MediaQuery.of(context).size.height / 4.0),
  //           child: ListView(
  //               shrinkWrap: true,
  //               scrollDirection: Axis.horizontal,
  //               children: [
  //                 // Padding(
  //                 //   padding: const EdgeInsets.only(left: 4.0, right: 8.0),
  //                 //   child: SizedBox(
  //                 //     width: 120,
  //                 //     child: Column(
  //                 //       children: <Widget>[
  //                 //         GestureDetector(
  //                 //           onTap: () {
  //                 //             Navigator.of(context).push(MaterialPageRoute(
  //                 //                 builder: (context) => const LoveScore()));
  //                 //           },
  //                 //           child: ClipRRect(
  //                 //             borderRadius: BorderRadius.circular(15.0),
  //                 //             child: const Image(
  //                 //               image: AssetImage('assets/love.png'),
  //                 //             ),
  //                 //           ),
  //                 //         ),
  //                 //       ],
  //                 //     ),
  //                 //   ),
  //                 // ),
  //                 // Padding(
  //                 //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //                 //   child: SizedBox(
  //                 //     width: 120,
  //                 //     child: Column(
  //                 //       children: <Widget>[
  //                 //         GestureDetector(
  //                 //           onTap: () {
  //                 //             Navigator.of(context).push(MaterialPageRoute(
  //                 //                 builder: (context) => const KundaliScreen()));
  //                 //           },
  //                 //           child: ClipRRect(
  //                 //             borderRadius: BorderRadius.circular(15.0),
  //                 //             child: const Image(
  //                 //               image: AssetImage('assets/kundali.png'),
  //                 //             ),
  //                 //           ),
  //                 //         ),
  //                 //       ],
  //                 //     ),
  //                 //   ),
  //                 // ),
  //                 // Padding(
  //                 //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //                 //   child: SizedBox(
  //                 //     width: 120,
  //                 //     child: Column(
  //                 //       children: <Widget>[
  //                 //         GestureDetector(
  //                 //           onTap: () {
  //                 //             Navigator.of(context).push(MaterialPageRoute(
  //                 //                 builder: (context) =>
  //                 //                     const DailyHorscopeScreen()));
  //                 //           },
  //                 //           child: ClipRRect(
  //                 //             borderRadius: BorderRadius.circular(15.0),
  //                 //             child: const Image(
  //                 //               image: AssetImage('assets/daily_horscope.png'),
  //                 //             ),
  //                 //           ),
  //                 //         ),
  //                 //       ],
  //                 //     ),
  //                 //   ),
  //                 // ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //                   child: SizedBox(
  //                     width: 160,
  //                     child: Column(
  //                       children: <Widget>[
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.of(context).push(MaterialPageRoute(
  //                                 builder: (context) =>
  //                                     const PanchangScreen()));
  //                           },
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(15.0),
  //                             child: const Image(
  //                               image: AssetImage('assets/panchang.png'),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //                   child: SizedBox(
  //                     width: 160,
  //                     child: Column(
  //                       children: <Widget>[
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.of(context).push(MaterialPageRoute(
  //                                 builder: (context) =>
  //                                     const RechargeWalletScreen()));
  //                           },
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(15.0),
  //                             child: const Image(
  //                               image: AssetImage('assets/recharge_offer.png'),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ]),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget getCategories() {
    return FutureBuilder<SkillsCategoriesModel>(
      future: sliderCategory,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return categoriesSlider(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }

  Widget categoriesSlider(SkillsCategoriesModel categoryList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80,
          child: ListView.builder(
            itemCount: categoryList.data!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return categoriesTopSlider(categoryList.data![index]);
            },
          ),
        ),
      ],
    );
  }

  Widget categoriesTopSlider(CategoriesData categorySlider) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(constraints: const BoxConstraints()),
            ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                  maxWidth: 30,
                  maxHeight: 30,
                ),
                child: Image.network(
                  categorySlider.image!.colored.toString(),
                )),
            Text(
              categorySlider.name.toString(),
              style:
                  const TextStyle(color: AstroColors.colorBlack, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHomeBanners() {
    return FutureBuilder<HomeBanner>(
        future: homeBanners,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            HomeBanner? banners = snapshot.data;

            if (banners != null &&
                banners.data!.top != null &&
                banners.data!.top!.length > 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 190.0,
                    viewportFraction: 1,
                    autoPlay: true,
                  ),
                  items: banners.data!.top!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              i.image.toString(),
                              fit: BoxFit.contain,
                            ),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            }
          }

          return Container();
        }));
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
      padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                  if (widget.callBack != null) {
                    widget.callBack!(2);
                  }
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

  Widget _astrologySlider(AstrologyLst astrologyLst) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AstrologyDetails(
                    itemID: astrologyLst.id.toString(),
                  )));
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  astrologyLst.image.toString(),
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
                        astrologyLst.name.toString(),
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
                        'Exp: ' + astrologyLst.experience.toString() + ' yrs',
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
                        '${astrologyLst.expertise!.join(', ')}',
                        // astrologyLst.expertise
                        //     .toString()
                        //     .replaceAll(RegExp(r"\p{P}", unicode: true), ""),
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
                            '₹ ' + astrologyLst.chatPerMinute.toString(),
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
                          //     astrologyLst.active.toString(),
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

  Widget offerBanners() {
    return FutureBuilder<HomeBanner>(
        future: homeBanners,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            HomeBanner? banners = snapshot.data;

            if (banners != null &&
                banners.data!.bottom != null &&
                banners.data!.bottom!.length > 0) {
              return Padding(
                  padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 140.0,
                      viewportFraction: 1,
                      autoPlay: false,
                    ),
                    items: banners.data!.bottom!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                i.image.toString(),
                                fit: BoxFit.contain,
                              ),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ));
            }
          }

          return Container();
        }));
  }

  Widget getHorscope() {
    return FutureBuilder<HorscopeModel>(
      future: horscopeSlider,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _horscopeList(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }

  Widget _horscopeList(HorscopeModel horscopeModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Horscope Today",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              itemCount: horscopeModel.data!.length,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _horscopeSlider(horscopeModel.data![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _horscopeSlider(Data horscopeSlider) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 220,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: Column(
            children: <Widget>[
              Image.network(
                horscopeSlider.image.toString(),
                height: 74,
              ),
              Text(
                horscopeSlider.name.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              Text(
                horscopeSlider.dateString.toString(),
              ),
              SizedBox(
                width: 120.0,
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.black),
                        )),
                    child: const Text(
                      'Read More',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HorscopeDetailsScreen(
                                zodiac: horscopeSlider.apiValue.toString(),
                              )));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTredingBanners() {
    return FutureBuilder<BlogsHomePageModel>(
      future: slider,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return getBlogsBanner(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }

  Widget getBlogsBanner(BlogsHomePageModel blogsHomePageModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Blogs",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: blogsHomePageModel.data!.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _blogsBanners(blogsHomePageModel.data![index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blogsBanners(BlogsHomeData blogsHomeData) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlogDetailsScreen(
                    itemID: blogsHomeData.id.toString(),
                  )));
        },
        child: SizedBox(
          width: 280,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    blogsHomeData.image.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
