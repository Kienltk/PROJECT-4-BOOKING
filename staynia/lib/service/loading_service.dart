import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:staynia/components/media/app_asset_image.dart';
import 'package:staynia/core/constants/app_gif.dart';
import 'package:staynia/core/constants/constants.dart';

class LoadingService {
  static CancelFunc? _cancelFunc;

  static void show({String? message}) {
    if (_cancelFunc != null) return;
    _cancelFunc = BotToast.showCustomLoading(
      toastBuilder: (_) {
        return Center(
          child: Container(
            width: 80,
            height: 75,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: loading(message: message),
          ),
        );
      },
    );
  }

  static void hide() {
    if (_cancelFunc != null) {
      _cancelFunc!();
      _cancelFunc = null;
    }
  }

  static Widget loading({String? message, double? size, Color? color}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 47,
            height: 47,
            child: AppAssetImage(
              AppGifs.loading,
              fit: BoxFit.contain,
              color: Colors.black,
            ),
          ),
          if (message != null) ...[
            Box.height(8),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
