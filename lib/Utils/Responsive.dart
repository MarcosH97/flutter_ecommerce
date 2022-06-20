import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 849 &&
      MediaQuery.of(context).size.width > 1100;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1099;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (size.width >= 1100)
      return desktop;
    else if (tablet != null && size.width >= 850)
      return tablet;
    else
      return mobile;
  }
}
