import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class Textspace extends StatelessWidget {
  final String text;
  final Function font;
  final FontWeight fontWeight;
  final num size;
  final num headsize;
  final bool letterSpacing;
  final bool underline;
  final TextStyle style;
  final int? maxLines;
  final Alignment alignment;
  final bool antiLeftpad;
  final bool fixSize;
  final double fixProportion;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextOverflow textOverflow;
  final TextAlign? textAlign;

  const Textspace(
      {super.key,
      this.text = "Halloween Candy Popcorn",
      this.padding,
      this.font = GoogleFonts.inter,
      this.size = 0,
      this.fontWeight = FontWeight.w400,
      this.headsize = 3.875,
      this.letterSpacing = true,
      this.style = const TextStyle(),
      this.fixSize = false,
      this.underline = false,
      this.height,
      this.maxLines,
      this.textOverflow = TextOverflow.visible,
      this.fixProportion = 1 - 0.17,
      this.alignment = Alignment.centerLeft,
      this.textAlign,
      this.antiLeftpad = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,

      // color: Colors.blue[300],
      // height: ,
      constraints: BoxConstraints(
          minHeight: height ??
              (headsize > 0
                  ? fontSizeNumber(headsize)
                  : (fixSize ? fontSizeNumber(size * fixProportion) : 0))),
      alignment: alignment,
      child: Transform(
          transform: Matrix4.translationValues(
              antiLeftpad ? 0 : fontSizeAntiEdgeNumber(size),
              fixSize ? -1 : 0,
              0),
          child: Text(
            "${text}",
            softWrap: true,
            maxLines: maxLines,
            textAlign: textAlign,
            textHeightBehavior:
                const TextHeightBehavior(applyHeightToFirstAscent: false),
            overflow: textOverflow,
            style: fontSize(size,
                font: font, style: style, letterSpacing: letterSpacing),
          )),
    );
  }
}
