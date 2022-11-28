import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/CookingAssistantItem.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Searchitem.dart';
import 'package:p_l_atter/Components/Searchitemplaceholder.dart';
import 'package:p_l_atter/Components/Searchresultitem.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Preferencesmodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/GraphQl/tell.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'dart:ui' as ui;
// import 'package:http/http.dart' as http;
import 'package:cancellation_token_http/http.dart' as http;
import 'package:provider/provider.dart';

class Searchscreen extends StatefulWidget {
  Searchscreen({Key? key}) : super(key: key);

  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  Future<ui.Image> getUiImage(String imageAssetPath) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
        assetImageByteData.buffer.asUint8List(),
        allowUpscaling: true);
    var image = (await codec.getNextFrame()).image;

    // image.r = 100;
    return image;
  }

  var token = http.CancellationToken();
  bool doesSearch = false;
  String textQuery = "";

  Future<http.Response> fetchRecipesQuery(String query) {
    try {
      if (token.hasCancellables) {
        token.cancel();
      }
    } catch (e) {}

    token = http.CancellationToken();
    return RestClient()
        .recipesSearch(_nameInputcontroller.text, canceltoken: token);
  }

  var focusNode = FocusNode();
  final _nameInputcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget textField = TextField(
      focusNode: focusNode,
      // cursorHeight: 0,
      textAlignVertical: TextAlignVertical.bottom,
      onChanged: (value) {
        setState(() {
          textQuery = value;
        });
      },
      controller: _nameInputcontroller,
      maxLines: null,
      minLines: null,
      style: GoogleFonts.inter(fontSize: fontSizeNumber(0)),
      expands: true,
      decoration: InputDecoration(
          isCollapsed: false,
          isDense: true,
          contentPadding: EdgeInsets.only(
              bottom: PixelNumberfromFigma(3),
              top: 0,
              left: PixelNumberfromFigma(6)),
          border: InputBorder.none,
          hintText: 'What do you want to cook?',
          hintStyle:
              TextStyle(color: Color(0xFF3C3C3C), fontSize: fontSizeNumber(0))),
    );
    Widget prevScreen = Column(mainAxisSize: MainAxisSize.max, children: [
      Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
              height: PixelNumberfromFigma(162.71),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    scale: 1.5 / 1.05,
                    alignment: Alignment.topLeft,
                    repeat: ImageRepeat.repeat,
                    image: ExactAssetImage("assets/platter/pattern.png"),
                    fit: BoxFit.none),
                color: Colors.white,
              ),
              child: Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(
                    PixelNumberfromFigma(20.6),
                  ),
                ),
                width: PixelNumberfromFigma(233),
                height: PixelNumberfromFigma(33.17),
                padding: EdgeInsets.only(left: PixelNumberfromFigma(15)),
              )),
          // Positioned.fill(
          //     child: IgnorePointer(
          //   child: Image.asset(
          //     "assets/platter/patternpic.png",
          //     fit: BoxFit.fitWidth,
          //   ),
          // )),
          Container(
              height: PixelNumberfromFigma(162.71),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    PixelNumberfromFigma(20.6),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                        offset: new Offset(1.0, 1.0))
                  ],
                ),
                alignment: Alignment.topCenter,
                width: PixelNumberfromFigma(233),
                height: PixelNumberfromFigma(33.17),
                padding: EdgeInsets.only(left: PixelNumberfromFigma(15)),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        doesSearch = !doesSearch;
                        focusNode.requestFocus();
                      });
                    },
                    child: IgnorePointer(
                        child: TextField(
                      // onChanged: (string) {},
                      // cursorHeight: 0,
                      textAlignVertical: TextAlignVertical.bottom,
                      maxLines: null,
                      minLines: null,
                      style: GoogleFonts.inter(fontSize: fontSizeNumber(0)),
                      expands: true,
                      decoration: InputDecoration(
                          isCollapsed: false,
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              bottom: PixelNumberfromFigma(9.17), top: 0),
                          border: InputBorder.none,
                          hintText: 'What do you want to cook?',
                          hintStyle: TextStyle(
                              color: Color(0xFF3C3C3C),
                              fontSize: fontSizeNumber(0))),
                    ))),
              )),
        ],
      ),
      Container(
        // color: Color(0xffF9EFE3),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: PixelNumberfromFigma(15), vertical: 0),
          child: Column(children: [
            SizedBox(
              height: PixelNumberfromFigma(24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        GradientTextspace(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(255, 2, 6, 8),
                                Color.fromARGB(255, 2, 14, 31),
                              ]),
                          textspace: Textspace(
                            text: "Browse all",
                            size: 1,
                            headsize: 0.0001,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = PixelNumberfromFigma(0.2)
                                ..color = Colors.black,
                            ),
                          ),
                        ),
                        GradientTextspace(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(255, 2, 6, 8),
                                Color.fromARGB(255, 2, 14, 31),
                              ]),
                          textspace: Textspace(
                            text: "Browse all",
                            size: 1,
                            headsize: 0.0001,
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    // Stack(
                    //   children: [
                    //     Textspace(
                    //       text: "Long tap here for more",
                    //       size: 0,
                    //       headsize: 0.0001,
                    //       style: GoogleFonts.inter(
                    //         foreground: Paint()
                    //           ..style = PaintingStyle.stroke
                    //           ..strokeWidth = PixelNumberfromFigma(0.2)
                    //           ..color = Color(0xFF3C3C3C),
                    //       ),
                    //     ),
                    //     Textspace(
                    //       text: "Long tap here for more",
                    //       size: 0,
                    //       headsize: 0.0001,
                    //       style: GoogleFonts.inter(color: Color(0xFF3C3C3C)),
                    //     )
                    //   ],
                    // ),
                  ]),
            ),
            SizedBox(
              height: PixelNumberfromFigma(5),
            ),
            // for (var i in [
            //   ["Appetizer", "Soup"],
            //   ["Main Dish", "Side Dish"],
            //   ["Baked", "Salad and Salad Dressing"],
            //   ["Sauce and Condiment", "Dessert"],
            //   ["Snack", "Beverage"],
            //   ["Other", "Breakfast"],
            //   ["Lunch", ""]
            // ])
            //   Column(
            //     children: [
            //       Row(
            //         children: [
            //           Expanded(
            //               child: InkWell(
            //             onTap: () {
            //               preferencesModel.update(i[0]);
            //               Navigator.pushNamed(context, "/category");
            //             },
            //             child: Flexible(
            //                 child: Padding(
            //               padding: EdgeInsets.only(
            //                 right: PixelNumberfromFigma(15),
            //               ),
            //               child: Textspace(
            //                 text: i[0],
            //                 headsize: 0.0001,
            //                 height: PixelNumberfromFigma(54),
            //                 alignment: Alignment.bottomLeft,
            //                 size: 1,
            //                 style:
            //                     GoogleFonts.inter(fontWeight: FontWeight.w700),
            //               ),
            //             )),
            //           )),
            //           Expanded(
            //               child: InkWell(
            //             onTap: () {
            //               preferencesModel.update(i[1]);
            //               Navigator.pushNamed(context, "/category");
            //             },
            //             child: Flexible(
            //                 child: Padding(
            //               padding: EdgeInsets.only(
            //                 right: PixelNumberfromFigma(15),
            //               ),
            //               child: Textspace(
            //                 text: i[1],
            //                 headsize: 0.0001,
            //                 height: PixelNumberfromFigma(54),
            //                 size: 1,
            //                 alignment: Alignment.bottomLeft,
            //                 style:
            //                     GoogleFonts.inter(fontWeight: FontWeight.w700),
            //               ),
            //             )),
            //           ))
            //         ],
            //       ),
            //       SizedBox(
            //         height: 15,
            //       )
            //     ],
            //   )
            Container(
              child: Stack(
                // clipBehavior: Clip.hardEdge,
                children: [
                  Column(children: [
                    for (var i in [
                      ["Appetizer", "Soup"],
                      ["Side Dish", "Snack"],
                      ["Baked", "Salad and Salad Dressing"],
                      ["Beverage", "Lunch"],
                      ["Sauce and Condiment", "Dessert"],
                      ["Main Dish", "Breakfast"],
                    ])
                      Column(
                        children: [
                          Row(
                            children: [
                              Searchitem(
                                mycolor: Color(0xFFFFA210),
                                title: i[0],
                              ),
                              SizedBox(
                                width: PixelNumberfromFigma(8),
                              ),
                              Searchitem(
                                mycolor: Color(0xFFFFA210),
                                title: i[1],
                              ),
                            ],
                          ),
                        ],
                      ),
                  ]),
                  IgnorePointer(
                    child: Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: FutureBuilder<ui.Image>(
                        future: getUiImage("assets/platter/pattern1.png"),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? Container(
                                  // flex: 1,
                                  // color: Colors.blue,
                                  // height: double.infinity,
                                  // clipBehavior: Clip.hardEdge,
                                  child: ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (bounds) => ImageShader(
                                        snapshot.data!,
                                        TileMode.repeated,
                                        TileMode.repeated,
                                        Matrix4.identity()
                                            .scaled(0.65 * 1.05)
                                            .storage,
                                        filterQuality: FilterQuality.high),
                                    child: Column(children: [
                                      for (var i in [1, 2, 3, 4, 5, 6])
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Searchitemplaceholder(),
                                                SizedBox(
                                                  width:
                                                      PixelNumberfromFigma(8),
                                                ),
                                                Searchitemplaceholder(),
                                              ],
                                            ),
                                          ],
                                        )
                                    ]),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                      top: PixelNumberfromFigma(10)),
                                  child: Text("no data"),
                                );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    ]);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: doesSearch ? Colors.white.withOpacity(0.85) : Colors.white,
            image: doesSearch
                ? DecorationImage(
                    image: ExactAssetImage("assets/platter/Asistant.png"),
                    fit: BoxFit.cover)
                : null),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SingleChildScrollView(
                    child: Container(
                        child: doesSearch
                            ? Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 320 / 29,
                                    child: Container(
                                      child: Text(""),
                                      // color: Colors.red,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: PixelNumberfromFigma(15),
                                          right: PixelNumberfromFigma(15)),
                                      child: FutureBuilder<http.Response>(
                                        builder: (context, responseSnapshot) {
                                          if (responseSnapshot
                                                  .connectionState ==
                                              ConnectionState.done) {
                                            dynamic data = [];

                                            try {
                                              data = jsonDecode(responseSnapshot
                                                      .data?.body ??
                                                  "{}")["recipes"]["recipe"];
                                            } catch (e) {}

                                            final children = [
                                              SizedBox(
                                                height: PixelNumberfromFigma(9),
                                                child: Container(
                                                    color: Colors.transparent),
                                              ),
                                              for (dynamic item in data)
                                                SearchResultItem(
                                                  data: item,
                                                ),
                                            ];
                                            try {
                                              return responseSnapshot.hasData
                                                  ? Column(
                                                      children:
                                                          children.length > 0
                                                              ? children
                                                              : [
                                                                  Textspace(
                                                                    text:
                                                                        "This is empty... No Results :L",
                                                                  )
                                                                ],
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 15),
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                            } catch (e) {
                                              return Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          } else {
                                            return Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                        future: fetchRecipesQuery(textQuery),
                                      ))
                                ],
                              )
                            : prevScreen)),
                doesSearch
                    ? AspectRatio(
                        aspectRatio: 320 / 29,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xFFF5F6F8),
                                      width: PixelNumberfromFigma(1)))),
                          padding:
                              EdgeInsets.only(left: PixelNumberfromFigma(15)),
                          alignment: Alignment.center,
                          child: Row(children: [
                            Expanded(
                                child: Stack(
                              children: [
                                SizedBox(
                                  height: PixelNumberfromFigma(20),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            PixelNumberfromFigma(3)),
                                        color: Color(0xFFF9FAFB),
                                        border: Border.all(
                                            color: Color(0xFFF5F6F8),
                                            width: PixelNumberfromFigma(1))),
                                    child: textField,
                                  ),
                                ),
                                _nameInputcontroller.text.isNotEmpty
                                    ? Positioned(
                                        top: 0,
                                        bottom: 0,
                                        right: PixelNumberfromFigma(12),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _nameInputcontroller.clear();
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            "assets/platter/close.svg",
                                            height: PixelNumberfromFigma(12),
                                          ),
                                        ))
                                    : SizedBox(),
                              ],
                            )),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  doesSearch = !doesSearch;
                                  // focusNode.requestFocus();
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: PixelNumberfromFigma(7.25),
                                    right: PixelNumberfromFigma(11.25)),
                                child: Textspace(
                                  text: "Cancel",
                                  style: GoogleFonts.inter(
                                      color: Color(0xFF3C3C3C)),
                                ),
                              ),
                            )
                          ]),
                        ))
                    : SizedBox()
              ],
            )));
    ;
  }
}
