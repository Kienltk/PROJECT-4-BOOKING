import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:staynia/components/bottom_navigation_bar/entry_bottom_navigation_bar.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/admin/dashboard/dashboard_screen.dart';
import 'package:staynia/screens/admin/room/create_room_screen.dart';
import 'package:staynia/screens/profile/profile_screen.dart';

class EntryPointAdmin extends StatefulWidget {
  const EntryPointAdmin({super.key});

  @override
  State<EntryPointAdmin> createState() => _EntryPointAdminState();
}

class _EntryPointAdminState extends State<EntryPointAdmin>
    with AutomaticKeepAliveClientMixin {
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
          DashboardScreen(),
          CreateRoomScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: EntryBottomNavigationBar(
        items: [
          {'icon': AppSvg.home, 'label': "Manager", 'size': 26.0},
          {'icon': AppSvg.calendar, 'label': "Manager", 'size': 26.0},
          {'icon': AppSvg.profile, 'label': "Profile", 'size': 26.0},
        ],
        index: _pageIndex,
        onClick: (index) {
          if (index == 1) {
            showOption();
            return;
          }
          setState(() {
            _pageIndex = index;
            _controller.jumpToPage(_pageIndex);
          });
        },
      ),
    );
  }

  void showOption() async {
    await showModalActionSheet<int>(
      context: context,
      title: Constants.appName,
      cancelLabel: 'Close',
      message: 'Select Option',
      actions: [
        SheetAction(key: 1, label: 'Rooms'),
        SheetAction(key: 2, label: 'Categories'),
        SheetAction(key: 3, label: 'Commons'),
        SheetAction(key: 4, label: 'Tags'),
        SheetAction(key: 5, label: 'Booking Manager'),
      ],
      onPopInvokedWithResult: (_, result) async {
        if (result == null) return;
        Future.microtask(() {
          switch (result) {
            case 1:
              context.pushTo(RoutePaths.adminListRoomScreen);
            case 2:
              context.pushTo(RoutePaths.adminCategory);
            case 3:
              context.pushTo(RoutePaths.adminCommon);
            case 4:
              context.pushTo(RoutePaths.adminTags);
            case 5:
              context.pushTo(RoutePaths.bookingManager);
          }
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
