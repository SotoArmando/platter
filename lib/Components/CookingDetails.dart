import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class CookingDetails extends StatefulWidget {
  const CookingDetails({super.key});

  @override
  State<CookingDetails> createState() => _CookingDetailsState();
}

class _CookingDetailsState extends State<CookingDetails> {
  var _controller = PageController(viewportFraction: 0.6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SingleChildScrollView(
                child: Padding(
      padding: EdgeInsets.only(
          left: fontSizeNumber(0 + (1 / 4)),
          right: fontSizeNumber(0 + (1 / 4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.red,
            height: fontSizeNumber(11.5),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: fontSizeNumber(7 + (1 / 0.75)),
                          maxWidth: fontSizeNumber(7 + (1 / 0.75)),
                        ),
                        child: Stack(alignment: Alignment.center, children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset("Platter/tasty.png",
                                fit: BoxFit.contain),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 30, 131, 255),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            transform: Matrix4.translationValues(
                                0, fontSizeAntiEdgeNumber(9 + (1 / 3)) * -1, 0),
                            width: fontSizeNumber(8 + (1 / 0.75)),
                            height: fontSizeNumber(8 + (1 / 0.75)),
                            child: SvgPicture.asset(
                              "Platter/line0.svg",
                              fit: BoxFit.contain,
                              color: Colors.black,
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        width: fontSizeNumber(1),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: fontSizeNumber(7 + (1 / 0.75)),
                          maxWidth: fontSizeNumber(7 + (1 / 0.75)),
                        ),
                        child: Stack(alignment: Alignment.center, children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                                "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/5460c9fc5f5e4141b5432fa728d12bb7/FB_05.jpg?output-format=auto&output-quality=auto&resize=600:*",
                                fit: BoxFit.contain),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 30, 131, 255),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            transform: Matrix4.translationValues(
                                0, fontSizeAntiEdgeNumber(9 + (1 / 3)) * -1, 0),
                            width: fontSizeNumber(8 + (1 / 0.75)),
                            height: fontSizeNumber(8 + (1 / 0.75)),
                            child: SvgPicture.asset(
                              "Platter/line0.svg",
                              fit: BoxFit.contain,
                              color: Colors.black,
                            ),
                          )
                        ]),
                      ),
                    ]),
                Container(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: fontSizeNumber(2.5),
                      child: Textspace(
                        text: "Alvin",
                        size: 2.5,
                        font: GoogleFonts.workSans,
                      ),
                    ))
              ],
            ),
          ),
          Textspace(text: "10-9-2020", size: 0.5),
          Textspace(
              style: TextStyle(height: 1.866666667),
              text: "1 box cake mix, prepared"),
          Textspace(
            style: TextStyle(height: 1.866666667),
            text:
                "15 oz ricotta cheese (425 g)\n8 oz mascarpone cheese (225 g), room temperature\n1 cup powdered sugar (120 g)\n1 teaspoon vanilla\n1 cup mini chocolate chips (175 g)\n",
            headsize: 1,
          ),
          SizedBox(
            height: fontSizeNumber(0),
          ),
          Container(
            child: SizedBox(
                height: fontSizeNumber(13 + (1 / 6)),
                child: Stack(
                  children: [
                    Container(
                      constraints:
                          BoxConstraints(maxWidth: fontSizeNumber(10.9)),
                      child: PageView(
                        // padEnds: true,
                        scrollDirection: Axis.vertical,
                        controller: _controller,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            constraints:
                                BoxConstraints(maxWidth: fontSizeNumber(10.9)),
                            child: Textspace(
                                alignment: Alignment.topLeft,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    height: 1.866666667,
                                    letterSpacing: fontSizeNumber(0) * 0.03),
                                text:
                                    "1 - Prepare the tofu and scallions: Cut the tofu into very small cubes, 1/4 inch to 1/2 inch on each side; set aside. Slice the scallions very thinly; set aside."),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            constraints:
                                BoxConstraints(maxWidth: fontSizeNumber(10.9)),
                            child: Textspace(
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    height: 1.866666667,
                                    letterSpacing: fontSizeNumber(0) * 0.03),
                                text:
                                    "2 - Prepare the tofu and scallions: Cut the tofu into very small cubes, 1/4 inch to 1/2 inch on each side; set aside. Slice the scallions very thinly; set aside."),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            constraints:
                                BoxConstraints(maxWidth: fontSizeNumber(10.9)),
                            child: Textspace(
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    height: 1.86666666,
                                    letterSpacing: fontSizeNumber(0) * 0.037),
                                text:
                                    "3 - Prepare the tofu and scallions: Cut the tofu into very small cubes, 1/4 inch to 1/2 inch on each side; set aside. Slice the scallions very thinly; set aside."),
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: fontSizeNumber(10.9)),
                            child: Textspace(
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    height: 1.86666666,
                                    letterSpacing: fontSizeNumber(0) * 0.037),
                                text: "- End of the script -"),
                          ),
                        ],
                      ),
                    ),
                    IgnorePointer(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0,
                                0.15,
                                0.180,
                                0.3,
                                0.5,
                                0.7,
                                1,
                              ],
                              colors: <Color>[
                                Color(0xffFAFAFA),
                                Color(0x00FAFAFA),
                                Color(0x00FAFAFA),
                                Color.fromARGB(2, 129, 129, 129),
                                Color(0x00FAFAFA),
                                Color(0x00FAFAFA),
                                Color(0xffFAFAFA),
                              ], // Gradient from https://learnui.design/tools/gradient-generator.html
                              tileMode: TileMode.mirror,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: fontSizeNumber(1),
                            ),
                            SvgPicture.asset("Platter/Group147.svg"),
                            SizedBox(
                              height: fontSizeNumber(4),
                            ),
                            SvgPicture.asset("Platter/Group190.svg")
                          ],
                        )
                      ],
                    )
                  ],
                )),
          ),
          SizedBox(
            height: fontSizeNumber(1),
          ),
          ElevatedButton(
            // Within the SecondScreen widget
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ],
      ),
    ))));
  }
}
