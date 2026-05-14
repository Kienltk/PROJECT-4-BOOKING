import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<void> save(String key, dynamic value) async {
    if (value == null) {
      await _storage.delete(key: key);
      return;
    }

    if (value is String) {
      await _storage.write(key: key, value: value);
    } else if (value is int || value is double || value is bool) {
      await _storage.write(key: key, value: value.toString());
    } else if (value is List<String>) {
      await _storage.write(key: key, value: _encodeList(value));
    } else if (value is List<int>) {
      await _storage.write(
        key: key,
        value: _encodeList(value.map((e) => e.toString()).toList()),
      );
    } else {
      throw UnsupportedError('Unsupported type');
    }
  }

  static Future<dynamic> get(String key, {Type? type}) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;

    try {
      if (type == String || type == null) {
        return value;
      } else if (type == int) {
        return int.tryParse(value);
      } else if (type == double) {
        return double.tryParse(value);
      } else if (type == bool) {
        return value.toLowerCase() == 'true';
      } else if (type == List<String>) {
        return _decodeList(value);
      } else if (type == List<int>) {
        final list = _decodeList(value);
        return list.map((e) => int.tryParse(e) ?? 0).toList();
      } else {
        return value;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  static String _encodeList(List<String> list) =>
      list.isEmpty
          ? '[]'
          : '[${list.map((e) => '"${e.replaceAll('"', '\\"')}"').join(',')}]';

  static List<String> _decodeList(String jsonStr) {
    try {
      final decoded = jsonStr.trim();
      if (!decoded.startsWith('[') || !decoded.endsWith(']')) return [];
      final inner = decoded.substring(1, decoded.length - 1);
      if (inner.isEmpty) return [];
      return inner
          .split(',')
          .map((e) => e.trim().replaceAll('"', '').replaceAll('\\"', '"'))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
