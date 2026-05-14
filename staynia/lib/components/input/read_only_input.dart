import 'package:flutter/material.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/app_extension.dart';

class ReadOnlyInput<T> extends StatefulWidget {
  final String label;
  final T? hintText;
  final String? svgPath;
  final bool isRequired, currency;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Color? color, labelColor;
  final Color svgColor;
  final EdgeInsets? padding;
  final TextInputType keyboardType;
  final VoidCallback onClick;

  const ReadOnlyInput({
    required this.label,
    this.hintText,
    this.color,
    this.currency = false,
    this.labelColor,
    required this.onClick,
    this.svgColor = Colors.grey,
    this.padding,
    this.isRequired = false,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.svgPath,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  State<ReadOnlyInput> createState() => _ReadOnlyInputState();
}

class _ReadOnlyInputState extends State<ReadOnlyInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final showToggleIcon = widget.isPassword;
    return Container(
      padding: widget.padding ?? const EdgeInsets.only(top: 10, bottom: 7),
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
            readOnly: true,
            controller:
                widget.controller ??
                TextEditingController(text: widget.hintText?.toString() ?? ''),
            keyboardType: widget.keyboardType,
            enableInteractiveSelection: false,
            onTap: widget.onClick,
            inputFormatters: widget.currency ? [CurrencyInputFormatter()] : [],
            obscureText: widget.isPassword ? _obscureText : false,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 18,
              ),
              hintText: widget.hintText?.toString(),
              hintStyle: TextStyle(
                color: widget.hintText != null ? Colors.black : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon:
                  showToggleIcon
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
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
                            onPressed: null,
                          )
                          : null),
            ),
            validator: (value) {
              final text =
                  widget.controller?.text ?? widget.hintText?.toString() ?? '';
              if (widget.isRequired && text.trim().isEmpty) {
                return 'This field is required';
              }
              return widget.validator?.call(text);
            },
          ),
        ],
      ),
    );
  }
}
