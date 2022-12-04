import 'dart:async';
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
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
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
  Duration seconds = Duration.zero;
  Widget? openlibraryitems;
  Widget? openinitems;
  final ignore = const SizedBox();
  late Requestor requestor = Provider.of<Requestor>(context, listen: false);
  Future<http.Response>? response;
  late Savemodel providedSavemodel =
      Provider.of<Savemodel>(context, listen: true);
  final _searchInputController = TextEditingController();
  final focusNode = FocusNode();
  final ScrollController _controller = ScrollController();
  bool doesSearch = false;
  String textQuery = "";
  late Widget textField = TextField(
    focusNode: focusNode,
    // cursorHeight: 0,
    textAlignVertical: TextAlignVertical.bottom,
    onChanged: (value) {
      setState(() {
        textQuery = value;
        launchwidgets();
      });
    },
    controller: _searchInputController,
    maxLines: 1,
    minLines: null,
    style: GoogleFonts.inter(fontSize: fontSizeNumber(0)),
    expands: false,
    decoration: InputDecoration(
        isCollapsed: false,
        isDense: true,
        contentPadding: EdgeInsets.only(
            bottom: pixelNumberfromFigma(3),
            top: 0,
            left: pixelNumberfromFigma(6)),
        border: InputBorder.none,
        hintText: 'To filter types of recipes. Long press *My Library',
        hintStyle:
            TextStyle(color: Color(0xFF3C3C3C), fontSize: fontSizeNumber(0))),
  );
  Timer? _passtime;
  void stopanysecond() {
    setState(() {
      _passtime?.cancel();
      seconds = Duration.zero;
    });
  }

  void passanySecond() async {
    _passtime?.cancel();
    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timer.isActive && seconds.inSeconds > 0) {
          seconds -= const Duration(seconds: 1);
        }

        if (seconds.inSeconds == 0 || seconds.inSeconds < 0) {
          timer.cancel();
        }
      });
    });
    setState(() {
      _passtime = timer;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void toggleLibrary() {
    setState(() {
      openLibrary = !openLibrary;
    });
  }

  void goIn() {
    launchwidgets();
    setState(() {
      openLibrary = false;
    });
  }

  void goLibrary() {
    launchwidgets();
    setState(() {
      openLibrary = true;
    });
  }

  void hideclock() {
    _controller
        .animateTo(
            //here specifing position= 100 mean 100px
            pixelNumberfromFigma(167),
            curve: Curves.easeOutCirc,
            duration: const Duration(milliseconds: 150))
        .whenComplete(() {
      setState(() {
        doesSearch = true;
        focusNode.requestFocus();
      });
    });
  }

  void launchwidgets() {
    openlibraryitems = Padding(
        padding: EdgeInsets.only(
            left: fontSizeNumber(0) * 0.947119179,
            right: fontSizeNumber(0) * 0.947119179),
        child: FutureBuilder<http.Response>(
          future: requestor.loadingrequests["favorite"]![
              requestor.loadingrequests["favorite"]!.keys.last],
          initialData: requestor.requestResponses["favorite"]![
              requestor.requestResponses["favorite"]!.keys.last],
          builder: (context, snap) {
            List<Widget> children = [];
            if (snap.hasData) {
              if (snap.data!.body.contains("recipes") &&
                  !snap.data!.body.contains("error")) {
                var body = jsonDecode(snap.data!.body);
                // print("body");
                // print(body);

                // print("snap.data!");
                // print(snap.data!);
                var recipes = body["recipes"]?["recipe"] ?? [];
                if (recipes is List<dynamic>) {
                  recipes.sort((a, b) => providedSavemodel.likes
                      .indexOf(a["recipe_id"])
                      .compareTo(
                          providedSavemodel.likes.indexOf(b["recipe_id"])));
                } else {
                  recipes = [recipes] as List<dynamic>;
                }
                children = [
                  Column(
                    children: [
                      for (var i in [
                        ...recipes.where((e) =>
                            providedSavemodel.likes.contains(e["recipe_id"])),
                        ...providedSavemodel.likes
                            .where(
                                (element) => !snap.data!.body.contains(element))
                            .map((e) => {"recipe_id": e})
                      ].reversed)
                        CookingAssistantItem(
                          data: {
                            "name": i["recipe_name"],
                            "description": i["recipe_description"],
                            "thumbnail_url": i["recipe_image"],
                            "id": i["recipe_id"],
                            "query": textQuery

                            // "4 directions 1 servings 10 mins prep"
                          },
                        ),
                      Container(
                          padding: EdgeInsets.only(
                              left: pixelNumberfromFigma(15),
                              top: pixelNumberfromFigma(7.5),
                              bottom: pixelNumberfromFigma(7.5),
                              right: pixelNumberfromFigma(15)),
                          child: Row(
                            children: [
                              InkWell(
                                  child: const Text("Powered by FatSecret"),
                                  onTap: () async {
                                    if (await canLaunchUrl(Uri.parse(
                                        "https://platform.fatsecret.com")))
                                      await launchUrl(
                                          Uri.parse(
                                              "https://platform.fatsecret.com"),
                                          mode: LaunchMode.externalApplication);
                                    else
                                      // can't launch url, there is some error
                                      throw "Could not launch https: //platform.fatsecret.com";
                                  })
                            ],
                          ))
                    ],
                  )
                ];
              }
            }

            try {
              return (snap.connectionState == ConnectionState.done ||
                      (snap.hasData &&
                          "${jsonDecode(snap.data!.body)["error"]}" == "null"))
                  ? Column(
                      children: children,
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: CircularProgressIndicator(),
                    );
            } catch (e) {
              return const Padding(
                padding: EdgeInsets.only(top: 15),
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
    openinitems = Column(
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: fontSizeNumber(0) * 0.947119179,
                right: fontSizeNumber(0) * 0.947119179),
            child: Column(
              children: [
                for (var i in providedSavemodel.focus.reversed)
                  CookingAssistantItem(
                    data: {
                      "id": i,
                      "query": textQuery
                      // "4 directions 1 servings 10 mins prep"
                    },
                  ),
                Container(
                    padding: EdgeInsets.only(
                        left: pixelNumberfromFigma(15),
                        top: pixelNumberfromFigma(7.5),
                        bottom: pixelNumberfromFigma(7.5),
                        right: pixelNumberfromFigma(15)),
                    child: Row(
                      children: [
                        InkWell(
                            child: Text("Powered by FatSecret"),
                            onTap: () async {
                              if (await canLaunchUrl(
                                  Uri.parse("https://platform.fatsecret.com")))
                                await launchUrl(
                                    Uri.parse("https://platform.fatsecret.com"),
                                    mode: LaunchMode.externalApplication);
                              else
                                // can't launch url, there is some error
                                throw "Could not launch https: //platform.fatsecret.com";
                            })
                      ],
                    ))
              ],
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
    );
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Types'),
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
    if (openlibraryitems == null && openinitems == null) {
      launchwidgets();
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            child: SingleChildScrollView(
                controller: _controller,
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
                                    child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                                            width:
                                                fontSizeNumber(0) * 6.629834254,
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
                                                alignment:
                                                    Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:
                                              fontSizeNumber(2) * 1.756097561,
                                          color: Color(0xffD7D7D7),
                                          constraints:
                                              BoxConstraints(minWidth: 1),
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
                                            width:
                                                fontSizeNumber(0) * 6.629834254,
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
                                                alignment:
                                                    Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:
                                              fontSizeNumber(2) * 1.756097561,
                                          color: Color(0xffD7D7D7),
                                          constraints:
                                              BoxConstraints(minWidth: 1),
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
                                            width:
                                                fontSizeNumber(0) * 6.629834254,
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
                                                alignment:
                                                    Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned.fill(
                                        child: IgnorePointer(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              stops: const [
                                                0,
                                                .10,
                                                .50,
                                                .90,
                                                1
                                              ],
                                              colors: [
                                                const Color.fromARGB(
                                                        255, 255, 0, 150)
                                                    .withOpacity(0.005),
                                                const Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    .withOpacity(0.000),
                                                const Color.fromARGB(
                                                        255, 255, 0, 150)
                                                    .withOpacity(0.005),
                                                const Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    .withOpacity(0.000),
                                                const Color.fromARGB(
                                                        255, 255, 0, 150)
                                                    .withOpacity(0.005),
                                                // Color.fromARGB(255, 162, 0, 255).withOpacity(0.005),
                                                // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                                                // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                                                // Color.fromARGB(255, 140, 0, 255).withOpacity(0.005),
                                              ]),
                                        ),
                                      ),
                                    )),
                                  ],
                                )),
                              ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: pixelNumberfromFigma(8),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Color(0xffD7D7D7)))),
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
                                textspace: const Textspace(
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
                                            const Color(0xFF020608),
                                            const Color(0xFF020E1F),
                                          ]
                                        : [
                                            const Color.fromARGB(
                                                255, 214, 212, 212),
                                            const Color(0xFFD7D7D7),
                                          ]),
                                textspace: const Textspace(
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
                        ? openlibraryitems ?? ignore
                        : openinitems ?? ignore
                  ],
                )),
          ),
          Positioned(
            left: pixelNumberfromFigma(0),
            top: pixelNumberfromFigma(0),
            right: 0,
            child: Container(
              height: pixelNumberfromFigma(15 + 7.5 + 12.64),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xFFF5F6F8),
                          width: pixelNumberfromFigma(1)))),
              padding: EdgeInsets.only(
                  left: pixelNumberfromFigma(5),
                  right: pixelNumberfromFigma(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            hideclock();
                          },
                          child: Container(
                            width: pixelNumberfromFigma(30),
                            alignment: Alignment.center,
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
                                "assets/platter/search.svg",
                                color: Colors.black,
                                height:
                                    fontSizeNumber(0) + pixelNumberfromFigma(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: pixelNumberfromFigma(24 - 15),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            if (seconds.inSeconds > 0) {
                              passanySecond();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: pixelNumberfromFigma(30),
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
                              textspace: _passtime?.isActive ?? false
                                  ? ignore
                                  : SvgPicture.asset(
                                      "assets/platter/play.svg",
                                      color: Colors.black,
                                      height: fontSizeNumber(0),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: pixelNumberfromFigma(25 - 15),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                seconds = Duration.zero;
                                _passtime?.cancel();
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
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
                            )),
                      ),
                      SizedBox(
                        width: pixelNumberfromFigma(22),
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _passtime?.cancel();
                              _passtime = null;
                            });
                          },
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
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: pixelNumberfromFigma(0),
              top: pixelNumberfromFigma(0),
              right: 0,
              child: IgnorePointer(
                child: Container(
                  height: pixelNumberfromFigma(15 + 7.5 + 12.64),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: const [
                          0,
                          .10,
                          .50,
                          .90,
                          1
                        ],
                        colors: [
                          const Color.fromARGB(255, 255, 0, 150)
                              .withOpacity(0.005),
                          const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.000),
                          const Color.fromARGB(255, 255, 0, 150)
                              .withOpacity(0.005),
                          const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.000),
                          const Color.fromARGB(255, 255, 0, 150)
                              .withOpacity(0.005),
                          // Color.fromARGB(255, 162, 0, 255).withOpacity(0.005),
                          // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                          // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                          // Color.fromARGB(255, 140, 0, 255).withOpacity(0.005),
                        ]),
                  ),
                ),
              )),
          doesSearch
              ? Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AspectRatio(
                      aspectRatio: 320 / 29,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFFF5F6F8),
                                    width: pixelNumberfromFigma(1)))),
                        padding:
                            EdgeInsets.only(left: pixelNumberfromFigma(15)),
                        alignment: Alignment.center,
                        child: Row(children: [
                          Expanded(
                              child: Stack(
                            children: [
                              SizedBox(
                                height: pixelNumberfromFigma(20),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          pixelNumberfromFigma(3)),
                                      color: Color(0xFFF9FAFB),
                                      border: Border.all(
                                          color: Color(0xFFF5F6F8),
                                          width: pixelNumberfromFigma(1))),
                                  child: textField,
                                ),
                              ),
                              textQuery.isNotEmpty
                                  ? Positioned(
                                      top: 0,
                                      bottom: 0,
                                      right: pixelNumberfromFigma(12),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            textQuery = "";
                                            _searchInputController.clear();
                                            launchwidgets();
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          "assets/platter/close.svg",
                                          height: pixelNumberfromFigma(12),
                                        ),
                                      ))
                                  : SizedBox(),
                            ],
                          )),
                          InkWell(
                            onTap: () {
                              _controller
                                  .animateTo(
                                      //here specifing position= 100 mean 100px
                                      pixelNumberfromFigma(0),
                                      curve: Curves.easeOutCirc,
                                      duration:
                                          const Duration(milliseconds: 150))
                                  .then((value) {
                                setState(() {
                                  doesSearch = !doesSearch;
                                  // focusNode.requestFocus();
                                });
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: pixelNumberfromFigma(7.25),
                                  right: pixelNumberfromFigma(11.25)),
                              child: Textspace(
                                text: "Cancel",
                                style:
                                    GoogleFonts.inter(color: Color(0xFF3C3C3C)),
                              ),
                            ),
                          )
                        ]),
                      )),
                )
              : ignore,
          Positioned.fill(
              child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [
                      0,
                      .25,
                      .75,
                      1
                    ],
                    colors: [
                      Color.fromARGB(255, 150, 0, 255).withOpacity(0.005),
                      Color.fromARGB(255, 255, 255, 255).withOpacity(0.005),
                      Color.fromRGBO(255, 255, 255, 1).withOpacity(0.005),
                      Color.fromARGB(255, 255, 0, 255).withOpacity(0.005),
                    ]),
              ),
            ),
          ))
        ]));
  }
}
