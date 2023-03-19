import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/daily_horscope_model.dart';
import 'package:login/models/horscope_models.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/home_navigation.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/utils/extentions.dart';
import 'package:login/utils/navigation_util.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class HorscopeDetailsScreen extends StatefulWidget {
  final String zodiac;
  const HorscopeDetailsScreen({Key? key, required this.zodiac})
      : super(key: key);

  @override
  State<HorscopeDetailsScreen> createState() => _HorscopeDetailsScreenState();
}

class _HorscopeDetailsScreenState extends State<HorscopeDetailsScreen> {
  bool _canPop = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_canPop) {
          NavigationUtil()
              .pushNameAndRemoveUntillNavigate(context, HomeNavigation());
          return true;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            const ToolbarWithTitleAndBackbutton(title: 'Horscope Screen'),
            getHorscope(),
          ],
        )),
      ),
    );
  }

  Widget getHorscope() {
    return FutureBuilder<HorscopeModel>(
        future: ApiService().getHorscopeList(),
        builder: (BuildContext context, AsyncSnapshot<HorscopeModel> snapshot) {
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
              return _horscopeList(snapshot.data!);
            }
          }
        });
  }

  Widget _horscopeList(HorscopeModel horscopeList) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8, top: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Horscope Today",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  itemCount: horscopeList.data!.length,
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _horscopeSlider(
                        horscopeList.data![index], DailyHorscopeModel());
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              getRecommededAstrology(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _horscopeSlider(
      Data horscopeSlider, DailyHorscopeModel dailyHorscopeModel) {
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

  Widget getRecommededAstrology() {
    return FutureBuilder<DailyHorscopeModel>(
        future: ApiService().getDailyHorscopeModel(widget.zodiac),
        builder:
            (BuildContext context, AsyncSnapshot<DailyHorscopeModel> snapshot) {
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
              return getHomeBanners(snapshot.data!);
            }
          }
        });
  }

  Widget getHomeBanners(DailyHorscopeModel dailyHorscopeModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${dailyHorscopeModel.data!.luckyNumber!.join(', ')}',
                    style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        dailyHorscopeModel.data!.luckyColorCode!.toColor(),
                    radius: 15,
                    child: Text(""),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    "Lucky Number",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Lucky Color",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ExpansionTile(
          title: Text(
            dailyHorscopeModel.data!.zodiac.toString(),
            style: const TextStyle(
                color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
          ),
          children: dailyHorscopeModel.data!.botResponse!
              .map((e) => ExpansionTile(
                      title: Text(e.title.toString().toUpperCase()),
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(e.splitResponse!)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Score " + e.score!.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ]))
              .toList(),
        ),
      ],
    );
  }

  showClubs(String dailyHorscopeModel) {
    return Text(
      dailyHorscopeModel.toString(),
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  showPlayers(DailyHorscopeModel dailyHorscopeModel) {
    return ListTile(
      title: Text(
        dailyHorscopeModel.data!.botResponse!.first.splitResponse.toString(),
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
