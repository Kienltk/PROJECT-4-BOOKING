import 'package:flutter/material.dart';
import 'package:staynia/extension/theme_extension.dart';

class TitleColumnContent extends StatelessWidget {
  final String? title, text;
  final Color? color;
  final double?fontSize;

  const TitleColumnContent({
    super.key,
    required this.title,
    this.text,
    this.fontSize = 40,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title!,
          style: context.textTheme.displayMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize:fontSize ,
            color: color ?? Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        if (text != null) ...[
          Text(text!, style: TextStyle(color: color ?? Colors.black)),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}
