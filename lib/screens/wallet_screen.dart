import 'dart:developer' as devtools show log, inspect;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/constant/colors.dart';
import 'package:login/models/payment_history_model.dart';
import 'package:login/network/api_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  ApiService apiService = ApiService();
  bool loading = false;
  List<dynamic> allPaymentsList = [];
  int pageSize = 10;
  final PagingController<int, PaymentHistoryModel> _pagingController =
      PagingController(
    firstPageKey: 0,
  );

  showLoading() {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
  }

  hideLoading() {
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  Future<void> initialize(int pageKey) async {
    try {
      final List<PaymentHistoryModel> newItems =
          await apiService.fetchPaymentHistory(
        pageKey: pageKey,
      );

      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      devtools.log('$e');
      _pagingController.error = e;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      initialize(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AstroColors.colorWhite,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Wallet History',
          style: TextStyle(
            color: AstroColors.textColorGrey,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      body: walletHistory(),
    );
  }

  Widget walletHistory() {
    return PagedListView<int, PaymentHistoryModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<PaymentHistoryModel>(
        itemBuilder: (context, item, index) {
          return historyCard(item);
        },
      ),
    );
  }

  Card historyCard(PaymentHistoryModel paymentHistoryModel) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Order Id',
                    style: headingTextStyle(),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    paymentHistoryModel.orderId ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: valueTextStyle(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  'Total Amount',
                  style: headingTextStyle(),
                ),
                const SizedBox(height: 5),
                Text(
                  '₹${paymentHistoryModel.totalAmount}',
                  overflow: TextOverflow.ellipsis,
                  style: valueTextStyle(),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  'Ordered Date',
                  style: headingTextStyle(),
                ),
                const SizedBox(height: 5),
                Text(
                  paymentDateTime(paymentHistoryModel),
                  overflow: TextOverflow.ellipsis,
                  style: valueTextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle headingTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
  }

  TextStyle valueTextStyle() {
    return TextStyle(
      color: Colors.black.withOpacity(.5),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
  }

  String paymentDateTime(PaymentHistoryModel item) {
    if (item.updatedAt != null) {
      return DateFormat('d MMM HH:mm').format(
        DateTime.parse(item.updatedAt!).toLocal(),
      );
    }
    return '';
  }
}
