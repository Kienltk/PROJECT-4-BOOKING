import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/components/container/blur_drop_filter_container.dart';
import 'package:staynia/components/media/app_cache_image.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/data/entity/model/document.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/theme_extension.dart';

class AppDialog {
  static BuildContext? _dialog;

  static showChildModalWidget(
    BuildContext context, {
    bool barrierDismissible = true,
    bool closeButton = true,
    required Widget child,
    EdgeInsets? padding,
    double borderRadius = 15,
    double? width,
    bool decor = true,
  }) {
    showDialog(
      context: context,
      barrierColor: decor ? Colors.transparent : null,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext ctx) {
        _dialog = ctx;
        return Dialog(
          insetPadding: padding ?? const EdgeInsets.symmetric(horizontal: 9),
          backgroundColor: decor ? Colors.transparent : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: BlurDropFilterContainer(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: Wrap(
              children: [
                Material(
                  color: decor
                      ? const Color.fromARGB(
                          255,
                          232,
                          229,
                          229,
                        ).withOpacitySafe(0.8)
                      : Colors.white,
                  child: SizedBox(
                    width: width ?? context.sizeWidth,
                    child: Column(
                      children: [
                        if (closeButton)
                          Padding(
                            padding: const EdgeInsets.only(top: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton(
                                  type: AppButtonType.close,
                                  onClick: () => closeDialog(),
                                ),
                              ],
                            ),
                          ),
                        child,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> closeDialog() async {
    if (_dialog != null) {
      Navigator.of(_dialog!, rootNavigator: true).pop();
      _dialog = null;
    }
  }

  static Future<T?> showAppActionSheet<T>({
    required BuildContext context,
    String? title,
    String? message,
    List<SheetAction<T>> actions = const [],
    String? cancelLabel,
    AdaptiveStyle? style,
    bool isDismissible = true,
    bool useRootNavigator = true,
    MaterialModalActionSheetConfiguration? materialConfiguration,
    bool canPop = true,
    void Function(bool, T?)? onPopInvokedWithResult,
  }) {
    const defaultStyle = TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 49, 49, 49),
      fontWeight: FontWeight.w500,
      wordSpacing: 1.2,
    );

    final styledActions = actions
        .map(
          (a) => SheetAction<T>(
            label: a.label,
            key: a.key,
            icon: a.icon,
            isDefaultAction: a.isDefaultAction,
            isDestructiveAction: a.isDestructiveAction,
            textStyle: defaultStyle
                .merge(a.textStyle)
                .copyWith(
                  color: a.isDefaultAction
                      ? context.primaryColor
                      : a.textStyle.color,
                  fontSize: a.isDefaultAction ? 16 : null,
                  fontWeight: a.isDefaultAction ? FontWeight.bold : null,
                ),
          ),
        )
        .toList();

    return showModalActionSheet<T>(
      context: context,
      title: title,
      message: message,
      actions: styledActions,
      cancelLabel: cancelLabel,
      style: style,
      isDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      materialConfiguration: materialConfiguration,
      canPop: canPop,
      onPopInvokedWithResult: onPopInvokedWithResult,
    );
  }

  static Future<void> showCustomDateTimePicker(
    BuildContext context, {
    List<DateTime?>? value,
    bool disablePastDate = false,
    CalendarDatePicker2Type type = CalendarDatePicker2Type.range,
    required Function(List<DateTime>) onValueChanged,
    Function()? onCancel,
    Function()? onSave,
  }) async {
    await showChildModalWidget(
      context,
      decor: false,
      borderRadius: 30,
      barrierDismissible: onCancel == null || onSave == null,
      closeButton: false,
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: type,
                firstDate: disablePastDate ? DateTime.now() : null,
                weekdayLabelTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 13,
                ),
                controlsTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                selectedDayHighlightColor: context.primaryColor,
                selectedDayTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                todayTextStyle: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                customModePickerIcon: SizedBox.shrink(),
              ),
              value: value ?? [],
              onValueChanged: onValueChanged,
            ),
            if (onSave != null || onCancel != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onCancel != null) ...[
                      TextButton(
                        onPressed: onCancel,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadiusGeometry.circular(30),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Box.width(8),
                    ],
                    if (onSave != null) ...[
                      TextButton(
                        onPressed: onSave,
                        style: TextButton.styleFrom(
                          backgroundColor: context.primaryColor,
                          foregroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(30),
                          ),
                        ),
                        child: Text(
                          'Close',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  static void openPreviewDocument({
    bool isEdit = false,
    int index = 0,
    required BuildContext context,
    required List<Document> documents,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) =>
            _FullScreenGallery(initialIndex: index, documents: documents),
      ),
    );
  }
}

class _FullScreenGallery extends StatefulWidget {
  final List<Document> documents;
  final int initialIndex;

  const _FullScreenGallery({
    required this.documents,
    required this.initialIndex,
  });

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery>
    with AutomaticKeepAliveClientMixin {
  late int index;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.documents.length,
            onPageChanged: (page) => setState(() {
              index = page;
            }),
            itemBuilder: (_, index) {
              return InteractiveViewer(
                child: Center(
                  child: AppCacheImage(
                    image: widget.documents[index].imageUrl!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            right: 5,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
