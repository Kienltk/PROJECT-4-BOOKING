import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:staynia/components/container/blur_drop_filter_container.dart';
import 'package:staynia/components/media/app_asset_image.dart';
import 'package:staynia/core/constants/app_image.dart';
import 'package:staynia/extension/app_extension.dart';

class NotificationService {
  static CancelFunc? currentNotification;

  static showNotification(
    String message, {
    int type = 1,
    String? title,
    bool enableSlideOff = true,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClick,
    String image = AppImage.logo,
  }) {
    currentNotification?.call();
    currentNotification = BotToast.showCustomNotification(
      duration: duration,
      animationDuration: const Duration(milliseconds: 250),
      enableSlideOff: enableSlideOff,
      onlyOne: true,
      crossPage: true,
      toastBuilder:
          (_) => _buildContent(
            isWarning: false,
            message: message,
            title: title ?? "Notification",
            type: type,
            onClick: onClick,
            image: image,
          ),
    );
  }

  static CancelFunc showBottomToast(
    String message, {
    Duration duration = const Duration(seconds: 3),
    bool isWarning = false,
    VoidCallback? onClick,
    String? image,
    int type = 1,
  }) {
    return BotToast.showCustomText(
      duration: duration,
      toastBuilder:
          (_) => _buildContent(
            isWarning: isWarning,
            message: message,
            onClick: onClick,
            type: type,
            image: image,
          ),
    );
  }

  static Widget _buildContent({
    required String message,
    required bool isWarning,
    String? image,
    int type = 1,
    String? title,
    VoidCallback? onClick,
  }) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: BlurDropFilterContainer(
       borderRadius: BorderRadius.circular(18),
      child: Material(
        color:
            type == 2
                ? Colors.black
                : const Color.fromARGB(
                  255,
                  232,
                  229,
                  229,
                ).withOpacitySafe(0.75),
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            5,
            3,
            5,
            3,
          ).copyWith(left: 8, right: image != null ? 0 : 10),
          child: ListTile(
            onTap: onClick ?? () {},
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title ?? "Notification",
                style: TextStyle(
                  color:
                      type == 2
                          ? const Color.fromARGB(255, 209, 208, 208)
                          : const Color.fromARGB(255, 116, 116, 116),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.5,
                ),
              ),
            ),
            subtitle: Text(
              message,
              style: TextStyle(
                color: type == 2 ? Colors.white : Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
              ),
            ),
            leading:
                image != null
                    ? CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: AppAssetImage(
                          AppImage.logo,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                    : null,
          ),
        ),
      ),
    ),
  );
}
