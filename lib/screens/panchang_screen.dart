import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/astrology_list_model.dart';
import 'package:login/models/panchang_models.dart';
import 'package:login/models/panchang_tommorow_models.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/astrology_list.dart';
import 'package:login/screens/astrology_list_details.dart';
import 'package:login/screens/home_navigation.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class PanchangScreen extends StatefulWidget {
  final Function(int)? callBack;
  const PanchangScreen({Key? key, this.callBack}) : super(key: key);

  @override
  State<PanchangScreen> createState() => _PanchangScreenState();
}

class _PanchangScreenState extends State<PanchangScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            const ToolbarWithTitleAndBackbutton(title: 'Panchang Screen'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Today',
                    ),
                    Tab(
                      text: 'Tomorrow',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
              children: [
                getTodayData(),
                getTommorow(),
              ],
            ))
          ],
        ),
      )),
    );
  }

  Widget getTodayData() {
    return FutureBuilder<PanchangModel>(
        future: ApiService().getPanchang(),
        builder: (BuildContext context, AsyncSnapshot<PanchangModel> snapshot) {
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
              return getToday(snapshot.data!);
            }
          }
        });
  }

  Widget getToday(PanchangModel panchangModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Center(
                child: Text(
                  panchangModel.data!.date.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AstroColors.textColorGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.shubhMuhurat!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.shubhMuhurat!.start.toString() +
                                ' to ' +
                                panchangModel.data!.shubhMuhurat!.end
                                    .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AstroColors.textColorGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.rahukaal!.title.toString(),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.rahukaal!.value.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AstroColors.textColorGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.gulika!.title.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.gulika!.value.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AstroColors.textColorGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.yamakanta!.title.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.yamakanta!.value.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 3.5),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            ),
          ),
          getSun(panchangModel),
          const SizedBox(
            height: 15,
          ),
          getTithi(panchangModel),
          getRecommededAstrology(),
        ],
      ),
    );
  }

  Widget getTodayList(Data dfdfd) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AstroColors.textColorGrey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                child: Text(
                  dfdfd.shubhMuhurat.toString(),
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
              child: Text(
                dfdfd.shubhMuhurat!.start.toString() +
                    ' to ' +
                    dfdfd.shubhMuhurat!.end.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSun(PanchangModel panchangModel) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          width: 350,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.sun!.rise!.title.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/sunrise.png',
                          width: 70,
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.sun!.rise!.value.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.sun!.set!.title.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/sunset.png',
                          width: 70,
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.sun!.set!.value.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  Widget getTithi(PanchangModel panchangModel) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 350,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.tithi!.title.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.tithi!.name.toString() +
                                ' : ' +
                                panchangModel.data!.tithi!.start.toString() +
                                ' to ' +
                                panchangModel.data!.tithi!.end.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.nakshatra!.title.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.nakshatra!.name.toString() +
                                ' : ' +
                                panchangModel.data!.nakshatra!.start
                                    .toString() +
                                ' to ' +
                                panchangModel.data!.nakshatra!.end.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangModel.data!.karana!.title.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangModel.data!.karana!.name.toString() +
                                ' : ' +
                                panchangModel.data!.karana!.start.toString() +
                                ' to ' +
                                panchangModel.data!.karana!.end.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  Widget getTommorow() {
    return FutureBuilder<PanchangTomorrowModel>(
        future: ApiService().getPanchangTomorrow(),
        builder: (BuildContext context,
            AsyncSnapshot<PanchangTomorrowModel> snapshot) {
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
              return getTommorowData(snapshot.data!);
            }
          }
        });
  }

  Widget getTommorowData(PanchangTomorrowModel panchangTomorrowModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Center(
                child: Text(
                  panchangTomorrowModel.data!.date.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AstroColors.textColorGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.shubhMuhurat!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.shubhMuhurat!.start
                                    .toString() +
                                ' to ' +
                                panchangTomorrowModel.data!.shubhMuhurat!.end
                                    .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AstroColors.textColorGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.rahukaal!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.rahukaal!.value
                                .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AstroColors.textColorGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.gulika!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.gulika!.value
                                .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AstroColors.textColorGrey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.yamakanta!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.yamakanta!.value
                                .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 3.5),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            ),
          ),
          getSunTomorrow(panchangTomorrowModel),
          const SizedBox(
            height: 15,
          ),
          getTithiTomorrow(panchangTomorrowModel),
          getRecommededAstrology(),
        ],
      ),
    );
  }

  Widget getSunTomorrow(PanchangTomorrowModel panchangTomorrowModel) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          width: 350,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.sun!.rise!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/sunrise.png',
                          width: 70,
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.sun!.rise!.value
                                .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.sun!.set!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/sunset.png',
                          width: 70,
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.sun!.set!.value
                                .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  Widget getTithiTomorrow(PanchangTomorrowModel panchangTomorrowModel) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 350,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.tithi!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.tithi!.name.toString() +
                                ' : ' +
                                panchangTomorrowModel.data!.tithi!.start
                                    .toString() +
                                ' to ' +
                                panchangTomorrowModel.data!.tithi!.end
                                    .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.nakshatra!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.nakshatra!.name
                                    .toString() +
                                ' : ' +
                                panchangTomorrowModel.data!.nakshatra!.start
                                    .toString() +
                                ' to ' +
                                panchangTomorrowModel.data!.nakshatra!.end
                                    .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Text(
                              panchangTomorrowModel.data!.karana!.title
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            panchangTomorrowModel.data!.karana!.name
                                    .toString() +
                                ' : ' +
                                panchangTomorrowModel.data!.karana!.start
                                    .toString() +
                                ' to ' +
                                panchangTomorrowModel.data!.karana!.end
                                    .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ],
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
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 15.0),
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
