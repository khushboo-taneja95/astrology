import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/constant/colors.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class AsrtoDetailsTab extends StatefulWidget {
  const AsrtoDetailsTab({Key? key}) : super(key: key);

  @override
  State<AsrtoDetailsTab> createState() => _AsrtoDetailsTabState();
}

class _AsrtoDetailsTabState extends State<AsrtoDetailsTab> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinputGirls = TextEditingController();
  TextEditingController dateinputKundali = TextEditingController();
  bool valuefirst = false;
  bool isChecked = false;

  @override
  void initState() {
    dateinput.text = "";
    dateinputGirls.text = "";
    dateinputKundali.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const ToolbarWithTitleAndBackbutton(title: "Astro Details Tab"),
      DefaultTabController(
          length: 3,
          child: Expanded(
              child: Column(
            children: [
              const TabBar(
                indicatorColor: AstroColors.paymentButton,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Daily Horoscope',
                  ),
                  Tab(
                    text: 'Kundali',
                  ),
                  Tab(
                    text: 'MatchMaking',
                  )
                ],
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  dailyHoroscope(),
                  kundali(),
                  matchMaking(),
                ],
              ))
            ],
          )))
    ])));
  }

  Widget dailyHoroscope() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 12,
        itemBuilder: (BuildContext ctx, int index) {
          return cardPackages();
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.1),
        ),
      ),
    );
  }

  Widget cardPackages() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: const [
          CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xffFDCF09),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/google.png'),
            ),
          ),
        ],
      ),
    );
  }

 

  Widget text() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Image(image: AssetImage('assets/healthhhhh.png')),
        ],
      ),
    );
  }

  Widget kundali() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          text(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AstroColors.paymentButton, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Name',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: dateinputKundali,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Dob',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          dateinputKundali.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Time',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Place of Birth',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.red,
                  value: this.valuefirst,
                  onChanged: (bool? value) {
                    setState(() {
                      valuefirst = value!;
                    });
                  },
                ),
                Text('Male'),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.red,
                    value: this.isChecked,
                      onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
                Text('Female'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
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
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: AstroColors.aboutUsCardBackgroud,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
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
    );
  }

  Widget matchMaking() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 40,
                        left: 40,
                        bottom: 10,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AstroColors.paymentButton,
                          textStyle: const TextStyle(color: Colors.white),
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                  color: AstroColors.paymentButton)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Boy Details",
                          style: TextStyle(
                              color: AstroColors.aboutUsCardBackgroud,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AstroColors.paymentButton, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Name',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: dateinput,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Dob',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Time',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Place of Birth',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 40,
                        left: 40,
                        bottom: 10,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AstroColors.paymentButton,
                          textStyle: const TextStyle(color: Colors.white),
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                  color: AstroColors.paymentButton)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Girl Details",
                          style: TextStyle(
                              color: AstroColors.aboutUsCardBackgroud,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AstroColors.paymentButton, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Name',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: dateinputGirls,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Dob',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          dateinputGirls.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Time',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: InkResponse(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AstroColors.paymentButton, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: 'Place of Birth',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
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
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: AstroColors.aboutUsCardBackgroud,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
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
    );
  }
}
