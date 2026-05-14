import 'package:flutter/material.dart';
import 'package:staynia/core/theme/custom_theme.dart';

class BottomContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  const BottomContainer({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 14).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom + 18,
        top: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        boxShadow: [
          shadowTop(color: defaultShadowColor, offset: const Offset(0, 1)),
        ],
      ),
      child: child,
    );
  }
}
