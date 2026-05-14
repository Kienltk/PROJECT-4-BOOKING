import 'package:flutter/material.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/theme_extension.dart';

class BuildSvgWithText extends StatelessWidget {
  final String svgPath;
  final String? message;
  final VoidCallback? onClick;
  final Color? color;
  final double size;

  const BuildSvgWithText({
    super.key,
    this.message,
    this.onClick,
    this.size = 45,
    this.color,
    this.svgPath = AppSvg.notification,
  });

  @override
  Widget build(BuildContext context) {
    return OnClickButton(
      onClick: onClick ?? () {},
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssetIcon(
              svgPath,
              color: color ?? context.primaryColor,
              size: size,
            ),
            const SizedBox(height: 10),
            Text(
              message ?? 'Không có dữ liệu!',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withOpacitySafe(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
