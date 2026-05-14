import 'package:flutter/material.dart';
import 'package:staynia/core/constants/constants.dart';

class ContainerBody extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const ContainerBody({
    super.key,
    required this.child,
    this.height,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding:
          padding ??
          const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
      margin: margin,
      child: child,
    );
  }
}
