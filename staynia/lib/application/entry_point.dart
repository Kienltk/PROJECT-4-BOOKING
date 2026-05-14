import 'package:flutter/material.dart';
import 'package:staynia/components/bottom_navigation_bar/entry_bottom_navigation_bar.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/screens/bookings/booking_screen.dart';
import 'package:staynia/screens/home/home_screen.dart';
import 'package:staynia/screens/profile/profile_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>  with AutomaticKeepAliveClientMixin{
  final PageController _controller = PageController(initialPage: 0);
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          BookingScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: EntryBottomNavigationBar(
        items: [
          {'icon': AppSvg.home, 'label': "Home", 'size': 26.0},
          {'icon': AppSvg.calendar, 'label': "Bookings", 'size': 26.0},
          {'icon': AppSvg.profile, 'label': "Profile", 'size': 26.0},
        ],
        index: _pageIndex,
        onClick: (index) => setState(() {
          _pageIndex = index;
          _controller.jumpToPage(_pageIndex);
        }),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;

}
