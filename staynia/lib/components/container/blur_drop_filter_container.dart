import 'dart:ui';
import 'package:flutter/material.dart';

class BlurDropFilterContainer extends StatelessWidget {
  const BlurDropFilterContainer({
    super.key,
    required this.child,
    this.x = 10,
    this.y = 10,
    this.borderRadius,
  });
  final Widget child;
  final double x, y;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: x, sigmaY: y),
        child: child,
      ),
    );
  }
}
