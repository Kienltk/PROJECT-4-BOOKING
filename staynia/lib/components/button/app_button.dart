import 'package:flutter/material.dart';
import 'package:staynia/components/animation/loading_spinner.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/components/widgets/auto_size_text.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/core/theme/custom_theme.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';

class AppButton extends StatelessWidget {
  final AppButtonType type;
  final VoidCallback onClick;
  final Color? color;
  final Color contentColor;
  final String? svgPath, content;
  final bool loading, decor, disable;
  final double? height, width;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.type,
    required this.onClick,
    this.loading = false,
    this.decor = false,
    this.disable = false,
    this.borderRadius = 30,
    this.height,
    this.width,
    this.color,
    this.contentColor = Colors.white,
    this.svgPath,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    if (type == AppButtonType.close) {
      return OnClickButton(
        onClick: onClick,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 191, 191, 191),
            shape: BoxShape.circle,
          ),
          child: AppAssetIcon(AppSvg.cancel, color: contentColor, size: 16),
        ),
      );
    }
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration:
          decor
              ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor800, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.3, 1.0],
                ),
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: primaryColor800, width: 1),
              )
              : null,
      child: ElevatedButton(
        onPressed: (loading || disable) ? () {} : onClick,
        style: _getButtonStyle(
          type,
          context,
          borderRadius: borderRadius,
          loading: loading,
          color: color,
          disable: disable,
        ),
        child: _buildContent(
          type,
          content,
          svgPath: svgPath,
          contentColor: contentColor,
          context: context,
        ),
      ),
    );
  }

  Widget _buildContent(
    AppButtonType type,
    String? content, {
    String? svgPath,
    required Color contentColor,
    required BuildContext context,
  }) {
    switch (type) {
      case AppButtonType.primary:
        return Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: loading ? 0.5 : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      text: content ?? "Confirm",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: contentColor,
                      ),
                    ),
                  ),
                  if (svgPath != null) ...[
                    Box.width(8),
                    AppAssetIcon(svgPath, color: contentColor),
                  ],
                ],
              ),
            ),
            if (loading)
              const SizedBox(width: 20, height: 20, child: LoadingSpinner()),
          ],
        );
      case AppButtonType.secondary:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content ?? "Confirm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: contentColor,
              ),
            ),
            if (svgPath != null) ...[
              Box.width(8),
              AppAssetIcon(svgPath, color: contentColor),
            ],
          ],
        );
      case AppButtonType.close:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content ?? "Confirm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: contentColor,
              ),
            ),
            if (svgPath != null) ...[
              Box.width(8),
              AppAssetIcon(svgPath, color: contentColor),
            ],
          ],
        );
      case AppButtonType.danger:
        return Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: loading ? 0.5 : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    content ?? "Confirm",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  if (svgPath != null) ...[
                    Box.width(8),
                    AppAssetIcon(svgPath, color: contentColor),
                  ],
                ],
              ),
            ),
            if (loading)
              const SizedBox(width: 20, height: 20, child: LoadingSpinner()),
          ],
        );
      case AppButtonType.text:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AutoSizeText(
                text: content ?? "Confirm",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: contentColor,
                ),
              ),
            ),
            if (svgPath != null) ...[
              Box.width(8),
              AppAssetIcon(svgPath, color: contentColor),
            ],
          ],
        );
      case AppButtonType.decor:
        return Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: loading ? 0.5 : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      text: content ?? "Confirm",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: contentColor,
                      ),
                    ),
                  ),
                  if (svgPath != null) ...[
                    Box.width(8),
                    AppAssetIcon(svgPath, color: contentColor),
                  ],
                ],
              ),
            ),
            if (loading)
              const SizedBox(width: 20, height: 20, child: LoadingSpinner()),
          ],
        );
      case AppButtonType.fundraising:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAssetIcon(svgPath!, color: contentColor, size: 27),
            Box.width(10),
            Expanded(
              child: AutoSizeText(
                text: content ?? "Confirm",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: contentColor,
                ),
              ),
            ),
          ],
        );
    }
  }

  _getButtonStyle(
    AppButtonType type,
    BuildContext context, {
    Color? color,
    required bool loading,
    required bool disable,
    required double borderRadius,
  }) {
    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: _getButtonColor(context),
          padding: const EdgeInsets.symmetric(vertical: 15),
        );
      case AppButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: color ?? context.primaryColor,
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );
      case AppButtonType.danger:
        return ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: const BorderSide(color: Colors.red),
          ),
          backgroundColor: _getButtonColor(context),
          foregroundColor: Colors.red,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 14),
        );
      case AppButtonType.text:
        return TextButton.styleFrom(
          backgroundColor: _getButtonColor(context),
          foregroundColor: context.primaryColor,
        );
      case AppButtonType.decor:
        return ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _getButtonColor(context),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        );
      case AppButtonType.fundraising:
        return TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _getButtonColor(context),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        );
      case AppButtonType.close:
        return TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _getButtonColor(context),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        );
    }
  }

  Color _getButtonColor(BuildContext context) {
    final baseColor = color ?? primaryColor600;
    return decor
        ? Colors.transparent
        : disable
        ? baseColor.withOpacitySafe(0.4)
        : baseColor;
  }
}
