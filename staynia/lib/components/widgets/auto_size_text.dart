import 'package:flutter/material.dart';

class AutoSizeText extends StatelessWidget {
  const AutoSizeText({
    super.key,
    this.alignment = Alignment.center,
    this.textAlign = TextAlign.center,
    required this.text,
    this.style,
  });
  final Alignment alignment;
  final TextAlign textAlign;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: Text(
        text,
        textAlign: textAlign,
        style: style,
      ),
    );
  }
}
