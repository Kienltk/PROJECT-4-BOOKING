import 'package:flutter/material.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/components/widgets/auto_size_text.dart';
import 'package:staynia/core/theme/custom_theme.dart';

class FacilityIcon extends StatelessWidget {
  final String svg;
  final String label;
  final bool isAutoSizeText;
  final double? size, iconSize;
  final Color? color;
  const FacilityIcon({
    super.key,
    required this.svg,
    required this.label,
    this.size = 24,
    this.color,
    this.isAutoSizeText = true,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: size,
          backgroundColor: Colors.grey.shade100,
          child: AppAssetIcon(svg, color:color ?? primaryColor700, size: iconSize),
        ),
        const SizedBox(height: 6),
        if (isAutoSizeText)
          AutoSizeText(
            text: label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          )
        else
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
      ],
    );
  }
}
