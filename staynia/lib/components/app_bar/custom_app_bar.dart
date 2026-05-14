import 'package:flutter/material.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/extension/theme_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title, subTitle;
  final bool leftButton, rightButton, shadow, centerTitle, divider;
  final VoidCallback? leftOnClick, rightOnClick;
  final Color color, rightSvgColor, buttonColor;
  final Color? titleColor;
  final Widget? titleWidget, leadingWidget;
  final double toolBarHeight;
  final double? bottomHeight;
  final PreferredSize? bottom;
  final List<Widget>? actionWidgets;

  const CustomAppBar({
    super.key,
    this.title,
    this.leftButton = true,
    this.centerTitle = true,
    this.rightButton = false,
    this.shadow = false,
    this.titleColor,
    this.leftOnClick,
    this.leadingWidget,
    this.bottomHeight,
    this.bottom,
    this.actionWidgets,
    this.rightOnClick,
    this.toolBarHeight = kToolbarHeight,
    this.titleWidget,
    this.subTitle,
    this.divider = false,
    this.rightSvgColor = Colors.black,
    this.color = Colors.white,
    this.buttonColor = Colors.black,
  });

  @override
  Size get preferredSize => bottom != null
      ? Size.fromHeight(toolBarHeight - 5 + (bottomHeight ?? 0))
      : Size.fromHeight(toolBarHeight);

  @override
  Widget build(BuildContext context) {
    final isDialog =
        (ModalRoute.of(context) as PageRoute?)?.fullscreenDialog ?? false;
    return AppBar(
      bottom:
          bottom ??
          (divider
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(color: Color.fromARGB(255, 217, 217, 217)),
                )
              : null),
      centerTitle: centerTitle,
      titleSpacing: 5,
      shadowColor: shadow ? Colors.grey[100] : Colors.transparent,
      backgroundColor: color,
      leadingWidth: centerTitle ? 50 : 0,
      title:
          titleWidget ??
          Column(
            children: [
              Text(
                title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.appBarTheme.titleTextStyle!.copyWith(
                  color: titleColor,
                ),
              ),
              if (subTitle != null) ...[
                Box.height(2),
                Text(
                  subTitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: titleColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ],
          ),
      leading:
          leadingWidget ??
          (leftButton
              ? Container(
                  height: 10,
                  padding: EdgeInsets.all(isDialog ? 16 : 8),
                  child: OnClickButton(
                    onClick: leftOnClick ?? () => context.goBack(),
                    child: AppAssetIcon(
                      isDialog ? AppSvg.cancel : AppSvg.arrowLeft,
                      size: 20,
                    ),
                  ),
                )
              : const SizedBox.shrink()),
      actions: actionWidgets ?? [const SizedBox.shrink()],
    );
  }
}
