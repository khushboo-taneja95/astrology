import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/order_create_model.dart';
import 'package:login/network/api_service.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/utils/utility.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:login/models/payment_gateway.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final String amount;
  const PaymentDetailsScreen({Key? key, required this.amount})
      : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  OrderCreate? orderDetails;
  final Razorpay _razorpay = Razorpay();
  ApiService apiService = ApiService();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _markOrderAsCompleted);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentError);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const ToolbarWithTitleAndBackbutton(title: 'Payment Information'),
          FutureBuilder<OrderCreate>(
              future: ApiService().getOrderCreate(widget.amount),
              builder:
                  (BuildContext context, AsyncSnapshot<OrderCreate> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    if (snapshot.error == AstroString.noInternet) {
                      WidgetsBinding.instance!
                          .addPostFrameCallback((timeStamp) {
                        CommonFunctions.instance
                            .showSnackBar(context, AstroString.noInternet);
                      });
                    } else {
                      SchedulerBinding.instance!.addPostFrameCallback((_) {
                        CommonFunctions.instance
                            .showSnackBar(context, snapshot.error.toString());
                      });
                    }
                    return Container(
                      height: 30.0,
                    );
                  } else {
                    return paymentDetails(snapshot.data!);
                  }
                }
              }),
        ],
      )),
    );
  }

  Widget paymentDetails(OrderCreate orderCreateModel) {
    orderDetails = orderCreateModel;
    return Expanded(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Total Charges',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Column(
              children: [
                reviewOrderTotalChargesItem(orderCreateModel),
                const Divider(),
                const SizedBox(height: 10),
                payButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewOrderTotalChargesItem(OrderCreate orderCreateModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: SizedBox(
              height: 32.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                  ),
                  Text(
                    orderCreateModel.data!.amountWithoutTax.toString(),
                  ),
                ],
              )),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: SizedBox(
            height: 32.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "GST",
                ),
                Text(
                  orderCreateModel.data!.gst.toString(),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: SizedBox(
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Payable Amount",
                ),
                Text(
                  orderCreateModel.data!.amount.toString(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox payButton() {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AstroColors.appColor,
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
              color: AstroColors.appColor,
            ),
          ),
        ),
        child: const Text(
          'Pay',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: chargeTheUser,
      ),
    );
  }

  Widget astrologyList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext ctx, int index) {
          return getWallet();
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.4),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
      ),
    );
  }

  Widget getWallet() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: Text(
            'Debit Card',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Image.network(
          'https://bfsi.eletsonline.com/wp-content/uploads/2019/12/Banks-issued-63-percent-higher-debit-cards-in-2019-than-in-2015-RBI-Data.jpg',
          width: 150,
          height: 90,
        ),
      ]),
    );
  }

  _markOrderAsCompleted(PaymentSuccessResponse response) async {
    try {
      PaymentGatewayModel data = await apiService.getPaymentGateway(
        response.orderId!,
        response.paymentId!,
      );

      Navigator.pop(context, {
        'success': data.success,
      });
    } catch (e) {
      log('$e');
      Utility.showToast(
        msg: 'Error while purchasing your desired amount',
      );
    }
  }

  chargeTheUser() async {
    if (orderDetails != null) {
      int amount = (orderDetails!.data!.amount!).toInt();
      var options = {
        // TODO change the razor pay from test mode to live once testing is completed.
        'key': 'rzp_test_7gPgufanwrBBT9',
        'amount': amount * 100,
        'name': 'curodoc',
        'order_id': orderDetails!.data!.orderId,
        'description': 'Wallet Recharge',
      };

      _razorpay.open(options);
    } else {
      Utility.showToast(
        msg: 'Error while purchasing your desired amount',
      );
    }
  }

  _paymentError(PaymentFailureResponse response) {
    if (response.code != Razorpay.PAYMENT_CANCELLED) {
      log('$response');
      Utility.showToast(
        msg: 'Error while purchasing your desired amount',
      );
    }
  }
}
