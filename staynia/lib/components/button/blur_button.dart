import 'package:flutter/material.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/container/blur_drop_filter_container.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/extension/app_extension.dart';

class BlurButton extends StatelessWidget {
  const BlurButton({
    super.key,
    required this.onClick,
    required this.icon,
    this.borderColor,
    this.blurColor,
    this.iconColor,
    this.size = 40,
  });
  final VoidCallback onClick;
  final String icon;
  final double size;
  final Color? iconColor;
  final Color? borderColor;
  final Color? blurColor;

  @override
  Widget build(BuildContext context) {
    return BlurDropFilterContainer(
      borderRadius: BorderRadius.circular(100),
      child: OnClickButton(
        onClick: onClick,
        child: Material(
          color:blurColor ?? const Color.fromARGB(132, 232, 229, 229).withOpacitySafe(0.35),
          child: Container(
            padding: const EdgeInsets.all(7),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: borderColor != null
                  ? Border.all(color: borderColor!)
                  : Border.all(color: Colors.transparent),
            ),
            child: AppAssetIcon(icon, size: 100, color: iconColor),
          ),
        ),
      ),
    );
  }
}
