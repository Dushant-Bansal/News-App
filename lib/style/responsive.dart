import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class Responsive extends StatelessWidget {
  /// AppBar for the Widget
  ///
  /// Same in Both Desktop and Mobile
  final Widget appBar;

  /// Body
  final Widget body;

  /// SideBar or Bottom Bar
  ///
  /// If [kIsDesktop] is true, then shows as Sidebar
  ///
  /// If [kIsMobile] is true, then shows as Bottom Bar
  final Widget sideOrBottom;

  /// Ratio of [body] to [screen]
  ///
  /// Allocates available space to [body] w.r.t [flex]
  final double mainAreaCoverage;

  const Responsive({
    required this.appBar,
    required this.body,
    this.sideOrBottom = const SizedBox.shrink(),
    this.mainAreaCoverage = 0.7,
    super.key,
  }) : assert(mainAreaCoverage >= 0 && mainAreaCoverage <= 1);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final padding = EdgeInsets.all(size.shortestSide / 40);

        if (size.height >= size.width) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: padding,
                  child: appBar,
                ),
              ),
              Expanded(
                flex: (mainAreaCoverage * 10).round(),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  minimum: padding,
                  child: body,
                ),
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: sideOrBottom,
                ),
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SafeArea(
                  right: false,
                  maintainBottomViewPadding: true,
                  child: sideOrBottom,
                ),
              ),
              Expanded(
                flex: (mainAreaCoverage * 10).round(),
                child: Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      left: false,
                      maintainBottomViewPadding: true,
                      minimum: padding,
                      child: appBar,
                    ),
                    Expanded(
                      child: SafeArea(
                        top: false,
                        left: false,
                        maintainBottomViewPadding: true,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: padding,
                            child: body,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
