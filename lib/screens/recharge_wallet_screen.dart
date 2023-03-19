import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/recharge_wallet_models.dart';
import 'package:login/models/user_profile.dart';
import 'package:login/network/api_service.dart';
import 'package:login/screens/payment_details.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/utils/utility.dart';

class RechargeWalletScreen extends StatefulWidget {
  const RechargeWalletScreen({Key? key}) : super(key: key);
  @override
  State<RechargeWalletScreen> createState() => _RechargeWalletScreenState();
}

class _RechargeWalletScreenState extends State<RechargeWalletScreen> {
  int balance = 0;
  bool balanceFetched = false;
  ApiService apiService = ApiService();

  initialize() async {
    try {
      UserProfile profile = await apiService.getUserProfile();

      setState(() {
        balance = profile.amount ?? 0;
        balanceFetched = true;
      });
    } catch (e) {
      devtools.log('$e');
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        balanceText(),
        const SizedBox(
          height: 15,
        ),
        walletText(),
        balanceFetched ? rechargeListView() : Container(),
      ],
    );
  }

  Widget balanceText() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        color: Colors.grey.withOpacity(0.10),
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 15.0,
          bottom: 15.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.wallet_giftcard,
              color: Colors.pink,
              size: 40,
            ),
            const Text(
              'Total Balance',
              style: TextStyle(
                color: AstroColors.colorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/ic_coin.png',
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  '$balance',
                  style: const TextStyle(
                    color: AstroColors.colorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget walletText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Add to your Wallet',
          style: TextStyle(
            color: AstroColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget rechargeListView() {
    return FutureBuilder<RechargeWalletModel>(
      future: ApiService().getRechargeList(),
      builder:
          (BuildContext context, AsyncSnapshot<RechargeWalletModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            if (snapshot.error == AstroString.noInternet) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  CommonFunctions.instance.showSnackBar(
                    context,
                    AstroString.noInternet,
                  );
                },
              );
            } else {
              SchedulerBinding.instance.addPostFrameCallback(
                (_) {
                  CommonFunctions.instance
                      .showSnackBar(context, snapshot.error.toString());
                },
              );
            }
            return Container(
              height: 30.0,
            );
          } else {
            return _rechargeListData(snapshot.data!);
          }
        }
      },
    );
  }

  Future<void> refrsh() async {
    initialize();
    setState(() {});
  }

  Widget _rechargeListData(RechargeWalletModel rechargeList) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          refrsh();
        },
        child: GridView.builder(
          itemCount: rechargeList.data!.length,
          itemBuilder: (context, index) {
            return _rechargeList(rechargeList.data![index]);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2.2),
          ),
        ),
      ),
    );
  }

  Widget _rechargeList(DataRecharge dataRecharge) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => pushToPaymentScreen(dataRecharge),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(
              color: AstroColors.textColorGrey,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '₹ ' + dataRecharge.price.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/ic_coin.png',
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    dataRecharge.walletPrice.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  pushToPaymentScreen(DataRecharge dataRecharge) async {
    dynamic response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentDetailsScreen(
          amount: dataRecharge.price.toString(),
        ),
      ),
    );

    if (response != null && response['success'] != null) {
      initialize();
      Utility.showToast(
        msg: 'Payment Successful, your wallet credit has been updated.',
      );
    }
  }
}
