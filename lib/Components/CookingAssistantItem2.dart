import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class CookingAssistantItem2 extends StatefulWidget {
  const CookingAssistantItem2({super.key});

  @override
  State<CookingAssistantItem2> createState() => _CookingAssistantItem2State();
}

class _CookingAssistantItem2State extends State<CookingAssistantItem2>
    with TickerProviderStateMixin {
  bool open = false;
  var _controller = PageController(viewportFraction: 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Color(0xffD7D7D7))),
      constraints: BoxConstraints(minHeight: fontSizeNumber(0) * 4.577742699),
      margin: EdgeInsets.only(top: fontSizeNumber(0) * 0.789265983),
      child: InkWell(
        onTap: () {
          setState(() {
            open = !open;
          });
        },
        child: AnimatedSize(
            vsync: this,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 25),
            child: IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  !open
                      ? Container(
                          margin: EdgeInsets.only(
                              left: fontSizeNumber(0) * 0.789265983,
                              right: fontSizeNumber(0) * 1.34175217,
                              bottom: fontSizeNumber(0) * 0.868192581,
                              top: fontSizeNumber(0) * 0.552486188),
                          color: Color(0xFFCFCFCF),
                          width: fontSizeNumber(0) * 2.999210734,
                          constraints: BoxConstraints(
                              // minHeight: fontSizeNumber(0) * 4.577742699,
                              ),
                          child: Image.asset(
                            "Platter/unnamed.png",
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      : SizedBox(),
                  Flexible(
                      flex: 1,
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: fontSizeNumber(0) * 4.577742699,
                        ),
                        padding: EdgeInsets.only(
                            left: !open ? 0 : fontSizeNumber(0) * 1.894238358,
                            right: !open ? 0 : fontSizeNumber(0) * 1.894238358,
                            bottom: fontSizeNumber(0) * 0.584846093,
                            top: !open ? fontSizeNumber(0) * 0.304262036 : 0),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            open
                                ? Container(
                                    // color: Colors.blue[300],
                                    height: fontSizeNumber(0) * 2.683504341,
                                    child: Transform(
                                      transform: Matrix4.translationValues(
                                          0, 1.341752166, 0),
                                      child: Textspace(
                                        text: "Apple Pie From Scratch",
                                        size: 1.0001,
                                        headsize: 0,
                                        fixSize: true,
                                        fixProportion: 1.5,
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            height: 0),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  )
                                : Textspace(
                                    text: "Apple Pie From Scratch",
                                    size: 1.0001,
                                    headsize: 0,
                                    fixSize: true,
                                    fixProportion: 1.5,
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600, height: 0),
                                  ),
                            !open
                                ? SizedBox(
                                    height: fontSizeNumber(0) * 0.647198106,
                                  )
                                : SizedBox(),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: !open
                                              ? Colors.transparent
                                              : Colors.black))),
                              child: Textspace(
                                  text: open
                                      ? "¼ cup olive oil (60 mL)\n1 large onion, chopped\n3 large carrots, sliced\n4 stalks celery, chopped\nkosher salt, to taste\nblack pepper, to taste"
                                      : "2 ½ lb granny smith apple (1 kg), cored, sliced, peeled",
                                  headsize: 0,
                                  style: TextStyle(height: 1)),
                            ),
                            open
                                ? Container(
                                    // color: Colors.red[300],
                                    child: SizedBox(
                                        height: fontSizeNumber(0) * 7.419100237,
                                        child: Stack(
                                          children: [
                                            Container(
                                              child: PageView(
                                                padEnds: false,
                                                scrollDirection: Axis.vertical,
                                                controller: _controller,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: fontSizeNumber(0) *
                                                            1.262825572),
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Textspace(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.026045777,
                                                        ),
                                                        text:
                                                            "1. Heat the olive oil until shimmering over medium heat in a large soup pot. Add the onion, carrots, celery, and 1 teaspoon each salt and pepper. Cooking, stirring frequently, until the vegetables are very soft, about 15 minutes."),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Textspace(
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.026045777,
                                                        ),
                                                        text:
                                                            "2 - Prepare the tofu and scallions: Cut the tofu into very small cubes, 1/4 inch to 1/2 inch on each side; set aside. Slice the scallions very thinly; set aside."),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Textspace(
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.026045777,
                                                        ),
                                                        text:
                                                            "3 - Prepare the tofu and scallions: Cut the tofu into very small cubes, 1/4 inch to 1/2 inch on each side; set aside. Slice the scallions very thinly; set aside."),
                                                  ),
                                                  Container(
                                                    child: Textspace(
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.026045777,
                                                        ),
                                                        text:
                                                            "- End of the script -"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IgnorePointer(
                                              child: Container(
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ))
                ]))),
      ),
    );
  }
}
