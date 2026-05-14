import 'package:flutter/material.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/theme_extension.dart';

class BuildTitle extends StatelessWidget {
  const BuildTitle({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding,
    this.subColor,
    this.subTitle,
  });
  final String title;
  final String? subTitle;
  final Color color;
  final Color? subColor;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          if (subTitle != null) ...[
            Box.height(2),
            Text(
              title,
              style: context.textTheme.bodySmall!.copyWith(color: subColor),
            ),
          ],
        ],
      ),
    );
  }
}
