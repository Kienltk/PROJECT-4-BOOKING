import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:staynia/core/constants/app_svg.dart';

Widget buildAssetSvg(
  String src, {
  Color? color,
  double height = 22,
  double width = 22,
  BoxFit fit = BoxFit.contain,
  BorderRadiusGeometry? border,
}) {
  return ClipRRect(
    borderRadius: border ?? BorderRadius.zero,
    child: SvgPicture.asset(
      src,
      fit: fit,
      height: height,
      width: width,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      errorBuilder: (_, error, stackTrace) {
        return Center(child: buildAssetSvg(AppSvg.image, height: 20));
      },
    ),
  );
}

Widget buildAssetImage(
  String path, {
  double? radius,
  double? height,
  double? width,
  Color? color,
  BoxFit fit = BoxFit.contain,
}) => ClipRRect(
  borderRadius: BorderRadius.circular(radius ?? 0),
  child: Image.asset(
    path,
    fit: fit,
    height: height,
    width: width,
    color: color,
    errorBuilder: (_, error, stackTrace) {
      return Center(
        child: buildAssetSvg(AppSvg.image, height: 20, color: color),
      );
    },
  ),
);

