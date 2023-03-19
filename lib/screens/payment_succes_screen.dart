import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/widgets/toolbar_with_title.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ToolbarWithTitle(title: "Payment Successful"),
            paymentSuccessView(),
          ],
        ),
      ),
    );
  }

  Widget paymentSuccessView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AstroColors.paymentSuccessColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              height: 10,
              decoration: const BoxDecoration(
                color: AstroColors.colorGreen,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
            ),
            const SizedBox(height: 70),
            SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset("assets/ic_payment_success.svg")),
            const SizedBox(
              height: 19,
            ),
            const Text(
              "Payment Successful",
              style: TextStyle(
                  color: AstroColors.colorBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '₹ 100',
              style:  TextStyle(
                  color: AstroColors.colorBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
