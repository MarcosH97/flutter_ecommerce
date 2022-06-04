import 'package:flutter/cupertino.dart';

class Device {
  Device() {}

  static final double tablet = 700;
  static final double desktop = 720;
  static final double iphone = 600;

  bool isMobile(context) {
    return MediaQuery.of(context).size.width > 0 &&
        MediaQuery.of(context).size.width < 640;
  }
}
