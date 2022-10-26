import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';

class Ratioscreen extends StatelessWidget {
  const Ratioscreen({super.key});
  final num baseSize = 17;
  double fontSizeAntiEdgeNumber(num index) {
    bool prop = index % 2 == 1;
    num result = pow(pow(1.61803398875, 1.1), index) * (baseSize * 0.0275);
    return (prop ? result * pow(1.075, index) : result).toDouble() * -1;
  }

  double fontSizeNumber(num index) {
    bool prop = index % 2 == 1;
    num result = pow(1.2720196495141103, index) * baseSize;
    return (prop ? result * pow(1.075, index) : result).toDouble();
  }

  TextStyle fontSize(num index, {Function font = GoogleFonts.inter}) {
    bool prop = index % 2 == 1;
    num result = pow(1.2720196495141103, index) * baseSize;

    return font.call(
        letterSpacing: 0.175 * (pow(1.025, index).toDouble()),
        fontSize: (prop ? result * pow(1.075, index) : result).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 5; i += 1)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Color.fromARGB(255, 95, 104, 110)),
                  ),
                ),
                height: 75,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hi buddy m..m ${i % 2 == 1}",
                  style: fontSize(i),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    transform: Matrix4.translationValues(
                        fontSizeAntiEdgeNumber(1), 0, 0),
                    height: fontSizeNumber(3.875),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Halloween Candy Popcorn",
                      style: fontSize(1.5, font: GoogleFonts.workSans)
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    child: Text(
                        "This Halloween candy popcorn mix is perfect for your next Hallo-Fest or spooky movie night. Using the Tasty Popcorn Popper makes this a super easy and fun snack. It’s the perfect way to use up leftover Halloween candy!",
                        style:
                            fontSize(0).copyWith(fontWeight: FontWeight.w500)),
                    transform: Matrix4.translationValues(
                        fontSizeAntiEdgeNumber(0), 0, 0),
                  ),
                  const Textspace(
                    text: "Apple Pie From Scratch",
                    size: 1.5,
                    headsize: 3.875,
                    fontWeight: FontWeight.w900,
                    font: GoogleFonts.workSans,
                  ),
                  const Textspace(
                    text:
                        "In a medium-sized bowl, add the flour and salt. Mix with fork until combined.",
                    size: 0,
                    headsize: -1,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: SvgPicture.asset(
                                "Platter/globe.svg",
                                height: fontSizeNumber(
                                    0.75 * pow(1.61803398875, 0)),
                                color: Color.fromARGB(255, 0, 0, 0),
                                matchTextDirection: true,
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: SvgPicture.asset(
                                "Platter/globe.svg",
                                height: fontSizeNumber(
                                    0.75 * pow(1.61803398875, 1)),
                                color: Color.fromARGB(255, 0, 0, 0),
                                matchTextDirection: true,
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: SvgPicture.asset(
                                "Platter/globe.svg",
                                height: fontSizeNumber(
                                    0.75 * pow(1.61803398875, 2)),
                                color: Color.fromARGB(255, 0, 0, 0),
                                matchTextDirection: true,
                              ),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: SvgPicture.asset(
                                "Platter/globe.svg",
                                height: fontSizeNumber(
                                    0.75 * pow(1.61803398875, 3)),
                                color: Color.fromARGB(255, 0, 0, 0),
                                matchTextDirection: true,
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: SvgPicture.asset(
                                "Platter/globe.svg",
                                height: fontSizeNumber(
                                    0.75 * pow(1.61803398875, 4)),
                                color: Color.fromARGB(255, 0, 0, 0),
                                matchTextDirection: true,
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: SvgPicture.asset(
                                "Platter/globe.svg",
                                height: fontSizeNumber(
                                    0.75 * pow(1.61803398875, 5)),
                                color: Color.fromARGB(255, 0, 0, 0),
                                matchTextDirection: true,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Material(
              elevation: 5,
              child: Container(
                height: fontSizeNumber(2.0125 * pow(1.61803398875, 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: SvgPicture.asset(
                              "Platter/house.svg",
                              height: fontSizeNumber(0.75),
                              color: Color.fromARGB(255, 0, 0, 0),
                              matchTextDirection: true,
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: SvgPicture.asset(
                              "Platter/time.svg",
                              height: fontSizeNumber(0.75),
                              color: Color.fromARGB(255, 0, 0, 0),
                              matchTextDirection: true,
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: SvgPicture.asset(
                              "Platter/search.svg",
                              height: fontSizeNumber(0.75),
                              color: Color.fromARGB(255, 0, 0, 0),
                              matchTextDirection: true,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Material(
              elevation: 5,
              child: Container(
                height: fontSizeNumber(2.0125 * pow(1.61803398875, 1.25)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: SvgPicture.asset(
                              "Platter/user.svg",
                              height:
                                  fontSizeNumber(0.75 * pow(1.61803398875, 3)),
                              color: Color.fromARGB(255, 15, 175, 255),
                              matchTextDirection: true,
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: SvgPicture.asset(
                              "Platter/location.svg",
                              height:
                                  fontSizeNumber(0.75 * pow(1.61803398875, 0)),
                              color: Color.fromARGB(255, 0, 0, 0),
                              matchTextDirection: true,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: fontSizeNumber(0),
                ),
                Textspace(
                  text: "Contest Section",
                  size: 2.5,
                  headsize: 6 - (1 / 3),
                  letterSpacing: false,
                  fontWeight: FontWeight.w300,
                  font: GoogleFonts.workSans,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                SizedBox(
                  width: fontSizeNumber(0),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),
                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      )

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                ),
                SizedBox(
                  width: fontSizeNumber(0 + (1 / 4)),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),

                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                ),
                SizedBox(
                  width: fontSizeNumber(0 + (1 / 4)),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),

                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      )

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                )
              ]),
            ),
            SizedBox(
              height: sqrt(fontSizeNumber(0)),
            ),
            Row(
              children: [
                SizedBox(
                  width: fontSizeNumber(0),
                ),
                Textspace(
                  text: "Popularity Section",
                  size: 2.5,
                  headsize: 6 - (1 / 3),
                  letterSpacing: false,
                  fontWeight: FontWeight.w300,
                  font: GoogleFonts.workSans,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                SizedBox(
                  width: fontSizeNumber(0),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),
                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      )

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                ),
                SizedBox(
                  width: fontSizeNumber(0 + (1 / 4)),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),

                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      )

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                ),
                SizedBox(
                  width: fontSizeNumber(0 + (1 / 4)),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),

                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      )

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                )
              ]),
            ),
            Container(
              height: fontSizeNumber(4),
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border(
                          top: (BorderSide(
                              color: Color(0xFFE2E2E2), width: 1)))),
                ),
                Container(
                  height: fontSizeNumber(2),
                  width: fontSizeNumber(2),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset("Platter/whiteFrame.svg"),
                      Container(
                          constraints: BoxConstraints(
                            maxHeight: fontSizeNumber(2),
                            maxWidth: fontSizeNumber(2),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: sqrt(sqrt(sqrt(fontSizeNumber(0)))),
                                  color: Color(0xFFE2E2E2)))),
                      Container(
                          constraints: BoxConstraints(
                            maxHeight: fontSizeNumber(1),
                            maxWidth: fontSizeNumber(1),
                          ),
                          decoration: BoxDecoration(
                              // color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: sqrt(sqrt(sqrt(fontSizeNumber(0)))),
                                  color: Color(0xFFE2E2E2))))
                    ],
                  ),
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: fontSizeNumber(0 + (1 / 4)),
                  right: fontSizeNumber(0 + (1 / 4))),
              // height: fontSizeNumber(10),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: fontSizeNumber(10)),
                    child: AspectRatio(
                      aspectRatio: pow(1.61803398875, 2).toDouble(),
                      child: Image.network(
                        "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              right: fontSizeNumber(0 + (1 / 4))),
                          constraints: BoxConstraints(
                            maxHeight: fontSizeNumber(4),
                            maxWidth: fontSizeNumber(4),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          )),
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: fontSizeNumber(10)),
                        child: Textspace(
                          text: "Science behind Italian Flour & Bread",
                          size: 0.25,
                          headsize: 6 - (1 / 3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: fontSizeNumber(0 + (1 / 4))),
              // height: fontSizeNumber(10),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: fontSizeNumber(10)),
                    child: AspectRatio(
                      aspectRatio: pow(1.61803398875, 2).toDouble(),
                      child: Image.network(
                        "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              right: fontSizeNumber(0 + (1 / 4))),
                          constraints: BoxConstraints(
                            maxHeight: fontSizeNumber(4),
                            maxWidth: fontSizeNumber(4),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          )),
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: fontSizeNumber(10)),
                        child: Textspace(
                          text: "Science behind Italian Flour & Bread",
                          size: 0.25,
                          headsize: 6 - (1 / 3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                SizedBox(
                  width: fontSizeNumber(0),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),
                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      )

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                ),
                SizedBox(
                  width: fontSizeNumber(0 + (1 / 4)),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),

                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      )

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                ),
                SizedBox(
                  width: fontSizeNumber(0 + (1 / 4)),
                ),
                Container(
                  width: 150,
                  // constraints: BoxConstraints(maxWidth: ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textspace(
                        text: "Amazing Cupcakes",
                        size: 0.25,
                        headsize: 6 - (1 / 3),
                        fontWeight: FontWeight.w500,
                      ),

                      AspectRatio(
                        aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                        child: Image.network(
                          "https://sallysbakingaddiction.com/wp-content/uploads/2016/08/homemade-vanilla-cupcakes-with-vanilla-buttercream.jpg",
                          fit: BoxFit.cover,
                        ),
                      )

                      // Textspace(
                      //     text:
                      //         "This is a good description so we can work later."),
                    ],
                  ),
                )
              ]),
            ),
            Container(
              constraints:
                  BoxConstraints(minHeight: fontSizeNumber(6 + (1 / 2))),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                    margin: EdgeInsets.only(right: fontSizeNumber(0 + (1 / 4))),
                    constraints: BoxConstraints(
                      maxHeight: fontSizeNumber(4),
                      maxWidth: fontSizeNumber(4),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      // shape: BoxShape.circle,
                    )),
                Container(
                  constraints: BoxConstraints(maxWidth: fontSizeNumber(10)),
                  child: Column(children: [
                    Textspace(text: "Advanced Italian Food for Lovers"),
                    Textspace(
                      text: "Alvin",
                      headsize: 0,
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ]),
                )
              ]),
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
      ),
    );
  }
}
