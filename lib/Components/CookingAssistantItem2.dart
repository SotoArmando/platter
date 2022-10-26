import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class CookingAssistantItem2 extends StatefulWidget {
  const CookingAssistantItem2({super.key});

  @override
  State<CookingAssistantItem2> createState() => _CookingAssistantItem2State();
}

class _CookingAssistantItem2State extends State<CookingAssistantItem2> {
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
                      bottom: fontSizeNumber(0) * 0.868192581,
                      top: fontSizeNumber(0) * 0.552486188),
                  color: Color(0xFFCFCFCF),
                  width: fontSizeNumber(0) * 2.999210734,
                  constraints: BoxConstraints(
                    minHeight: fontSizeNumber(0) * 4.577742699,
                  ),
                  child: Image.asset(
                    "Platter/unnamed.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: fontSizeNumber(0) * 4.577742699,
                  ),
                  padding: EdgeInsets.only(
                      bottom: fontSizeNumber(0) * 0.868192581,
                      top: fontSizeNumber(0) * 0.552486188),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Textspace(
                        text: "Apple Pie From Scratch",
                        size: 1.0001,
                        headsize: 0,
                        fixSize: true,
                        fixProportion: 1.5,
                        style:
                            TextStyle(fontWeight: FontWeight.w600, height: 0),
                      ),
                      Textspace(
                          text:
                              "2 ½ lb granny smith apple (1 kg),\ncored, sliced, peeled",
                          headsize: 2.75,
                          style: TextStyle(height: 1))
                    ],
                  ),
                )
              ]),
        ));
  }
}
