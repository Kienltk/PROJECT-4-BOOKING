import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ContextExtensions on BuildContext {

  void get unFocusInput => FocusScope.of(this).unfocus();

  double get sizeWidth => MediaQuery.of(this).size.width;

  double get sizeHeight => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;

  bool get canPop => Navigator.canPop(this);

  EdgeInsets get safeBottom =>
      EdgeInsets.only(bottom: MediaQuery.of(this).viewInsets.bottom);
}
