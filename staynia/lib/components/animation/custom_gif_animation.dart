import 'package:flutter/material.dart';
import 'package:staynia/components/media/app_asset_image.dart';
import 'package:staynia/core/constants/app_gif.dart';

class CustomGifAnimation extends StatelessWidget {
  final double? size;
  final String assetGif;
  final Color? color;
  const CustomGifAnimation({
    super.key,
    this.assetGif = AppGifs.loading,
    this.size = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 50,
      child: Transform.scale(
        scale: size,
        child: AppAssetImage(assetGif, color: color),
      ),
    );
  }
}
