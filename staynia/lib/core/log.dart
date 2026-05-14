import 'dart:developer' as dev;

class Log {
  static void d(dynamic value, {String name = 'DEBUG', bool inspect = true}) {
    dev.log(value.toString(), name: ' ${name.toUpperCase()} ');
    if (inspect) i(value);
  }

  static void i(dynamic value) => dev.inspect(value);
}
