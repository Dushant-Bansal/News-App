import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/bar_icon.dart';

/// Provider representing current index in bottom bar or side bar
final indexStateProvider = StateProvider<int>((ref) => 0);

/// Provider for Bar Icons List
final iconProvider = Provider.autoDispose<List<BarIcon>>(
  (ref) => const <BarIcon>[
    BarIcon(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    BarIcon(
      icon: Icon(Icons.bookmark_outline_rounded),
      selectedIcon: Icon(Icons.bookmark_rounded),
      label: 'Saved',
    ),
  ],
);
