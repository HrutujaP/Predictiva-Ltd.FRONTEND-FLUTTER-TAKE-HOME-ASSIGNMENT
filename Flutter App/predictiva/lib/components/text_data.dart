import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';

class TextData extends StatelessWidget {
  const TextData({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
          fontSize: secondaryFontSize,
          fontWeight: primaryFontWeight,
          color: primaryTextColor),
    );
  }
}
