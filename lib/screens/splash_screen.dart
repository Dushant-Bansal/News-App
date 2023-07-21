import 'package:flutter/material.dart';
import 'package:news_app/screens/homepage.dart';
import 'package:news_app/style/logo.dart';
import 'package:news_app/style/palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final _tweenDouble = Tween<double>(begin: 0, end: 1);

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController.forward().then((value) => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage())));
  }

  @override
  void dispose() {
    animationController.reset();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _tweenDouble.animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeOutCubic,
        ),
      ),
      child: Scaffold(
        backgroundColor: Palette.black,
        body: const Center(child: Logo(fontSize: 40)),
      ),
    );
  }
}
