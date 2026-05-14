import 'package:flutter/material.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/context_extension.dart';

class TextContentSection extends StatelessWidget {
  final String title;
  final String? subTitle;
  final EdgeInsets? padding;
  final Widget? subWidget;
  final double? width;
  const TextContentSection({
    super.key,
    required this.title,
    this.subTitle,
    this.padding,
    this.subWidget,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 15, bottom: 10),
      child: SizedBox(
        width: width ?? context.sizeWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (subTitle != null) ...[
              Box.s4,
              Text(
                subTitle!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            if (subWidget != null) subWidget!,
          ],
        ),
      ),
    );
  }
}
