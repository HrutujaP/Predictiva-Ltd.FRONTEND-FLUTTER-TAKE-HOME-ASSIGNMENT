import 'package:flutter/material.dart';

class ResponsiveWidget {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 650;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 650;
  }
}
