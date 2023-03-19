import 'package:flutter/material.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';

class PoojaBooking extends StatefulWidget {
  const PoojaBooking({Key? key}) : super(key: key);

  @override
  State<PoojaBooking> createState() => _PoojaBookingState();
}

class _PoojaBookingState extends State<PoojaBooking> {
  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            const ToolbarWithTitleAndBackbutton(title: 'Pooja Booking'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Upcoming',
                    ),
                    Tab(
                      text: 'Ongoing',
                    ),
                    Tab(
                      text: 'Past Bookings',
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
              children: [
                getUpcoming(),
                getOngoing(),
                getPastBookings(),
              ],
            ))
          ],
        ),
      )),
    );
  }

  Widget getUpcoming() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [],
        ));
  }

  Widget getOngoing() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [],
        ));
  }
 Widget getPastBookings() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [],
        ));
  }
 
}
