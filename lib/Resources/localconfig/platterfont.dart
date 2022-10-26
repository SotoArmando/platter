import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

const num base = 14;

double proportionNumber(num index) {
  return pow(1.61803398875, index).toDouble();
}

double fontSizeAntiEdgeNumber(num index) {
  bool prop = index % 2 == 1;
  num result = pow(pow(1.61803398875, 1.1), index) * (base * 0.0275);
  return (prop ? result * pow(1.075, index) : result).toDouble() * -1;
}

double fontSizeNumberMini(num index) {
  bool prop = index % 2 == 1;
  num result = pow(1.2720196495141103, index) * 1.9498649841628917;
  return (prop ? result * pow(1.075, index) : result).toDouble();
}

double fontSizeNumber(num index) {
  bool prop = index % 2 == 1;
  num result = pow(1.2720196495141103, index) * base;
  return (prop ? result * pow(1.075, index) : result).toDouble();
}

TextStyle fontSize(num index,
    {Function font = GoogleFonts.inter,
    bool letterSpacing = false,
    TextStyle style = const TextStyle()}) {
  bool prop = index % 2 == 1;
  num result = pow(1.2720196495141103, index) * base;
  style.merge(TextStyle(
      // leadingDistribution: TextLeadingDistribution.even,
      ));
  return font
      .call(
          letterSpacing:
              letterSpacing ? 0.175 * (pow(1.025, index).toDouble()) : null,
          fontSize: (prop ? result * pow(1.075, index) : result).toDouble())
      .merge(style);
}
