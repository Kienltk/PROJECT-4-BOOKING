import 'package:flutter/material.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/theme/custom_theme.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color color;

  const MyContainer({
    super.key,
    required this.child,
    this.borderRadius = defaultBorderRadious,
    this.height,
    this.color = Colors.white,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [bShadow()],
      ),
      padding: padding ?? const EdgeInsets.all(8.0),
      margin: margin ?? const EdgeInsets.all(0.0),
      child: child,
    );
  }
}
