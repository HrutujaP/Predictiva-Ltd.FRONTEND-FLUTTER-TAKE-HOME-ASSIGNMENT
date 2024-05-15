import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';

class OptionBox extends StatelessWidget {
  final bool icon;
  const OptionBox({
    super.key,
    required this.neg,
    required this.changeValue,
    this.icon = false,
  });

  final bool neg;
  final String changeValue;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 70),
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: neg ? redLineColor : greenLineColor),
              color: boxColorBackGround,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon)
                  Transform.rotate(
                      angle: neg ? 3.14 : 0,
                      child: Icon(Icons.arrow_outward_rounded,
                          color: neg ? redLineColor : greenLineColor,
                          size: primaryFontSize)),
                Text(changeValue,
                    style: TextStyle(
                        fontSize: optionFontSize,
                        fontWeight: secondaryFontWeight,
                        color: neg ? redLineColor : greenLineColor)),
              ],
            ),
          )),
    );
  }
}
