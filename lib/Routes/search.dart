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
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/GraphQl/tell.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'dart:ui' as ui;
// import 'package:http/http.dart' as http;
import 'package:cancellation_token_http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Searchscreen extends StatefulWidget {
  Searchscreen({Key? key}) : super(key: key);

  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  late Requestor providedRequestor =
      Provider.of<Requestor>(context, listen: false);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    providedRequestor.addRequest(
        "search ",
        (token) => RestClient()
            .recipesSearch(_nameInputcontroller.text, canceltoken: token),
        override: false);
  }

  var focusNode = FocusNode();
  final _nameInputcontroller = TextEditingController();
  late Future<http.Response> loadFuture =
      providedRequestor.waitRequest("search ");

  @override
  Widget build(BuildContext context) {
    Widget textField = TextField(
      focusNode: focusNode,
      // cursorHeight: 0,
      textAlignVertical: TextAlignVertical.bottom,
      onChanged: (value) {
        providedRequestor.cancel("search $textQuery");

        providedRequestor.addRequest("search $value", (token) {
          token = token;
          return RestClient()
              .recipesSearch(_nameInputcontroller.text, canceltoken: token);
        });

        setState(() {
          textQuery = value;
          loadFuture =
              (() => providedRequestor.waitRequest("search $textQuery"))();
        });
      },
      controller: _nameInputcontroller,
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
          hintText: 'What do you want to cook?',
          hintStyle:
              TextStyle(color: Color(0xFF3C3C3C), fontSize: fontSizeNumber(0))),
    );
    Widget prevScreen = Column(mainAxisSize: MainAxisSize.max, children: [
      Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
              height: pixelNumberfromFigma(162.71),
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
                    pixelNumberfromFigma(20.6),
                  ),
                ),
                width: pixelNumberfromFigma(233),
                height: pixelNumberfromFigma(33.17),
                padding: EdgeInsets.only(left: pixelNumberfromFigma(15)),
              )),
          // Positioned.fill(
          //     child: IgnorePointer(
          //   child: Image.asset(
          //     "assets/platter/patternpic.png",
          //     fit: BoxFit.fitWidth,
          //   ),
          // )),
          Container(
              height: pixelNumberfromFigma(162.71),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    pixelNumberfromFigma(20.6),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                        offset: new Offset(1.0, 1.0))
                  ],
                ),
                alignment: Alignment.topCenter,
                width: pixelNumberfromFigma(233),
                height: pixelNumberfromFigma(33.17),
                padding: EdgeInsets.only(left: pixelNumberfromFigma(15)),
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
                              bottom: pixelNumberfromFigma(9.17), top: 0),
                          border: InputBorder.none,
                          hintText: 'What do you want to cook?',
                          hintStyle: TextStyle(
                              color: Color(0xFF3C3C3C),
                              fontSize: fontSizeNumber(0))),
                    ))),
              )),
        ],
      ),
      Stack(
        children: [
          Container(
            // color: Color(0xffF9EFE3),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: pixelNumberfromFigma(15), vertical: 0),
              child: Column(children: [
                SizedBox(
                  height: pixelNumberfromFigma(24),
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
                                    ..strokeWidth = pixelNumberfromFigma(0.2)
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
                  height: pixelNumberfromFigma(5),
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
                                    width: pixelNumberfromFigma(8),
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
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IgnorePointer(
                          child: FutureBuilder<ui.Image>(
                            // key: ValueKey("$textQuery"),
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
                                                          pixelNumberfromFigma(
                                                              8),
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
                                          top: pixelNumberfromFigma(10)),
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
                      const Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                      const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.000),
                      const Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                      const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.000),
                      const Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                      // Color.fromARGB(255, 162, 0, 255).withOpacity(0.005),
                      // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                      // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                      // Color.fromARGB(255, 140, 0, 255).withOpacity(0.005),
                    ]),
              ),
            ),
          )),
        ],
      )
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
                                          left: pixelNumberfromFigma(15),
                                          right: pixelNumberfromFigma(15)),
                                      child: FutureBuilder<http.Response>(
                                        future: loadFuture,
                                        key: ValueKey(
                                            "SearchFuturebuilder $textQuery"),
                                        builder: (context, responseSnapshot) {
                                          print("new snap");
                                          print(responseSnapshot.data?.body);
                                          print(
                                              responseSnapshot.connectionState);
                                          print(responseSnapshot
                                              .data?.request?.finalized);
                                          if (responseSnapshot
                                                      .connectionState ==
                                                  ConnectionState.done &&
                                              responseSnapshot.data?.body
                                                  is String) {
                                            dynamic data = [];
                                            print(
                                                "responseSnapshot.data!.body.contains(\"recipe_name\")");
                                            print("textQuery '$textQuery'");
                                            print(responseSnapshot.data!.body);

                                            try {
                                              data = jsonDecode(responseSnapshot
                                                      .data?.body ??
                                                  "{}")["recipes"]["recipe"];
                                            } catch (e) {}
                                            if (data is List<dynamic>) {
                                            } else {
                                              print("data is here");
                                              print(data);
                                              data = [data];
                                            }
                                            final children = [
                                              SizedBox(
                                                height: pixelNumberfromFigma(9),
                                                child: Container(
                                                    color: Colors.transparent),
                                              ),
                                              for (var item in data)
                                                SearchResultItem(
                                                  data: item,
                                                ),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          pixelNumberfromFigma(
                                                              15),
                                                      top: pixelNumberfromFigma(
                                                          7.5),
                                                      bottom:
                                                          pixelNumberfromFigma(
                                                              7.5),
                                                      right:
                                                          pixelNumberfromFigma(
                                                              15)),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                          child: const Text(
                                                              "Powered by FatSecret"),
                                                          onTap: () async {
                                                            if (await canLaunchUrl(
                                                                Uri.parse(
                                                                    "https://platform.fatsecret.com"))) {
                                                              await launchUrl(
                                                                  Uri.parse(
                                                                      "https://platform.fatsecret.com"),
                                                                  mode: LaunchMode
                                                                      .externalApplication);
                                                            } else
                                                              // can't launch url, there is some error
                                                              throw "Could not launch https: //platform.fatsecret.com";
                                                          })
                                                    ],
                                                  ))
                                            ];
                                            return Column(
                                              children: children,
                                            );
                                          } else {
                                            return textQuery.isNotEmpty
                                                ? const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15),
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : const SizedBox();
                                          }
                                        },
                                        initialData:
                                            providedRequestor.requestResponses[
                                                    "search $textQuery"]?[
                                                providedRequestor
                                                    .loadingrequests[
                                                        "search $textQuery"]!
                                                    .keys
                                                    .last],
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
                                _nameInputcontroller.text.isNotEmpty
                                    ? Positioned(
                                        top: 0,
                                        bottom: 0,
                                        right: pixelNumberfromFigma(12),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _nameInputcontroller.clear();
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
                                setState(() {
                                  doesSearch = !doesSearch;
                                  // focusNode.requestFocus();
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: pixelNumberfromFigma(7.25),
                                    right: pixelNumberfromFigma(11.25)),
                                child: Textspace(
                                  text: "Cancel",
                                  style: GoogleFonts.inter(
                                      color: Color(0xFF3C3C3C)),
                                ),
                              ),
                            )
                          ]),
                        ))
                    : SizedBox(),
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
                            Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.005),
                            Color.fromRGBO(255, 255, 255, 1).withOpacity(0.005),
                            Color.fromARGB(255, 255, 0, 255).withOpacity(0.005),
                          ]),
                    ),
                  ),
                ))
              ],
            )));
    ;
  }
}
