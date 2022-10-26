import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Animatedcontainertest extends StatefulWidget {
  Animatedcontainertest({Key? key}) : super(key: key);

  @override
  _AnimatedcontainertestState createState() => _AnimatedcontainertestState();
}

class _AnimatedcontainertestState extends State<Animatedcontainertest> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                open = !open;
              });
            },
            child: Text("Click me")),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 100),
          firstChild: Text("closed"),
          secondChild: Column(
            children: [Text("Open Open"), Text("Open Open"), Text("Open Open")],
          ),
          crossFadeState:
              open ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        Container(
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xffD7D7D7))),
            constraints:
                BoxConstraints(minHeight: fontSizeNumber(0) * 4.577742699),
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
                        "Platter/unnamed.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minHeight: fontSizeNumber(0) * 4.577742699),
                      padding: EdgeInsets.only(
                          bottom: fontSizeNumber(0) * 0.868192581,
                          top: fontSizeNumber(0) * 0.552486188),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Textspace(
                            text: "Classic Chicken Noodle Soup",
                            size: 1.0001,
                            headsize: 0,
                            fixSize: true,
                            fixProportion: 1.5,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, height: 0),
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
            ))
      ],
    ));
  }
}