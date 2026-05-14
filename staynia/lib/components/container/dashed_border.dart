import 'package:flutter/material.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/theme_extension.dart';

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Color? color;
  final BorderRadius borderRadius;
  final String? title;
  final bool isRequired;

  const DashedBorder({
    super.key,
    required this.child,
    this.strokeWidth = 2,
    this.dashWidth = 10,
    this.dashSpace = 8,
    this.color,
    this.isRequired = false,
    this.title,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(defaultBorderRadious),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 12.3,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          ),
        Box.height(6),
        CustomPaint(
          painter: _DashedBorderPainter(
            color: color ?? context.primaryColor,
            strokeWidth: strokeWidth,
            dashWidth: dashWidth,
            dashSpace: dashSpace,
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);
    final path = Path()..addRRect(rrect);
    if (dashWidth <= 0 || dashSpace < 0) {
      canvas.drawPath(path, paint);
      return;
    }

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = (distance + dashWidth).clamp(0, metric.length);
        final segment = metric.extractPath(distance, next.toDouble());
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
