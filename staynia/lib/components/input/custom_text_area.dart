import 'package:flutter/material.dart';
import 'package:staynia/core/constants/constants.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String label;
  final int minLines;
  final int maxLines, maxLength;
  final ValueChanged<String>? onChanged;
  final Color? labelColor;
  final bool isRequired;

  const CustomTextArea({
    super.key,
    required this.controller,
    this.hintText,
    this.minLines = 3,
    this.maxLength = 300,
    this.maxLines = 6,
    this.isRequired = false,
    this.onChanged,
    this.labelColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 12.3,
              color: labelColor ?? Colors.black,
              fontWeight: FontWeight.w600,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
        Box.height(6),
        TextFormField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText ?? 'Enter content...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.all(12),
            counterText: '',
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
