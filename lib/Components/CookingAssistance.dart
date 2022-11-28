import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/CookingAssistantItem.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';
import 'package:cancellation_token_http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Cookingassistance extends StatefulWidget {
  Cookingassistance({Key? key}) : super(key: key);

  @override
  _CookingassistanceState createState() => _CookingassistanceState();
}

class _CookingassistanceState extends State<Cookingassistance> {
  bool openLibrary = true;
  Duration seconds = new Duration();

  void toggleLibrary() {
    setState(() {
      openLibrary = !openLibrary;
    });
  }

  void goIn() {
    setState(() {
      openLibrary = false;
    });
  }

  void goLibrary() {
    setState(() {
      openLibrary = true;
    });
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Any'),
            children: <Widget>[
              for (String i in [
                "Breakfast",
                "Dessert",
                "Drinks & Beverages",
                "Lunch",
                "Main Dish",
                "Salad",
                "Sauces, Condiments & Dressings",
                "Side Dish",
                "Snack",
                "Soup",
              ])
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                  child: Text(i),
                ),
            ],
          );
        })) {
      case 0:
        // Let's go.
        // ...
        break;
      case 1:
        // ...
        break;
      case null:
        // dialog dismissed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var saveModel = Provider.of<Savemodel>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [
                    0,
                    .10,
                    .90,
                    1
                  ],
                  colors: [
                    Color.fromARGB(255, 150, 0, 255).withOpacity(0.005),
                    Color.fromARGB(255, 255, 255, 255).withOpacity(0.005),
                    Color.fromRGBO(255, 255, 255, 1).withOpacity(0.005),
                    Color.fromARGB(255, 150, 0, 255).withOpacity(0.005),
                  ]),
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      // color: Colors.pink,
                      padding: EdgeInsets.only(
                        top: fontSizeNumber(0) * 3.866614049,
                      ),
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: fontSizeNumber(7.00000000001),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // SvgPicture.asset(
                                          //   "assets/platter/begin.svg",
                                          //   width: PixelNumberfromFigma(10),
                                          // ),
                                          // SvgPicture.asset(
                                          //   "assets/platter/end.svg",
                                          //   width: PixelNumberfromFigma(7.5),
                                          //   color: Colors.transparent,
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                GradientTextspace(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color(0xFF020608),
                                        Color(0xFF020E1F),
                                      ]),
                                  textspace: Textspace(
                                    text:
                                        "${seconds.inMinutes}:${seconds.inSeconds % 60 > 9 ? "" : "0"}${seconds.inSeconds % 60}",
                                    antiLeftpad: true,
                                    fixSize: true,
                                    size: 7.00000000001,
                                    headsize: 0,
                                    font: GoogleFonts.inter,
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      height: 0.01,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ),
                                SizedBox(
                                  height: fontSizeNumber(7.00000000001),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // SvgPicture.asset(
                                          //   "assets/platter/begin.svg",
                                          //   width: PixelNumberfromFigma(10),
                                          //   color: Colors.transparent,
                                          // ),
                                          // SvgPicture.asset(
                                          //   "assets/platter/end.svg",
                                          //   width: PixelNumberfromFigma(7.5),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
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
                                    onTap: () {
                                      setState(() {
                                        seconds += Duration(seconds: 5);
                                      });
                                    },
                                    child: Container(
                                      // color: Colors.blue[300],
                                      alignment: Alignment.bottomCenter,
                                      width: fontSizeNumber(0) * 6.629834254,
                                      padding: EdgeInsets.only(
                                          bottom: (fontSizeNumber(0) *
                                                  0.536700868) *
                                              0.5),
                                      child: GradientTextspace(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Color(0xFF020608),
                                              Color(0xFF020E1F),
                                            ]),
                                        textspace: Textspace(
                                          text: "5S",
                                          size: 2,
                                          style: GoogleFonts.inter(
                                              color: Colors.black),
                                          headsize: 0.0000001,
                                          alignment: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: fontSizeNumber(2) * 1.756097561,
                                    color: Color(0xffD7D7D7),
                                    constraints: BoxConstraints(minWidth: 1),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        seconds += Duration(seconds: 30);
                                      });
                                    },
                                    child: Container(
                                      // color: Colors.blue[300],
                                      alignment: Alignment.bottomCenter,
                                      width: fontSizeNumber(0) * 6.629834254,
                                      padding: EdgeInsets.only(
                                          bottom: (fontSizeNumber(0) *
                                                  0.536700868) *
                                              0.5),
                                      child: GradientTextspace(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Color(0xFF020608),
                                              Color(0xFF020E1F),
                                            ]),
                                        textspace: Textspace(
                                          text: "30S",
                                          size: 2,
                                          style: GoogleFonts.inter(
                                              color: Colors.black),
                                          headsize: 0.0000001,
                                          alignment: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: fontSizeNumber(2) * 1.756097561,
                                    color: Color(0xffD7D7D7),
                                    constraints: BoxConstraints(minWidth: 1),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        seconds += Duration(minutes: 2);
                                      });
                                    },
                                    child: Container(
                                      // color: Colors.blue[300],
                                      alignment: Alignment.bottomCenter,
                                      width: fontSizeNumber(0) * 6.629834254,
                                      padding: EdgeInsets.only(
                                          bottom: (fontSizeNumber(0) *
                                                  0.536700868) *
                                              0.5),
                                      child: GradientTextspace(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Color(0xFF020608),
                                              Color(0xFF020E1F),
                                            ]),
                                        textspace: Textspace(
                                          text: "2M",
                                          size: 2,
                                          style: GoogleFonts.inter(
                                              color: Colors.black),
                                          headsize: 0.0000001,
                                          alignment: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: PixelNumberfromFigma(8),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xffD7D7D7)))),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            goLibrary();
                          },
                          onLongPress: () {
                            _askedToLead();
                          },
                          child: GradientTextspace(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: openLibrary
                                    ? [
                                        Color(0xFF020608),
                                        Color(0xFF020E1F),
                                      ]
                                    : [
                                        Color.fromARGB(255, 214, 212, 212),
                                        Color(0xFFD7D7D7),
                                      ]),
                            textspace: Textspace(
                              text: "My Library",
                              size: 1.0001,
                              alignment: Alignment.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )),
                        Container(
                          height: fontSizeNumber(0) * 2.2332506203473943,
                          color: Color(0xFFD7D7D7),
                          constraints: BoxConstraints(minWidth: 1),
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            goIn();
                          },
                          child: GradientTextspace(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: !openLibrary
                                    ? [
                                        Color(0xFF020608),
                                        Color(0xFF020E1F),
                                      ]
                                    : [
                                        Color.fromARGB(255, 214, 212, 212),
                                        Color(0xFFD7D7D7),
                                      ]),
                            textspace: Textspace(
                              text: "In",
                              size: 1.0001,
                              style: TextStyle(color: Colors.black),
                              alignment: Alignment.center,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                openLibrary
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: fontSizeNumber(0) * 0.947119179,
                            right: fontSizeNumber(0) * 0.947119179),
                        child: FutureBuilder<http.Response>(
                          future: RestClient().getUserFavorites(
                              saveModel.authToken.last,
                              saveModel.authSecret.last),
                          builder: (context, snap) {
                            if (snap.connectionState == ConnectionState.done) {
                              var body = jsonDecode(snap.data!.body);
                              print("body");
                              print(body);
                              print(saveModel.authToken.last);
                              print("snap.data!");
                              print(snap.data!);
                              var recipes = body["recipes"]?["recipe"] ?? [];
                              if (recipes is List<dynamic>) {
                                return Column(
                                  children: [
                                    for (var i in recipes)
                                      CookingAssistantItem(
                                        data: {
                                          "name": i["recipe_name"],
                                          "description":
                                              i["recipe_description"],
                                          "thumbnail_url": i["recipe_image"],
                                          "id": i["recipe_id"],

                                          // "4 directions 1 servings 10 mins prep"
                                        },
                                      ),
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: PixelNumberfromFigma(15),
                                            top: PixelNumberfromFigma(7.5),
                                            bottom: PixelNumberfromFigma(7.5),
                                            right: PixelNumberfromFigma(15)),
                                        child: Row(
                                          children: [
                                            InkWell(
                                                child: Text(
                                                    "Powered by FatSecret"),
                                                onTap: () async {
                                                  if (await canLaunchUrl(Uri.parse(
                                                      "https://platform.fatsecret.com")))
                                                    await launchUrl(
                                                        Uri.parse(
                                                            "https://platform.fatsecret.com"),
                                                        mode: LaunchMode
                                                            .externalApplication);
                                                  else
                                                    // can't launch url, there is some error
                                                    throw "Could not launch https: //platform.fatsecret.com";
                                                })
                                          ],
                                        ))
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  CookingAssistantItem(
                                    data: {
                                      "name": recipes["recipe_name"],
                                      "description":
                                          recipes["recipe_description"],
                                      "thumbnail_url": recipes["recipe_image"],
                                      "id": recipes["recipe_id"],

                                      // "4 directions 1 servings 10 mins prep"
                                    },
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: PixelNumberfromFigma(15),
                                          top: PixelNumberfromFigma(7.5),
                                          bottom: PixelNumberfromFigma(7.5),
                                          right: PixelNumberfromFigma(15)),
                                      child: Row(
                                        children: [
                                          InkWell(
                                              child:
                                                  Text("Powered by FatSecret"),
                                              onTap: () async {
                                                if (await canLaunchUrl(Uri.parse(
                                                    "https://platform.fatsecret.com")))
                                                  await launchUrl(
                                                      Uri.parse(
                                                          "https://platform.fatsecret.com"),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                else
                                                  // can't launch url, there is some error
                                                  throw "Could not launch https: //platform.fatsecret.com";
                                              })
                                        ],
                                      ))
                                ],
                              );
                            }
                            return Text("loading");
                          },
                        ))
                    : Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: fontSizeNumber(0) * 0.947119179,
                                  right: fontSizeNumber(0) * 0.947119179),
                              child: Consumer<Savemodel>(
                                builder: (context, savemodel, widget) {
                                  return (Column(
                                    children: [
                                      for (var i in savemodel.focus)
                                        CookingAssistantItem(
                                          data: {
                                            "id": i,
                                            // "4 directions 1 servings 10 mins prep"
                                          },
                                        ),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: PixelNumberfromFigma(15),
                                              top: PixelNumberfromFigma(7.5),
                                              bottom: PixelNumberfromFigma(7.5),
                                              right: PixelNumberfromFigma(15)),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                  child: Text(
                                                      "Powered by FatSecret"),
                                                  onTap: () async {
                                                    if (await canLaunchUrl(
                                                        Uri.parse(
                                                            "https://platform.fatsecret.com")))
                                                      await launchUrl(
                                                          Uri.parse(
                                                              "https://platform.fatsecret.com"),
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    else
                                                      // can't launch url, there is some error
                                                      throw "Could not launch https: //platform.fatsecret.com";
                                                  })
                                            ],
                                          ))
                                    ],
                                  ));
                                },
                              )),

                          // SizedBox(
                          //   height: PixelNumberfromFigma(38),
                          //   child: Container(
                          //     padding: EdgeInsets.only(
                          //         left: PixelNumberfromFigma(15),
                          //         right: PixelNumberfromFigma(15)),
                          //     // decoration: BoxDecoration(
                          //     //     // color: Colors.blue,
                          //     //     border: Border(
                          //     //         top: BorderSide(
                          //     //             width: PixelNumberfromFigma(1),
                          //     //             color: Color(0xFFEDEDED)))),
                          //     child: Textspace(
                          //       text: "Recent",
                          //       style: GoogleFonts.inter(
                          //           fontWeight: FontWeight.w700, color: Colors.black),
                          //       size: 2,
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
              ],
            )),
          ),
          Positioned(
              left: PixelNumberfromFigma(0),
              top: PixelNumberfromFigma(0),
              right: 0,
              child: Container(
                height: PixelNumberfromFigma(15 + 7.5 + 12.64),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            color: Color(0xFFF5F6F8),
                            width: PixelNumberfromFigma(1)))),
                padding: EdgeInsets.only(
                    left: PixelNumberfromFigma(15),
                    right: PixelNumberfromFigma(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: GradientTextspace(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0,
                              1
                            ],
                            colors: [
                              Color.fromARGB(255, 10, 0, 6),
                              Color.fromARGB(255, 15, 0, 9),
                            ]),
                        textspace: SvgPicture.asset(
                          "assets/platter/stop.svg",
                          color: Colors.black,
                          height: fontSizeNumber(0) * 0.9,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: PixelNumberfromFigma(24),
                    ),
                    InkWell(
                      child: GradientTextspace(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0,
                              1
                            ],
                            colors: [
                              Color.fromARGB(255, 10, 0, 6),
                              Color.fromARGB(255, 15, 0, 9),
                            ]),
                        textspace: SvgPicture.asset(
                          "assets/platter/play.svg",
                          color: Colors.black,
                          height: fontSizeNumber(0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: PixelNumberfromFigma(24),
                    ),
                    InkWell(
                      onTap: () {},
                      child: GradientTextspace(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0,
                              1
                            ],
                            colors: [
                              Color.fromARGB(255, 10, 0, 6),
                              Color.fromARGB(255, 15, 0, 9),
                            ]),
                        textspace: SvgPicture.asset(
                          "assets/platter/pause.svg",
                          color: Colors.black,
                          height: fontSizeNumber(0) * 0.9,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ]));
  }
}
