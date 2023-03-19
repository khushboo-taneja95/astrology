import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/constant/colors.dart';
import 'package:login/screens/kundali_after_form_details.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class KundaliScreen extends StatefulWidget {
  const KundaliScreen({Key? key}) : super(key: key);

  @override
  State<KundaliScreen> createState() => _KundaliScreenState();
}

class _KundaliScreenState extends State<KundaliScreen> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  TextEditingController dateinputGirls = TextEditingController();
  bool valuefirst = false;
  bool isChecked = false;

  @override
  void initState() {
    dateinput.text = "";
    timeInput.text = "";
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
          const ToolbarWithTitleAndBackbutton(title: 'Kundali'),
          Expanded(child: getKundali()),
        ],
      ),
    ));
  }

  Widget getKundali() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.red,
                    value: valuefirst,
                    onChanged: (bool? value) {
                      setState(() {
                        valuefirst = value!;
                      });
                    },
                  ),
                  const Text('Male'),
                  const SizedBox(
                    width: 40,
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.red,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
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
                          suffixIcon: const Icon(Icons.date_range_outlined,
                              color: Colors.black),
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
                          hintText: '  City Of Birth',
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
                        controller: timeInput,
                        decoration: InputDecoration(
                          suffixIcon:
                              const Icon(Icons.lock_clock, color: Colors.black),
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
                          hintText: '  Time Of Birth',
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
                              timeInput.text = formattedTime;
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
                                      const KundaliFormDetails()));
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
