import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 250),
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
                            bottom: fontSizeNumber(0) * 0.584846093,
                            top: fontSizeNumber(0) * 0.304262036),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Textspace(
                              text: "Apple Pie From Scratch",
                              size: 1.0001,
                              headsize: 0,
                              fixSize: true,
                              fixProportion: 1.5,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, height: 0),
                            ),
                            SizedBox(
                              height: fontSizeNumber(0) * 0.647198106,
                            ),
                            Textspace(
                                text: open
                                    ? "¼ cup olive oil (60 mL)\n1 large onion, chopped\n3 large carrots, sliced\n4 stalks celery, chopped\nkosher salt, to taste\nblack pepper, to taste"
                                    : "4 cups shredded chicken breast",
                                headsize: 0,
                                style: TextStyle(height: 1)),
                            open
                                ? Textspace(
                                    text:
                                        "1. Heat the olive oil until shimmering over medium heat in a large soup pot. Add the onion, carrots, celery, and 1 teaspoon each salt and pepper. Cooking, stirring frequently, until the vegetables are very soft, about 15 minutes.",
                                    headsize: 0,
                                    style: TextStyle(height: 1))
                                : SizedBox()
                          ],
                        ),
                      ))
                ]))),
      ),
    );
  }
}
