import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Routes/welcome.dart';

num base = 13 + (13 * 0.133);

Map<String, dynamic> cachedplatterfontdata = {};

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
  bool prop = index % 2 == 0;
  if (index == 0) {
    index = 0.10;
  }
  num result = pow(1.2720196495141103, index) * base;
  return (prop ? result * pow(1.075, index) : result).toDouble();
}

double fontSizeNumberCeroTimes(num times) {
  num index = 0;
  bool prop = index % 2 == 1;
  num result = pow(1.2720196495141103, index) * base;
  return (prop ? result * pow(1.075, index) : result).toDouble() * times;
}

double pixelNumberfromFigma(num pixelFigma) {
  final value = cachedplatterfontdata["pixelNumberfromFigma${pixelFigma}"];
  if (value != null) {
    return value;
  }
  cachedplatterfontdata["pixelNumberfromFigma${pixelFigma}"] = (0 % 2 == 1
              ? (pow(1.2720196495141103, 0) * base) * pow(1.075, 0)
              : (pow(1.2720196495141103, 0) * base))
          .toDouble() *
      pixelFigma /
      12.67;
  return cachedplatterfontdata["pixelNumberfromFigma${pixelFigma}"]!;
}

TextStyle fontSize(num index,
    {Function font = GoogleFonts.inter,
    bool letterSpacing = false,
    TextStyle style = const TextStyle()}) {
  final value = cachedplatterfontdata["fontSize${index}_${font.toString()}"];
  if (value != null) {
    value;
  }
  cachedplatterfontdata["fontSize${index}_${font.toString()}"] = font
      .call(
          letterSpacing:
              letterSpacing ? 0.175 * (pow(1.025, index).toDouble()) : null,
          fontSize: (index % 2 == 1
                  ? (pow(1.2720196495141103, index) * base) * pow(1.075, index)
                  : (pow(1.2720196495141103, index) * base))
              .toDouble())
      .merge(style);
  style.merge(TextStyle(
      // leadingDistribution: TextLeadingDistribution.even,
      ));
  return cachedplatterfontdata["fontSize${index}_${font.toString()}"]!;
}
