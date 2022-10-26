import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/CookingAssistantItem1.dart';
import 'package:p_l_atter/Components/CookingAssistantItem2.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class Cookingassistance extends StatelessWidget {
  const Cookingassistance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            // color: Colors.pink,
            padding: EdgeInsets.only(
                top: fontSizeNumber(0) * 3.866614049,
                bottom: fontSizeNumber(0) * 0.631412786),
            // height: fontSizeNumber(2) * 11.772195122,
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       // color: Colors.blue,
                  //       width: fontSizeNumber(10.9),
                  //       // color: Colors.pink,
                  //       alignment: Alignment.centerLeft,
                  //       child: Icon(
                  //         Icons.clear,
                  //         color: Colors.red,
                  //         size: 24.0,
                  //         semanticLabel:
                  //             'Text to announce in accessibility modes',
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  Textspace(
                    text: "0:00",
                    antiLeftpad: true,
                    fixSize: true,
                    size: 7.00000000001,
                    headsize: 0,
                    font: GoogleFonts.inter,
                    style: TextStyle(
                      height: 0.01,
                      fontWeight: FontWeight.w400,
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                  SizedBox(
                    height: fontSizeNumber(0) * 0.733228098,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            width: fontSizeNumber(0) * 6.629834254,
                            padding: EdgeInsets.only(
                                bottom: (fontSizeNumber(2) * 1.756097561) *
                                    0.22361111111),
                            child: Textspace(
                              text: "1M",
                              size: 2,
                              headsize: 2,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        Container(
                          height: fontSizeNumber(2) * 1.756097561,
                          color: Color(0xffD7D7D7),
                          constraints: BoxConstraints(minWidth: 1),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: fontSizeNumber(0) * 6.629834254,
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(
                                bottom: (fontSizeNumber(2) * 1.756097561) *
                                    0.22361111111),
                            child: Textspace(
                              text: "6M",
                              size: 2,
                              headsize: 2,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        Container(
                          height: fontSizeNumber(2) * 1.756097561,
                          color: Color(0xffD7D7D7),
                          constraints: BoxConstraints(minWidth: 1),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: fontSizeNumber(0) * 6.629834254,
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(
                                bottom: (fontSizeNumber(2) * 1.756097561) *
                                    0.22361111111),
                            child: Textspace(
                              text: "30M",
                              size: 2,
                              headsize: 2,
                              alignment: Alignment.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
          SizedBox(
            height: fontSizeNumber(0) * 0.631412786,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffD7D7D7)))),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Textspace(
                      text: "Library",
                      size: 1.0001,
                      alignment: Alignment.center,
                      style: TextStyle(color: Color(0xFF000000)),
                    ),
                  )),
                  Container(
                    height: fontSizeNumber(0) * 2.2332506203473943,
                    color: Color(0xFFD7D7D7),
                    constraints: BoxConstraints(minWidth: 1),
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Textspace(
                      text: "In",
                      size: 1.0001,
                      style: TextStyle(color: Color(0xFFD7D7D7)),
                      alignment: Alignment.center,
                    ),
                  )),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: fontSizeNumber(0) * 0.947119179,
                  right: fontSizeNumber(0) * 0.947119179),
              child: Column(
                children: [
                  CookingAssistantItem1(),
                  CookingAssistantItem2(),
                  CookingAssistantItem1(),
                  CookingAssistantItem2(),
                  CookingAssistantItem1(),
                  CookingAssistantItem2(),
                  CookingAssistantItem1(),
                  CookingAssistantItem2(),
                ],
              ))
        ],
      )),
    );
  }
}
