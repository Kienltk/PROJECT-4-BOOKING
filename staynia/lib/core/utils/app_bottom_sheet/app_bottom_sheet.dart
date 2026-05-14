import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/extension/theme_extension.dart';

class AppBottomSheet {
  static Future<T?> showAppBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isCupertino = true,
    bool closeButton = true,
    Color? color,
  }) {
    return showCupertinoModalBottomSheet<T>(
      context: context,
      barrierColor: Colors.black.withOpacitySafe(0.4),
      expand: false,
      enableDrag: closeButton,
      topRadius: Radius.circular(20),
      backgroundColor: color ?? context.scaffoldBackgroundColor,
      builder: (context) => AppBottomSheetWidget(
        color: color,
        closeButton: closeButton,
        child: child,
      ),
    );
  }
}

class AppBottomSheetWidget extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool closeButton;
  const AppBottomSheetWidget({
    super.key,
    required this.child,
    this.color,
    required this.closeButton,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (closeButton) ...[
            Padding(
              padding: const EdgeInsets.only(
                right: defaultPadding,
                bottom: defaultPadding,
                top: defaultPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    type: AppButtonType.close,
                    onClick: () => context.goBack(),
                  ),
                ],
              ),
            ),
            Divider(color: color),
          ],
          Flexible(
            child: SingleChildScrollView(
              padding: context.safeBottom,
              controller: ModalScrollController.of(context),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
