import 'package:flutter/material.dart';
import 'package:staynia/application/entry_point.dart';
import 'package:staynia/application/entry_point_admin.dart';
import 'package:staynia/components/widgets/full_screen_content.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/log.dart';
import 'package:staynia/data/entity/model/category.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/providers/manager/category/category_screen.dart';
import 'package:staynia/providers/manager/category/common_screen.dart';
import 'package:staynia/providers/manager/category/tag_screen.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/admin/booking/booking_manager_screen.dart';
import 'package:staynia/screens/admin/room/create_room_screen.dart';
import 'package:staynia/screens/admin/room/list_room_screen.dart';
import 'package:staynia/screens/admin/room/update_room_screen.dart';
import 'package:staynia/screens/auth/login/login_screen.dart';
import 'package:staynia/screens/auth/register/register_screen.dart';
import 'package:staynia/screens/booking/booking_detail_screen.dart';
import 'package:staynia/screens/booking/checkout_screen.dart';
import 'package:staynia/screens/booking/request_booking_screen.dart';
import 'package:staynia/screens/detail_room/detail_room_screen.dart';
import 'package:staynia/screens/notification/notification_screen.dart';
import 'package:staynia/screens/search/search_screen.dart';

class ApplicationRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    Log.d(settings);
    switch (settings.name) {
      case RoutePaths.entryPoint:
        return material((_) => const EntryPoint(), settings);
      case RoutePaths.entryPointAdmin:
        return material((_) => const EntryPointAdmin(), settings);
      case RoutePaths.login:
        return material((_) => const LoginScreen(), settings);
      case RoutePaths.register:
        return material((_) => const RegisterScreen(), settings);
      case RoutePaths.notification:
        return material((_) => const NotificationScreen(), settings);
      case RoutePaths.createRoom:
        return material((_) => const CreateRoomScreen(), settings);
      case RoutePaths.adminCategory:
        return material((_) => const CategoryScreen(), settings);
      case RoutePaths.adminCommon:
        return material((_) => const CommonScreen(), settings);
      case RoutePaths.adminListRoomScreen:
        return material((_) => const ListRoomScreen(), settings);
      case RoutePaths.adminTags:
        return material((_) => const TagScreen(), settings);
      case RoutePaths.bookingManager:
        return material((_) => const BookingManagerScreen(), settings);
      case RoutePaths.bookingDetail:
        return material(
          (_) => BookingDetailScreen(bookingId: settings.arguments as int),
          settings,
        );
      case RoutePaths.detailRoom:
        return material(
          (_) => DetailRoomScreen(room: settings.arguments as Room),
          settings,
        );
      case RoutePaths.updateRoom:
        return material(
          (_) => UpdateRoomScreen(room: settings.arguments as Room),
          settings,
        );
      case RoutePaths.requestToBook:
        return material(
          (_) => RequestBookingScreen(room: settings.arguments as Room),
          settings,
        );
      case RoutePaths.checkout:
        return material(
          (_) => CheckoutScreen(room: settings.arguments as Room),
          settings,
        );
      case RoutePaths.search:
        return material(
          (_) => SearchScreen(categrory: settings.arguments as Category?),
          settings,
        );
      case RoutePaths.splash:
        return material(
          (_) => FullScreenContent(
            title: Constants.appName,
            subTitle: "Đang cập nhật dữ liệu!",
            isOpenApp: true,
          ),
          settings,
          dialog: true,
        );
      default:
        return material(
          (_) => FullScreenContent(
            title: Constants.appName,
            subTitle: "Lỗi",
            button: SizedBox.shrink(),
          ),
          settings,
        );
    }
  }
}

MaterialPageRoute material(
  Widget Function(BuildContext context) child,
  RouteSettings settings, {
  bool dialog = false,
}) {
  return MaterialPageRoute(
    builder: child,
    settings: settings,
    fullscreenDialog: dialog,
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
