import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/dimens.dart';
import 'package:login/screens/create_account_logins.dart';
import 'package:login/screens/openpainter.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController dateinput = TextEditingController();
  bool valuefirst = false;
  bool isChecked = false;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      SizedBox(
        width: 400,
        height: 400,
        child: CustomPaint(
          painter: OpenPainter(),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SvgPicture.asset(
            "assets/ic_back_button.svg",
            height: AstroDimens.backArrowHeight,
            width: AstroDimens.backArrowWidth,
          ),
        ),
      ),
      Positioned(
        bottom: 50,
        right: 120,
        child: CustomPaint(
          painter: OpenPainter(),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
            child: Text(
              'Create Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40, top: 32, right: 40, bottom: 8),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 8),
            child: TextField(
              controller: dateinput,
              decoration: const InputDecoration(
                hintText: "Date Of Birth",
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
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 8),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                  hintText: "Email Address",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
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
                const Text('Male'),
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
                const Text('Female'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
            child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AstroColors.appColor,
                    textStyle: const TextStyle(color: Colors.white),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side:
                            const BorderSide(color: AstroColors.appColor)),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CreateOTPScreen()));
                  },
                )),
          ),
        ],
      ),
    ])));
  }
}
