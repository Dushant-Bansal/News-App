import 'package:flutter/material.dart';

@immutable
class BarIcon {
  const BarIcon({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final Icon icon;
  final Icon selectedIcon;
  final String label;
}
