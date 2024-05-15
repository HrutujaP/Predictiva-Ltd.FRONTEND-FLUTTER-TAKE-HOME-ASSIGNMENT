import 'package:flutter/material.dart';

const double primaryFontSize = 20;
const double secondaryFontSize = 16;
const double headingFontSize = 24;
const double optionFontSize = 14;

const double borderRadius = 10;

const FontWeight primaryFontWeight = FontWeight.w700;
const FontWeight secondaryFontWeight = FontWeight.w500;

const Color lineColor = Color(0xFF3E3F48);
const Color redLineColor = Color(0xFFCC0C0C);
const Color greenLineColor = Color(0xFF00AC3A);
const Color cautionColor = Color(0xFFE7B500);
const Color buttonColor = Color(0xFF00BCAF);

const Color backgroundColor = Color.fromARGB(100, 13, 13, 15);
const Color boxColorBackGround = Color(0xFF111115);
const Color boxColor = Color(0xFF161619);

const Color primaryTextColor = Color(0xFFFFFFFF);
const Color secondaryTextColor = Color(0xFFB1B1B8);

final BoxDecoration boxDecoration = BoxDecoration(
  color: boxColorBackGround,
  borderRadius: BorderRadius.circular(borderRadius),
  border: Border.all(color: lineColor),
);

const Widget lineDivider = Padding(
  padding: EdgeInsets.symmetric(vertical: 2.0),
  child: Divider(
    color: lineColor,
    thickness: 1,
  ),
);
const Widget verticalLineDivider = Padding(
  padding: EdgeInsets.symmetric(vertical: 2.0),
  child: VerticalDivider(
    color: lineColor,
    thickness: 1,
  ),
);

const String openOrdersAPI =
    'https://api-cryptiva.azure-api.net/staging/api/v1/orders/open';
const String portfolioAPI =
    'https://api-cryptiva.azure-api.net/staging/api/v1/accounts/portfolio';
