import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final Color spinColor;
  final int type;

  const LoadingSpinner({
    this.spinColor = Colors.white,
    super.key,
    this.type = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      return buildSpinner(spinColor: spinColor, type: type);
    }
    return CircularProgressIndicator(color: spinColor);
  }

  static Widget buildSpinner({
    Color? spinColor,
    int type = 1,
    double size = 30,
  }) {
    if (type == 1) {
      return Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(color: spinColor ?? Colors.white),
        ),
      );
    } else if (type == 2) {
      return Center(
        child: SizedBox(
          width: size,
          height: size,
          child: Transform.scale(
            scale: 1.8,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: spinColor ?? Colors.white,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(color: spinColor),
    );
  }
}
