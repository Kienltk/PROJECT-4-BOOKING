import 'dart:convert';
import 'dart:math';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/theme/custom_theme.dart';
import 'package:staynia/router/application_router.dart';
import 'package:staynia/service/notification_service.dart';
import 'package:timeago/timeago.dart' as timeAgoPack;
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String cleanHtml(String rawHtml) {
    return rawHtml.replaceAllMapped(
      RegExp(
        "font-feature-settings\\s*:\\s*['\\\"]?[^'\\\";}]+['\\\"]?;?",
        caseSensitive: false,
      ),
      (match) => '',
    );
  }

  static String generateActionKey({String prefix = "ACTION"}) {
    final random = Random().nextInt(1000);
    final millis = DateTime.now().millisecondsSinceEpoch;
    return "$prefix$random$millis";
  }

  static Future<bool> hasStoragePermissions() async {
    final permissions = [
      Permission.storage,
      Permission.accessMediaLocation,
      Permission.mediaLibrary,
    ];

    for (var permission in permissions) {
      if (!await permission.status.isGranted) return false;
    }
    return true;
  }

  static Future<bool> requestStoragePermissions() async {
    final permissions = [
      Permission.storage,
      Permission.accessMediaLocation,
      Permission.mediaLibrary,
    ];

    Map<Permission, PermissionStatus> result = await permissions.request();

    return result.values.every((status) => status.isGranted);
  }

  static Uint8List decodeBase64(String value) => base64.decode(value);

  static String getCurrentTime() =>
      DateFormat('HH:mm a').format(DateTime.now());

  static String timeAgo(String time) =>
      timeAgoPack.format(DateTime.parse(time), locale: 'vi');

  static String formatFileSize(String? bytes) {
    try {
      int value = int.parse(bytes!);
      if (value < 1024) {
        return '$value B';
      } else if (value < 1024 * 1024) {
        return '${(value / 1024).toStringAsFixed(2)} KB';
      } else if (value < 1024 * 1024 * 1024) {
        return '${(value / (1024 * 1024)).toStringAsFixed(2)} MB';
      } else {
        return '${(value / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
      }
    } catch (_) {
      return '-';
    }
  }

  static Color getStatusColor(int? status) {
    switch (status) {
      case 0:
        return primaryColor;
      case 1:
        return Colors.red;
      case 2:
        return Colors.purple;
      case 3:
        return const Color.fromARGB(255, 222, 93, 23);
      case 4:
        return Colors.teal;
      case 5:
        return Colors.teal;
      case 6:
        return Colors.teal;
      case 7:
        return Colors.green;
      case 8:
        return const Color.fromARGB(255, 24, 92, 216);
      case 9:
        return Colors.pink;
      case 10:
        return const Color.fromARGB(255, 24, 92, 216);
      default:
        return Colors.black;
    }
  }

  static String getFileIcon(String? type) {
    try {
      switch (type!.toLowerCase()) {
        case 'pdf':
          return AppSvg.filePdf;
        case 'jpg':
        case 'jpeg':
        case 'png':
        case 'gif':
        case 'bmp':
        case 'image':
        case 'webp':
          return AppSvg.fileImage;
        case 'doc':
        case 'docx':
          return AppSvg.fileWord;
        case 'xls':
        case 'xlsx':
          return AppSvg.fileExcel;
        case 'ppt':
        case 'pptx':
          return AppSvg.filePpt;
        case 'txt':
          return AppSvg.fileText;
        case 'mp3':
        case 'wav':
        case 'aac':
          return AppSvg.fileAudio;
        case 'mp4':
        case 'avi':
        case 'mov':
        case 'mkv':
          return AppSvg.fileVideo;
        case 'zip':
        case 'rar':
        case '7z':
          return AppSvg.file;
        case 'csv':
          return AppSvg.fileCsv;
        default:
          return AppSvg.fileImage;
      }
    } catch (_) {
      return AppSvg.fileImage;
    }
  }

  static bool checkLink(String value) {
    return Uri.tryParse(value)?.hasAbsolutePath == true &&
        (value.startsWith('http://') || value.startsWith('https://'));
  }

  static Future<void> openSmartLink(String? url) async {
    if (url == null || url.isEmpty || !url.startsWith('http')) {
      return;
    }
    final uri = Uri.parse(url);
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        // Platform.isIOS
        //     ? LaunchMode.platformDefault
        //     : LaunchMode.externalApplication,
      );
    } catch (_) {
      await showAlertDialog(
        context: navigatorKey.currentContext!,
        title: Constants.appName,
        message: "Lỗi. Xin vui lòng thử lại sau",
        actions: [AlertDialogAction(key: null, label: "Close")],
      );
    }
  }

  static Future<void> openPhone(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      NotificationService.showNotification("cannotOpenLink");
    }
  }
}
