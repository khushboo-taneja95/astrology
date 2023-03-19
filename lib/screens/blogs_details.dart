import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/constant/styles.dart';
import 'package:login/models/astrology_list_model.dart';
import 'package:login/models/blogs_details_model.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/astrology_list.dart';
import 'package:login/screens/astrology_list_details.dart';
import 'package:login/screens/home_navigation.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';
import 'package:readmore/readmore.dart';

class BlogDetailsScreen extends StatefulWidget {
  final Function(int)? callBack;
  final String itemID;
  const BlogDetailsScreen({Key? key, required this.itemID, this.callBack})
      : super(key: key);

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ToolbarWithTitleAndBackbutton(title: "Blog Details"),
            FutureBuilder<BlogsDetailsModel>(
                future: ApiService().getBlogsDetailsList(widget.itemID),
                builder: (BuildContext context,
                    AsyncSnapshot<BlogsDetailsModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      if (snapshot.error == AstroString.noInternet) {
                        WidgetsBinding.instance!
                            .addPostFrameCallback((timeStamp) {
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
                      return listData(snapshot.data!);
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget listData(BlogsDetailsModel blogsDetails) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            imageBlogs(blogsDetails),
            _buildTitle(blogsDetails),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageBlogs(BlogsDetailsModel blogsDetails) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage(
                  blogsDetails.data!.image.toString(),
                ),
                fit: BoxFit.fill)),
      ),
    );
  }

  Widget _buildTitle(BlogsDetailsModel blogsDetails) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Share With',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/ic_facebook.png',
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/ic_instagram.png',
                  width: 30,
                  height: 30,
                ),
                const Spacer(),
                Text(
                  CommonFunctions.instance
                      .formatTimestamp(blogsDetails.data!.date!),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              blogsDetails.data!.title.toString(),
              style: const TextStyle(
                color: AstroColors.colorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          //   child: Text(
          //       CommonFunctions.instance
          //             .parseHtmlString(blogsDetails.data!.content!),
          //     textAlign: TextAlign.justify,
          //   ),
          // )
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ReadMoreText(
              CommonFunctions.instance
                  .parseHtmlString(blogsDetails.data!.content!),
              trimLines: 10,
              colorClickableText: Colors.red,
              trimMode: TrimMode.Line,
              delimiter: " ",
              trimCollapsedText: 'more',
              trimExpandedText: 'less',
              textAlign: TextAlign.justify,
              lessStyle: AstroStyles.fontWeight400FontSize12SecondaryColor,
              moreStyle: AstroStyles.fontWeight400FontSize12SecondaryColor,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 2,
          ),
          getRecommededAstrology(),
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
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 20.0),
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
                      builder: (context) => HomeNavigation(
                            index: 2,
                          )));
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
                      padding: const EdgeInsets.only(top: 4.0),
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
