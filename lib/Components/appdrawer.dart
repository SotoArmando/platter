import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class Appdrawer extends StatefulWidget {
  Appdrawer({Key? key}) : super(key: key);

  @override
  _AppdrawerState createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Container(
        child: Column(children: [
          SizedBox(
            height: height,
          ),
          Padding(
            padding: EdgeInsets.only(left: PixelNumberfromFigma(15)),
            child: SizedBox(
              height: PixelNumberfromFigma(118),
              child: Column(
                children: [
                  for (var i in [1, 2])
                    Expanded(
                        child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Textspace(
                              headsize: 0.00001,
                              text: "Great news: new feature",
                            ),
                            Textspace(
                              headsize: 0.00001,
                              text: "Great news: new devblog",
                            ),
                          ]),
                    )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: PixelNumberfromFigma(16),
          ),
          Container(
            child: SizedBox(
              height: PixelNumberfromFigma(106 + 23 + 30),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                SizedBox(
                  width: PixelNumberfromFigma(15),
                ),
                for (var i in [1, 2, 3, 4])
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: fontSizeNumber(0) * 7.717285714,
                        child: Column(
                          children: [
                            Textspace(
                              text: "recipe_name",
                            ),
                            AspectRatio(
                              aspectRatio: 83 / 91,
                              child: Container(color: Colors.grey[200]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: PixelNumberfromFigma(15),
                      )
                    ],
                  )
              ]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: PixelNumberfromFigma(15)),
            alignment: Alignment.centerLeft,
            height: PixelNumberfromFigma(56),
            child: Text("About"),
          ),
          Container(
            padding: EdgeInsets.only(left: PixelNumberfromFigma(15)),
            alignment: Alignment.centerLeft,
            height: PixelNumberfromFigma(56),
            child: Text("Credits"),
          ),
        ]),
      ),
    );
  }
}

//  SizedBox(
//           height: PixelNumberfromFigma(118),
//           child: Column(children: [
//             for (var i in [1, 2])
//               Expanded(
//                   child: Container(
//                 child: Column(children: [
//                   Textspace(
//                     text: "Great news: new feature",
//                   ),
//                   Textspace(
//                     text: "Great news: new devblog",
//                   ),
//                 ]),
//               )),
//             SizedBox(
//               height: PixelNumberfromFigma(16),
//             ),
//             SizedBox(
//               height: PixelNumberfromFigma(106 + 23),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       for (var i in [1, 2, 3, 4])
//                         Column(
//                           children: [
//                             Textspace(
//                               text: "recipe_name",
//                             ),
//                             AspectRatio(
//                               aspectRatio: 83 / 91,
//                               child: Container(color: Colors.red),
//                             )
//                           ],
//                         )
//                     ]),
//               ),
//             )
//           ]),
//         )
