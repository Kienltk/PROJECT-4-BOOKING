import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/env.dart';
import 'package:staynia/data/entity/model/document.dart';

class AppCacheImage extends StatelessWidget {
  final BoxFit fit;
  final double radius, iconSize;
  final String onError, onLoad;
  final Color? color;
  final String? image;
  final List<Document>? images;

  const AppCacheImage({
    super.key,
    this.image,
    this.images,
    this.color,
    this.radius = 8,
    this.iconSize = 30,
    this.onError = AppSvg.image,
    this.onLoad = AppSvg.image,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    String? finalUrl;

    if (image != null && image!.isNotEmpty) {
      finalUrl = '${ENV.baseUrl}/$image';
    } else if (images != null && images!.isNotEmpty) {
      final primary = images!.firstWhere(
        (doc) => doc.isPrimary == true,
        orElse: () => images!.first,
      );
      if (primary.imageUrl != null && primary.imageUrl!.isNotEmpty) {
        finalUrl = '${ENV.baseUrl}/${primary.imageUrl}';
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: finalUrl != null
          ? CachedNetworkImage(
              fit: fit,
              imageUrl: finalUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider, fit: fit),
                ),
              ),
              placeholder: (context, text) => _placeholder(),
              errorWidget: (context, url, error) => _errorWidget(),
            )
          : _errorWidget(),
    );
  }

  Widget _placeholder() => Container(
    color: Colors.transparent,
    child: Center(
      child: AppAssetIcon(onLoad, color: color, fit: fit, size: iconSize),
    ),
  );

  Widget _errorWidget() => Container(
    color: Colors.transparent,
    child: Center(
      child: AppAssetIcon(onError, color: color, fit: fit, size: iconSize),
    ),
  );
}
