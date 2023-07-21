import 'package:flutter/material.dart';
import 'palette.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Insights',
      style: TextStyle(
        color: Palette.primary,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: -4,
      ),
    );
  }
}
