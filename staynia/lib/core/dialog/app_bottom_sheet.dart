import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/components/widgets/auto_size_text.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';

class AppBottomSheet {
  static final _completers = <BuildContext, Completer?>{};
  static BuildContext? _sheetContext;

  static Future<T?> showAppBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    Radius topRadius = const Radius.circular(25),
    Function? onClose,
    String? title,
    Color? color,
  }) async {
    final completer = Completer<T?>();
    _completers[context] = completer;

    await showCupertinoModalBottomSheet<T>(
      context: context,
      barrierColor: Colors.black.withOpacitySafe(0.4),
      expand: false,
      topRadius: topRadius,
      backgroundColor: color ?? Theme.of(context).scaffoldBackgroundColor,
      builder: (ctx) {
        _sheetContext = ctx;
        return AppBottomSheetWidget(title: title, child: child);
      },
    ).then((value) {
      if (!completer.isCompleted) completer.complete(value);
      _completers.remove(context);
      _sheetContext = null;
      if (onClose != null) onClose();
    });

    return completer.future;
  }

  static Future<void> close([dynamic result]) async {
    if (_sheetContext != null) {
      Navigator.of(_sheetContext!, rootNavigator: true).pop(result);
      _sheetContext = null;
    }
  }
}

class AppBottomSheetWidget extends StatelessWidget {
  final Widget child;
  final String? title;

  const AppBottomSheetWidget({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        curve: Curves.easeOut,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: defaultPadding,
                left: defaultPadding,
                top: defaultPadding,
                bottom: defaultPadding / 2,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  Expanded(
                    child: Center(
                      child: title != null
                          ? AutoSizeText(
                              text: title!,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  AppButton(
                    type: AppButtonType.close,
                    onClick: () => context.goBack(),
                  ),
                ],
              ),
            ),
            if (title != null) ...[Box.s6, const Divider()],
            Flexible(
              child: SingleChildScrollView(
                controller: ModalScrollController.of(context),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
