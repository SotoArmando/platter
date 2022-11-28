import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class CookingAssistantItem1 extends StatefulWidget {
  const CookingAssistantItem1({super.key});

  @override
  State<CookingAssistantItem1> createState() => _CookingAssistantItem1State();
}

class _CookingAssistantItem1State extends State<CookingAssistantItem1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Color(0xffD7D7D7))),
        constraints: BoxConstraints(minHeight: fontSizeNumber(0) * 4.577742699),
        margin: EdgeInsets.only(top: fontSizeNumber(0) * 0.789265983),
        child: IntrinsicHeight(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: fontSizeNumber(0) * 0.789265983,
                      right: fontSizeNumber(0) * 1.34175217,
                      top: fontSizeNumber(0) * 0.552486188),
                  color: Colors.red[300],
                  width: fontSizeNumber(0) * 2.999210734,
                  height: fontSizeNumber(0) * 2.999210734,
                  child: Image.asset(
                    "assets/platter/unnamed.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      minHeight: fontSizeNumber(0) * 4.577742699),
                  padding: EdgeInsets.only(
                      bottom: fontSizeNumber(0) * 0.584846093,
                      top: fontSizeNumber(0) * 0.304262036),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Classic Chicken Noodle Soup",
                        size: 1.0001,
                        headsize: 0,
                        fixSize: true,
                        fixProportion: 1.5,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600, height: 0),
                      ),
                      SizedBox(
                        height: fontSizeNumber(0) * 0.647198106,
                      ),
                      Textspace(
                          text: "4 cups shredded chicken breast",
                          headsize: 1,
                          fixSize: true,
                          fixProportion: 1,
                          style: TextStyle(height: 0))
                    ],
                  ),
                )
              ]),
        ));
  }
}
