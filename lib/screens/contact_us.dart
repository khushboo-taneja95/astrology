import 'package:flutter/material.dart';
import 'package:login/constant/colors.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinputGirls = TextEditingController();
  bool valuefirst = false;
  bool isChecked = false;

  @override
  void initState() {
    dateinput.text = "";
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
          const ToolbarWithTitleAndBackbutton(title: 'Contact Us'),
          Expanded(child: contactUs()),
        ],
      ),
    ));
  }

  Widget contactUs() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
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
                        hintText: '  Mobile Number',
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
                        hintText: '  Email',
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
                      maxLines: 4,
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
                        hintText: '  Message',
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
                          onPressed: () {},
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
    );
  }
}
