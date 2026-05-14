import 'package:flutter/material.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/app_extension.dart';

class CustomInput<T> extends StatefulWidget {
  final String label;
  final T hintText;
  final String? svgPath;
  final bool isRequired, isReadOnly, currency;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Color? color, labelColor;
  final Color svgColor;
  final EdgeInsets padding;
  final TextInputType keyboardType;
  final VoidCallback? iconOnClick;

  const CustomInput({
    required this.label,
    required this.hintText,
    this.color,
    this.currency = false,
    this.labelColor,
    this.iconOnClick,
    this.svgColor = Colors.black,
    required this.padding,
    this.isRequired = false,
    this.isReadOnly = false,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.svgPath,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    super.key,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final showToggleIcon = widget.isPassword;

    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: TextStyle(
                fontSize: 12.3,
                color: widget.labelColor ?? Colors.black,
                fontWeight: FontWeight.w600,
              ),
              children: [
                if (widget.isRequired)
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
            readOnly: widget.isReadOnly,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.currency ? [CurrencyInputFormatter()] : [],
            obscureText: widget.isPassword ? _obscureText : false,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 18,
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: showToggleIcon
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: const Color.fromARGB(255, 30, 30, 30),
                      ),
                      onPressed: () {
                        setState(() => _obscureText = !_obscureText);
                      },
                    )
                  : (widget.svgPath != null
                        ? IconButton(
                            icon: AppAssetIcon(
                              widget.svgPath!,
                              color: widget.svgColor,
                              size: 27,
                            ),
                            onPressed: widget.iconOnClick,
                          )
                        : null),
            ),
            validator: (value) {
              if (widget.isRequired && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return widget.validator?.call(value);
            },
          ),
        ],
      ),
    );
  }
}
