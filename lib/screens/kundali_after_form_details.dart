import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:login/constant/colors.dart';
import 'package:login/screens/astrology_list.dart';
import 'package:login/screens/astrology_list_details.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class KundaliFormDetails extends StatefulWidget {
  const KundaliFormDetails({Key? key}) : super(key: key);

  @override
  State<KundaliFormDetails> createState() => _KundaliFormDetailsState();
}

class _KundaliFormDetailsState extends State<KundaliFormDetails> {
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            ToolbarWithTitleAndBackbutton(title: 'Kundali Form Screen'),
            Container(
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
                    text: 'Basic',
                  ),
                  Tab(
                    text: 'Lagan',
                  ),
                  Tab(
                    text: 'Navamsa',
                  ),
                  Tab(
                    text: 'Dasha',
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              children: [
                getBasic(),
                getLagan(),
                getNavamsa(),
                getDasha(),
              ],
            ))
          ],
        ),
      )),
    );
  }

  Widget getBasic() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: SizedBox(
                  height: 50,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    color: (index % 2 == 0)
                        ? Colors.grey.shade200
                        : Colors.pink.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [Text('Name :'), Text('Khushboo')],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget getLagan() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/lagan.png'),
                ),
                getRecommededAstrology(),
              ],
            )),
      ),
    );
  }

  Widget getNavamsa() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/lagan.png'),
                ),
                getRecommededAstrology(),
              ],
            )),
      ),
    );
  }

  Widget getDasha() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: SizedBox(
                  height: 60,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    color: (index % 2 == 0)
                        ? Colors.grey.shade200
                        : Colors.pink.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Venus'),
                          Text('Tue Aug 24 2009'),
                          Text('Tue Aug 24 2059')
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget getRecommededAstrology() {
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
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AstrologyListScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => AstrologyDetails()));
                      },
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Ink.image(
                                image: const NetworkImage(
                                  'https://services.selectastro.in/Content/ProfileImage/oewocmwkqua.jpg',
                                ),
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
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: const [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Priya',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Exp: 8 yrs',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Vedic Astrlogy, Tarot Card Reader',
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
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 4.0),
                                      child: RatingBarIndicator(
                                        rating: 4.5,
                                        itemBuilder: (context, index) =>
                                            const Icon(
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
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              height: 50,
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, top: 4.0),
                                        child: Text(
                                          '₹ 100',
                                          style: TextStyle(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                fontSize: 12),
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
}
