import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:staynia/core/constants/app_svg.dart';

class AppAssetIcon extends StatelessWidget {
  const AppAssetIcon(
    this.icon, {
    super.key,
    this.fit = BoxFit.cover,
    this.size,
    this.color,
  });
  final String icon;
  final BoxFit fit;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      fit: fit,
      height: size,
      width: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      errorBuilder: (_, error, stackTrace) {
        return Center(child: buildAssetSvg(AppSvg.image, size: 20));
      },
    );
  }

  SvgPicture buildAssetSvg(
    String src, {
    Color? color,
    double? size,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      src,
      fit: fit,
      height: size,
      width: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      errorBuilder: (_, error, stackTrace) {
        return Center(child: buildAssetSvg(AppSvg.image, size: size));
      },
    );
  }
}
