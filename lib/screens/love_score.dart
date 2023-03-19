import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/constant/colors.dart';
import 'package:login/screens/match_making_after_form_details.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class LoveScore extends StatefulWidget {
  const LoveScore({Key? key}) : super(key: key);

  @override
  State<LoveScore> createState() => _LoveScoreState();
}

class _LoveScoreState extends State<LoveScore> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinputGirls = TextEditingController();
  TextEditingController timeInputBoys = TextEditingController();
  TextEditingController timeInputGirls = TextEditingController();

  bool valuefirst = false;
  bool isChecked = false;

  @override
  void initState() {
    dateinput.text = "";
    timeInputBoys.text = "";
    timeInputGirls.text = "";
    dateinputGirls.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ToolbarWithTitleAndBackbutton(title: 'Love Score'),
          Expanded(child: loveScore()),
        ],
      ),
    ));
  }

  Widget loveScore() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.male_sharp,
                        color: Colors.blue,
                        size: 22,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Male",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: AstroColors.paymentButton, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 5.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AstroColors.paymentButton, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: '  Name',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: dateinput,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: AstroColors.paymentButton, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 5.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AstroColors.paymentButton, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: '  Dob',
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
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: timeInputBoys,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: AstroColors.paymentButton, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 5.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AstroColors.paymentButton, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: '  Time',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
      
                          if (pickedTime != null) {
                            print(pickedTime.format(context));
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            print(parsedTime);
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime);
      
                            setState(() {
                              timeInputBoys.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: AstroColors.paymentButton, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 5.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AstroColors.paymentButton, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: '  Place Of Birth',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 140,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.female_sharp,
                        color: Colors.pink,
                        size: 22,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Female",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: AstroColors.paymentButton, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 5.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AstroColors.paymentButton, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: '  Name',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: dateinputGirls,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(
                              color: AstroColors.paymentButton, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 5.0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AstroColors.paymentButton, width: 2.0),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: '  Dob',
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: timeInputGirls,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: AstroColors.paymentButton, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 5.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AstroColors.paymentButton, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: '  Time',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
      
                          if (pickedTime != null) {
                            print(pickedTime.format(context));
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            print(parsedTime);
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime);
      
                            setState(() {
                              timeInputGirls.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkResponse(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                color: AstroColors.paymentButton, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 5.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AstroColors.paymentButton, width: 2.0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          hintText: '  Place Of Birth',
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
                        height: 70,
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const MatchMakingFormDetails()));
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  color: AstroColors.aboutUsCardBackgroud,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }
}
