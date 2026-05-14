import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension SafeOpacityColor on Color {
  Color withOpacitySafe(double opacity) =>
      withAlpha((opacity.clamp(0.0, 1.0) * 255).round());
}

final List<String> icons = const [
  '🏡',
  '🏢',
  '🏛️',
  '🏰',
  '🏚️',
  '🛏️',
  '🛋️',
  '🚪',
  '🪟',
  '🚿',
  '🛁',
  '🪞',
  '🪴',
  '☀️',
  '🌅',
  '🌃',
  '🌊',
  '🔥',
  '🍹',
  '🍽️',
  '🧳',
  '✈️',
  '🚗',
  '🏖️',
  '🏜️',
  '🏞️',
  '🌄',
  '🌺',
  '🌻',
];

String get randomIcon {
  final random = Random();
  return icons[random.nextInt(icons.length)];
}

extension CurrencyVNExtension on num? {
  String get toVND {
    try {
      final formatter = NumberFormat.currency(
        locale: 'vi_VN',
        symbol: '',
        decimalDigits: 0,
      );
      return '${formatter.format(this).replaceAll('.', ',').trim()} ';
    } catch (_) {
      return '_';
    }
  }
}

extension CurrencyParsing on String {
  String get cleanCurrency {
    return replaceAll(RegExp(r'[.,\s]'), '');
  }

  int get toCurrencyInt {
    return int.tryParse(cleanCurrency) ?? 0;
  }
}

extension FormatExtension on int? {
  String get toDATE {
    try {
      if (this == null) return '-';
      final dateTime = DateTime.fromMillisecondsSinceEpoch(this!);
      return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
    } catch (_) {
      return '-';
    }
  }

  String get toDATEONLY {
    try {
      if (this == null) return '-';
      final dateTime = DateTime.fromMillisecondsSinceEpoch(this!);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (_) {
      return '-';
    }
  }

  String get getBookingStatusName {
    try {
      if (this == null) return '-';
      switch (this) {
        case 1:
          return 'Waiting Payment';
        case 2:
          return 'Room Cacel';
        case 3:
          return 'Waiting Confirm';
        case 4:
          return 'Reject';
        case 5:
          return 'User Cancel';
        case 6:
          return 'Refund Payment';
        case 7:
          return 'Success';
        case 8:
          return 'Done';
        default:
          return '-';
      }
    } catch (_) {
      return '-';
    }
  }
}

extension TimestampFormatExtension on DateTime? {
  String get toDATE {
    try {
      if (this == null) return '-';
      return DateFormat('dd/MM/yyyy HH:mm:ss').format(this!);
    } catch (_) {
      return '-';
    }
  }

  String get toDATEONLY {
    try {
      if (this == null) return '-';
      return DateFormat('dd/MM/yyyy').format(this!);
    } catch (_) {
      return '-';
    }
  }

  String get toDateDataRequest {
    if (this == null) return '';
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this!);
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '',
    decimalDigits: 0,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final number = int.parse(newText);

    final formatted = _formatter.format(number).replaceAll('.', ',').trim();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
