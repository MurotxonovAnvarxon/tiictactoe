import 'package:flutter/material.dart';

class RectangularSpotlightPainter extends CustomPainter {
  /// Bu parametr (topWidth) – trapezoidning yuqori qismi eni.
  /// Ya'ni, lampaning "chiqish joyi" qancha keng bo'lishini belgilaysiz.
  final double topWidth;

  /// Yorug‘likning rangi yoki gradienti uchun asosiy rang.
  final Color color;

  RectangularSpotlightPainter({
    required this.topWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Gradientni vertical (yuqoridan pastga) yo‘nalishda beramiz.
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.4), // Yuqorida biroz yorug‘roq
          Colors.transparent,     // Pastga tushgan sari shaffoflashadi
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Trapezoid shakl:
    //  - Yuqori chap burchak: ( (size.width - topWidth) / 2, 0 )
    //  - Yuqori o‘ng burchak: ( (size.width + topWidth) / 2, 0 )
    //  - Pastki chap burchak: (0, size.height)
    //  - Pastki o‘ng burchak: (size.width, size.height)
    final path = Path()
      ..moveTo((size.width - topWidth) / 2, 0)
      ..lineTo((size.width + topWidth) / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // Chizamiz
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
