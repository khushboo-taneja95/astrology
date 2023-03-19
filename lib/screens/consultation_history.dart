import 'dart:developer' as devtools show log, inspect;

import 'package:flutter/material.dart';
import 'package:login/models/consultation_history_models.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/rating_screen.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class ConsultationHistory extends StatefulWidget {
  const ConsultationHistory({Key? key}) : super(key: key);

  @override
  State<ConsultationHistory> createState() => _ConsultationHistoryState();
}

class _ConsultationHistoryState extends State<ConsultationHistory> {
  ApiService apiService = ApiService();
  bool loading = false;
  List<ConsultationsHistory> allConsultations = [];

  showLoading() {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
  }

  hideLoading() {
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  initialize() async {
    try {
      showLoading();
      List<ConsultationsHistory> consultationHistory =
          await apiService.getConsultations('call');
      devtools.inspect(consultationHistory);
      hideLoading();
    } catch (e) {
      devtools.log('$e');
      hideLoading();
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ToolbarWithTitleAndBackbutton(
                title: 'Consultation History',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(
                        text: 'All',
                      ),
                      Tab(
                        text: 'Chat',
                      ),
                      Tab(
                        text: 'Call',
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    getAll(),
                    getChat(),
                    getCall(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAll() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://services.selectastro.in/Content/ProfileImage/oewocmwkqua.jpg'),
                          ),
                          Text("Acharya Priya",
                              style: TextStyle(color: Colors.green)),
                          Text("Read Chat",
                              style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      "17/10/2022",
                    ),
                    Text(
                      "12:05",
                    ),
                    Text(
                      "4min 58sec",
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Total Cost",
                    ),
                    const Text(
                      "₹ 5",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.green),
                          )),
                      child: const Text(
                        'FeedBack',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RatingScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget getChat() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://services.selectastro.in/Content/ProfileImage/oewocmwkqua.jpg'),
                          ),
                          Text("Acharya Priya",
                              style: TextStyle(color: Colors.green)),
                          Text("Read Chat",
                              style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      "17/10/2022",
                    ),
                    Text(
                      "12:05",
                    ),
                    Text(
                      "4min 58sec",
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Total Cost",
                    ),
                    const Text(
                      "₹ 5",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.green),
                          )),
                      child: const Text(
                        'FeedBack',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RatingScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget getCall() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://services.selectastro.in/Content/ProfileImage/oewocmwkqua.jpg'),
                          ),
                          Text("Acharya Priya",
                              style: TextStyle(color: Colors.green)),
                          Text("Read Chat",
                              style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      "17/10/2022",
                    ),
                    Text(
                      "12:05",
                    ),
                    Text(
                      "4min 58sec",
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Total Cost",
                    ),
                    const Text(
                      "₹ 5",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.green),
                          )),
                      child: const Text(
                        'FeedBack',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RatingScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
