import 'package:flutter/material.dart';
import 'package:staynia/components/widgets/custom_widget.dart';
import 'package:staynia/core/constants/app_svg.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.radius,
    this.color,
  });
  final String src;
  final BoxFit fit;
  final double? height, width, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Image.asset(
        src,
        fit: fit,
        height: height,
        width: width,
        color: color,
        errorBuilder: (_, error, stackTrace) {
          return Center(
            child: buildAssetSvg(AppSvg.image, width: 20, color: color),
          );
        },
      ),
    );
  }
}
