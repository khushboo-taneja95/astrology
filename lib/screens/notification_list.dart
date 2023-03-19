import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/models/notification_list.dart';
import 'package:login/network/api_service.dart';
import 'package:login/utils/commom_functions.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ToolbarWithTitleAndBackbutton(title: "Notifications"),
            notificationWidget(),
          ],
        ),
      ),
    );
  }

  Widget notificationWidget() {
    return FutureBuilder<NotificationsListModel>(
        future: ApiService().getNotificationsList(),
        builder: (BuildContext context,
            AsyncSnapshot<NotificationsListModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              if (snapshot.error == AstroString.noInternet) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
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
              return _notificationData(snapshot.data!);
            }
          }
        });
  }

  Future<void> refrsh() async {
    setState(() {});
  }

  Widget _notificationData(NotificationsListModel notificationsListModel) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refrsh,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView.separated(
            itemCount: notificationsListModel.data!.length,
            itemBuilder: (context, index) {
              return listNotificationData(notificationsListModel.data![index]);
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8),
                child: Divider(
                  thickness: 1,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget listNotificationData(NotificationListData notificationListData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                notificationListData.content.toString(),
              ))
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                DateFormat('dd MMMM, yyyy').format(
                  DateTime.parse(notificationListData.createdAt.toString())
                      .toLocal(),
                ),
                style: const TextStyle(
                    color: AstroColors.colorBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
