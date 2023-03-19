import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/constant/colors.dart';
import 'package:login/widgets/toolbar_with_title.dart';

class PaymentFailed extends StatefulWidget {
  const PaymentFailed({Key? key}) : super(key: key);

  @override
  State<PaymentFailed> createState() => _PaymentFailedState();
}

class _PaymentFailedState extends State<PaymentFailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ToolbarWithTitle(title: "Payment Failed"),
            paymentFaildView(),
          ],
        ),
      ),
    );
  }

  Widget paymentFaildView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AstroColors.paymentFailedColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              height: 10,
              decoration: const BoxDecoration(
                color: AstroColors.colorRed,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
            ),
            const SizedBox(height: 70),
            SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset("assets/ic_payment_faild.svg")),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Please try a different payment method",
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Payment Failed",
              style: TextStyle(
                  color: AstroColors.colorBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
