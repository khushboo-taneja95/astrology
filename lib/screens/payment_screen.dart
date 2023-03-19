import 'package:flutter/material.dart';
import 'package:login/constant/colors.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ToolbarWithTitleAndBackbutton(title: "Payment Method"),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: InkResponse(
                      onTap: () {},
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.radio_button_checked_rounded,
                                color: AstroColors.appColor,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2.0, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              hintText: 'UPI',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 0.0),
                    child: InkResponse(
                      onTap: () {},
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.radio_button_checked_rounded,
                                color: AstroColors.appColor,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2.0, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              hintText: 'Credit / Debit Card',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: InkResponse(
                      onTap: () {},
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.radio_button_checked_rounded,
                                color: AstroColors.appColor,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2.0, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              hintText: 'Netbanking',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Divider(
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AstroColors.paymentButton,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Proceed To Pay",
                                style: TextStyle(
                                    color: AstroColors.aboutUsCardBackgroud,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
