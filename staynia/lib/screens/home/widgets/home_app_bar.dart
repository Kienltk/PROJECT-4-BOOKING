import 'package:flutter/material.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/button/blur_button.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/model/user.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/router/router_path.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      centerTitle: false,
      leftButton: false,
      divider: true,
      toolBarHeight: kToolbarHeight + 4,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Constants.appName, style: context.headlineSmall),
          Container(
            margin: EdgeInsets.only(top: 3),
            width: context.sizeWidth * 0.65,
            child: Row(
              children: [
                AppAssetIcon(
                  AppSvg.location,
                  color: context.primaryColor,
                  size: 20,
                ),
                Box.s6,
                Flexible(
                  child: Text(
                    user.address ?? '-',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actionWidgets: [
        BlurButton(
          onClick: () => context.pushTo(RoutePaths.search),
          icon: AppSvg.search,
          borderColor: Colors.grey,
        ),
        Box.s8,
        Padding(
          padding: EdgeInsets.only(right: defaultPadding),
          child: BlurButton(
            onClick: () => context.pushTo(RoutePaths.notification),
            icon: AppSvg.notification,
            borderColor: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
