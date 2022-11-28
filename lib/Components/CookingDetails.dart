import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:p_l_atter/Components/Builder/Future/CookingItem0FutureBuilder.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Loadingscreen.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Recipeid.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/ad_helper.dart';
import 'package:p_l_atter/Resources/amazonaffiliate.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:cancellation_token_http/http.dart' as http;
// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:url_launcher/url_launcher.dart';

class nativeAd extends StatefulWidget {
  nativeAd({Key? key}) : super(key: key);

  @override
  _nativeAdState createState() => _nativeAdState();
}

class _nativeAdState extends State<nativeAd> {
  // TODO: Add _kAdIndex
  static final _kAdIndex = 4;

  // TODO: Add a native ad instance
  NativeAd? _ad;

  // TODO: Add _getDestinationItemIndex()
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _ad != null) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();

    // TODO: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as NativeAd;
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
        },
      ),
    );

    _ad?.load();
  }

  // 1. Create bool
  bool isAdLoaded = false;

  @override
  void dispose() {
    // TODO: Dispose a NativeAd object
    _ad?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isAdLoaded ? AdWidget(ad: _ad!) : CircularProgressIndicator(),
    );
  }
}

class CookingDetails extends StatefulWidget {
  const CookingDetails({super.key});

  @override
  State<CookingDetails> createState() => _CookingDetailsState();
}

class _CookingDetailsState extends State<CookingDetails> {
  var _controller = PageController(
      viewportFraction: 1 - (0.16312312312 * (pow(1.2720196495141103, 2))));

  List<List<String>> amazondata = [];

  void loadAsset() {
    WidgetsFlutterBinding.ensureInitialized();
    String stringdata = stringdatas?["10 Small Appliances For Baking"] ?? "";
    stringdata.split("\n").forEach((e) {
      amazondata.add(e.split(","));
    });
  }

  @override
  void initState() {
    super.initState();
    loadAsset();
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
    final providedRequestor = Provider.of<Requestor>(context);
    final recipeIdModel = Provider.of<Recipeid>(context, listen: false);
    return Scaffold(
        body: Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Consumer<Recipeid>(
          builder: (context, recipeIdModel, child) {
            return FutureBuilder<http.Response>(
                future: providedRequestor
                    .waitRequest("recipe_id ${recipeIdModel.recipeId}"),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.done ||
                      (snap.hasData &&
                          "${jsonDecode(snap.data!.body)["error"]}" ==
                              "null")) {
                    dynamic data = [];
                    try {
                      data = jsonDecode(snap.data?.body ?? "{}")["recipe"];
                    } catch (e) {}
                    final name = data?["recipe_name"] ?? "";
                    final recipe_description =
                        data?["recipe_description"] ?? "";
                    var recipe_image = data?["recipe_images"]
                            ?["recipe_image"] ??
                        "https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";

                    if (recipe_image is List<dynamic>) {
                      recipe_image = recipe_image[0];
                    }
                    final ingredients =
                        List.from(data?["ingredients"]?["ingredient"] ?? [])
                            .map((e) => e["ingredient_description"])
                            .join("\n");

                    final directions =
                        List.from(data?["directions"]?["direction"] ?? []);
                    return SingleChildScrollView(
                        child: Container(
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
                              //   Color.fromARGB(255, 162, 0, 255)
                              //       .withOpacity(0.005),
                              //   Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                              //   Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                              //   Color.fromARGB(255, 140, 0, 255)
                              //       .withOpacity(0.005),
                              Color.fromARGB(255, 255, 0, 150)
                                  .withOpacity(0.005),
                              Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.000),
                              Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.000),
                              Color.fromARGB(255, 255, 0, 150)
                                  .withOpacity(0.005),
                            ]),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: PixelNumberfromFigma(25.6 + 15 + 7.5),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: PixelNumberfromFigma(15),
                                right: PixelNumberfromFigma(15)),
                            child: Column(children: [
                              Stack(
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    height: PixelNumberfromFigma(183 + 10),

                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: PixelNumberfromFigma(52.33),
                                          ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight:
                                                        PixelNumberfromFigma(
                                                            97),
                                                    maxWidth:
                                                        PixelNumberfromFigma(
                                                            97),
                                                  ),
                                                  child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          height:
                                                              PixelNumberfromFigma(
                                                                  97),
                                                          width:
                                                              PixelNumberfromFigma(
                                                                  97),
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          child: Image.asset(
                                                              "assets/platter/play_store_512.png",
                                                              fit: BoxFit
                                                                  .contain),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    30,
                                                                    131,
                                                                    255),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Container(
                                                          transform: Matrix4
                                                              .translationValues(
                                                                  0,
                                                                  PixelNumberfromFigma(
                                                                      19.13 +
                                                                          34.78743488 -
                                                                          5),
                                                                  0),
                                                          width:
                                                              PixelNumberfromFigma(
                                                                  88.8),
                                                          height:
                                                              PixelNumberfromFigma(
                                                                  34.87),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/platter/line0.svg",
                                                            fit: BoxFit.contain,
                                                            color: Color(
                                                                0xFF000000),
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                                SizedBox(
                                                  width: fontSizeNumber(1),
                                                ),
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight:
                                                        PixelNumberfromFigma(
                                                            97),
                                                    maxWidth:
                                                        PixelNumberfromFigma(
                                                            97),
                                                  ),
                                                  child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          height:
                                                              PixelNumberfromFigma(
                                                                  97),
                                                          width:
                                                              PixelNumberfromFigma(
                                                                  97),
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          child: Image.network(
                                                              recipe_image
                                                                      is List<
                                                                          String>
                                                                  ? recipe_image[
                                                                      0]
                                                                  : recipe_image,
                                                              fit:
                                                                  BoxFit.cover),
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: Color.fromARGB(
                                                            //     255, 255, 78, 78),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .bottomCenter,
                                                                end: Alignment
                                                                    .topCenter,
                                                                colors: [
                                                                  Color.fromARGB(
                                                                          255,
                                                                          2,
                                                                          6,
                                                                          8)
                                                                      .withOpacity(
                                                                          0.01),
                                                                  Color.fromARGB(
                                                                          255,
                                                                          2,
                                                                          14,
                                                                          31)
                                                                      .withOpacity(
                                                                          0.01),
                                                                ]),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          height:
                                                              PixelNumberfromFigma(
                                                                  97),
                                                          width:
                                                              PixelNumberfromFigma(
                                                                  97),
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          child: Image.network(
                                                              recipe_image
                                                                      is List<
                                                                          String>
                                                                  ? recipe_image[
                                                                      0]
                                                                  : recipe_image,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        Container(
                                                          transform: Matrix4
                                                              .translationValues(
                                                                  0,
                                                                  PixelNumberfromFigma(
                                                                      19.13 +
                                                                          34.78743488 -
                                                                          5),
                                                                  0),
                                                          width:
                                                              PixelNumberfromFigma(
                                                                  88.8),
                                                          height:
                                                              PixelNumberfromFigma(
                                                                  34.87),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/platter/line0.svg",
                                                            fit: BoxFit.contain,
                                                            color: Color(
                                                                0xFF000000),
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                              ]),
                                        ),
                                        Container(
                                            // color: Colors.red,
                                            alignment: Alignment.centerLeft,
                                            // height: fontSizeNumber(0) * 4.130228887,

                                            child: Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    // color: Colors.yellow,
                                                    child: Textspace(
                                                      text: name,
                                                      headsize: 0.0001,
                                                      height:
                                                          PixelNumberfromFigma(
                                                              52.33),
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              PixelNumberfromFigma(
                                                                  10)),
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      style:
                                                          GoogleFonts.workSans(
                                                              fontSize:
                                                                  fontSizeNumber(
                                                                      2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              foreground:
                                                                  Paint()
                                                                    ..style =
                                                                        PaintingStyle
                                                                            .stroke
                                                                    ..strokeWidth =
                                                                        fontSizeNumber(0) *
                                                                            0.00789266
                                                                    ..color = Color(
                                                                        0xFF000000)),

                                                      // font: GoogleFonts.workSans,
                                                    ),
                                                    constraints: BoxConstraints(
                                                        minHeight:
                                                            PixelNumberfromFigma(
                                                                52.33)),
                                                  ),
                                                ),
                                                Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      child: Textspace(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                PixelNumberfromFigma(
                                                                    10)),
                                                        text: name,
                                                        height:
                                                            PixelNumberfromFigma(
                                                                52.33),
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        headsize: 0.0001,
                                                        style: GoogleFonts
                                                            .workSans(
                                                                color: Color(
                                                                    0xFF000000),
                                                                fontSize:
                                                                    fontSizeNumber(
                                                                        2),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),

                                                        // font: GoogleFonts.workSans,
                                                      ),
                                                      constraints: BoxConstraints(
                                                          minHeight:
                                                              PixelNumberfromFigma(
                                                                  52.33)),
                                                    ))
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              GradientTextspace(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color.fromARGB(255, 2, 6, 8),
                                        Color.fromARGB(255, 2, 14, 31),
                                      ]),
                                  textspace: Column(
                                    children: [
                                      Textspace(
                                        text: "10-9-2020",
                                        height: fontSizeNumber(0) * 1.420678769,
                                        // size: 0.5,
                                        headsize: 0.0001,
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            height: 1.866666667,
                                            color: Color(0xFF000000),
                                            fontSize:
                                                fontSizeNumber(0) * 1.183898974,
                                            letterSpacing:
                                                fontSizeNumber(0) * 0.03),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Textspace(
                                              padding: EdgeInsets.only(
                                                  top: PixelNumberfromFigma(0)),
                                              height: fontSizeNumber(0) *
                                                  2.28887135,
                                              headsize: 0.0001,
                                              text: "Myfatsecret",
                                              textOverflow:
                                                  TextOverflow.visible,
                                              maxLines: 1,
                                              style: GoogleFonts.inter(
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight.w600,
                                                  // height: 1.866666667,
                                                  fontSize:
                                                      fontSizeNumber(1.000001),
                                                  letterSpacing:
                                                      fontSizeNumber(0) * 0.05),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: fontSizeNumber(0) * 0.603788477,
                                      ),
                                      Textspace(
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            height: 1.866666667,
                                            fontSize:
                                                fontSizeNumber(0) * 1.183898974,
                                            letterSpacing:
                                                fontSizeNumber(0) * 0.03),
                                        text:
                                            "$recipe_description\n$ingredients",
                                        headsize: 0.0001,
                                      ),
                                      SizedBox(
                                        height: PixelNumberfromFigma(91),
                                      ),
                                    ],
                                  ))
                            ]),
                          ),
                          Container(
                            // color: Colors.blue,
                            // transform: Matrix4.translationValues(0, fontSizeNumber(0) * -1, 0),
                            child: SizedBox(
                                height: fontSizeNumber(0) * 23.1,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: PixelNumberfromFigma(15)),
                                      constraints: BoxConstraints(
                                        maxWidth: fontSizeNumber(12),
                                        maxHeight:
                                            (fontSizeNumber(0) * 22.92738753),
                                      ),
                                      child: PageView(
                                        padEnds: true,
                                        scrollDirection: Axis.vertical,
                                        controller: _controller,
                                        children: [
                                          for (dynamic direction in directions)
                                            Container(
                                                alignment: Alignment.topLeft,
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        fontSizeNumber(10.9)),
                                                child: Stack(
                                                  children: [
                                                    Textspace(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          height: 1.866666667,
                                                          fontSize:
                                                              fontSizeNumber(
                                                                      0) *
                                                                  1.183898974,
                                                          letterSpacing:
                                                              fontSizeNumber(
                                                                      0) *
                                                                  0.09,
                                                        ),
                                                        text:
                                                            "${directions.indexOf(direction) + 1} ${direction["direction_description"]}"),
                                                    Textspace(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          height: 1.866666667,
                                                          fontSize:
                                                              fontSizeNumber(
                                                                      0) *
                                                                  1.183898974,
                                                          letterSpacing:
                                                              fontSizeNumber(
                                                                      0) *
                                                                  0.09,
                                                          foreground: Paint()
                                                            ..style =
                                                                PaintingStyle
                                                                    .stroke
                                                            ..strokeWidth =
                                                                fontSizeNumber(
                                                                        0) *
                                                                    0.093441119
                                                            ..color =
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                        ),
                                                        text:
                                                            "${directions.indexOf(direction) + 1} ${direction["direction_description"]}"),
                                                  ],
                                                )),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      fontSizeNumber(10.9)),
                                              child: Stack(
                                                children: [
                                                  Textspace(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        height: 1.866666667,
                                                        fontSize:
                                                            fontSizeNumber(0) *
                                                                1.183898974,
                                                        letterSpacing:
                                                            fontSizeNumber(0) *
                                                                0.09,
                                                      ),
                                                      text:
                                                          "Well done, you finished."),
                                                  Textspace(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        height: 1.866666667,
                                                        fontSize:
                                                            fontSizeNumber(0) *
                                                                1.183898974,
                                                        letterSpacing:
                                                            fontSizeNumber(0) *
                                                                0.09,
                                                        foreground: Paint()
                                                          ..style =
                                                              PaintingStyle
                                                                  .stroke
                                                          ..strokeWidth =
                                                              fontSizeNumber(
                                                                      0) *
                                                                  0.093441119
                                                          ..color =
                                                              Color.fromARGB(
                                                                  255, 0, 0, 0),
                                                      ),
                                                      text:
                                                          "Well done, you finished."),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                    IgnorePointer(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: DecoratedBox(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [
                                                0,
                                                0.16312312312 / 2,
                                                0.180,
                                                0.3,
                                                0.5,
                                                0.7,
                                                0.9999999999,
                                              ],
                                              colors: <Color>[
                                                Color.fromARGB(
                                                    255, 255, 255, 255),
                                                Color(0x00FAFAFA),
                                                Color(0x00FAFAFA),
                                                Color.fromARGB(
                                                    2, 129, 129, 129),
                                                Color(0x00FAFAFA),
                                                Color(0x00FAFAFA),
                                                Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ], // Gradient from https://learnui.design/tools/gradient-generator.html
                                              tileMode: TileMode.mirror,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            // mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                height: fontSizeNumber(1),
                                              ),
                                              SvgPicture.asset(
                                                "assets/platter/Group147.svg",
                                                width:
                                                    PixelNumberfromFigma(50.57),
                                              ),
                                              SizedBox(
                                                height: fontSizeNumber(4),
                                              ),
                                              SvgPicture.asset(
                                                "assets/platter/Group190.svg",
                                                width:
                                                    PixelNumberfromFigma(50.57),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),

                          SizedBox(height: PixelNumberfromFigma(91)),
                          Container(
                              height: 72.0,
                              alignment: Alignment.center,
                              child: nativeAd()),

                          SizedBox(
                              height: PixelNumberfromFigma(38),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: PixelNumberfromFigma(15),
                                    right: PixelNumberfromFigma(15)),
                                decoration: BoxDecoration(
                                    // color: Colors.blue,
                                    border: Border(
                                        top: BorderSide(
                                            width: PixelNumberfromFigma(1),
                                            color: Color(0xFFEDEDED)))),
                                child: Transform(
                                    transform: Matrix4.translationValues(
                                        0, PixelNumberfromFigma(3) * -1, 0),
                                    child: Textspace(
                                      text: "Related cookware",
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      size: 2,
                                    )),
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: PixelNumberfromFigma(15),
                                right: PixelNumberfromFigma(15)),
                            child: Column(
                              children: [
                                Container(
                                  height: PixelNumberfromFigma(173),
                                  alignment: Alignment.centerLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(children: [
                                      for (var a in amazondata)
                                        Padding(
                                          padding: EdgeInsets.only(right: 19),
                                          child: InkWell(
                                              onTap: () async {
                                                if (await canLaunchUrl(
                                                    Uri.parse(a[0])))
                                                  await launchUrl(
                                                      Uri.parse(a[0]),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                else
                                                  // can't launch url, there is some error
                                                  throw "Could not launch ${a[0]}";
                                              },
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxHeight:
                                                          PixelNumberfromFigma(
                                                              142)),
                                                  child: AspectRatio(
                                                      aspectRatio: 106 / 142,
                                                      child: Stack(
                                                        children: [
                                                          Positioned.fill(
                                                              child: Container(
                                                            color: Colors.white,
                                                          )),
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: PixelNumberfromFigma(
                                                                          15)),
                                                              // decoration: BoxDecoration(
                                                              //     color: Colors
                                                              //         .white,
                                                              //     border: Border(
                                                              //         top: BorderSide(
                                                              //             color: Color(
                                                              //                 0xFF838383)))),
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                              maxHeight: PixelNumberfromFigma(79 - 15)),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          AspectRatio(
                                                                        aspectRatio:
                                                                            105 /
                                                                                86,
                                                                        child: Image.network(
                                                                            a[1],
                                                                            fit: BoxFit.contain),
                                                                      ),
                                                                    ),
                                                                    Textspace(
                                                                      text:
                                                                          a[2],
                                                                      maxLines:
                                                                          3,
                                                                      headsize:
                                                                          0.0001,
                                                                      style: GoogleFonts.inter(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              fontSizeNumber(0)),
                                                                    )
                                                                  ])),
                                                          Positioned.fill(
                                                            child: DecoratedBox(
                                                                decoration:
                                                                    BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .bottomCenter,
                                                                  end: Alignment
                                                                      .topCenter,
                                                                  colors: [
                                                                    Color.fromARGB(
                                                                            255,
                                                                            70,
                                                                            193,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.01),
                                                                    Color.fromARGB(
                                                                            255,
                                                                            17,
                                                                            116,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.01),
                                                                  ]),
                                                            )),
                                                          )
                                                        ],
                                                      )))),
                                        )
                                    ]),
                                  ),
                                ),
                                // Container(
                                //   height: 72.0,
                                //   alignment: Alignment.center,
                                //   child: nativeAd(),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: PixelNumberfromFigma(38),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: PixelNumberfromFigma(15),
                                  right: PixelNumberfromFigma(15)),
                              decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  border: Border(
                                      top: BorderSide(
                                          width: PixelNumberfromFigma(1),
                                          color: Color(0xFFEDEDED)))),
                              child: Textspace(
                                text: "More content",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                                size: 2,
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: CookingItem0FutureBuilder(
                                readJson: () =>
                                    RestClient().recipesSearch("Morning"),
                              ),
                              height: PixelNumberfromFigma(198)),

                          // SizedBox(
                          //   height: PixelNumberfromFigma(87),
                          // )
                          // SizedBox(
                          //   height: fontSizeNumber(1),
                          // ),
                          // ElevatedButton(
                          //   // Within the SecondScreen widget
                          //   onPressed: () {
                          //     // Navigate back to the first screen by popping the current route
                          //     // off the stack.
                          //     Navigator.pop(context);
                          //   },
                          //   child: const Text('Go back!'),
                          // ),
                        ],
                      ),
                    ));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Textspace(
                            text: 'Awaiting result...',
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    );
                  }
                });
          },
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            color: Color(0xFFF5F6F8),
                            width: PixelNumberfromFigma(1)))),
                padding: EdgeInsets.only(
                    left: PixelNumberfromFigma(15),
                    top: PixelNumberfromFigma(15),
                    bottom: PixelNumberfromFigma(7.5),
                    right: PixelNumberfromFigma(15)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Consumer<Savemodel>(
                              builder: (context, savemodel, child) {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    savemodel.addLike(recipeIdModel.recipeId);
                                  },
                                  child: SvgPicture.asset(
                                    savemodel.likes
                                            .contains(recipeIdModel.recipeId)
                                        ? "assets/platter/like_outlined.svg"
                                        : "assets/platter/like.svg",
                                    color: Colors.black,
                                    height: PixelNumberfromFigma(21.73),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: PixelNumberfromFigma(17.5),
                            ),
                            InkWell(
                              onTap: () {
                                _askedToLead();
                              },
                              splashColor: Colors.transparent,
                              child: SvgPicture.asset(
                                "assets/platter/share.svg",
                                color: Colors.black,
                                height: PixelNumberfromFigma(25.6),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Consumer<Savemodel>(
                              builder: (context, savemodel, child) {
                                return InkWell(
                                  onTap: () {
                                    savemodel.addFocus(recipeIdModel.recipeId);
                                  },
                                  splashColor: Colors.transparent,
                                  child: SvgPicture.asset(
                                    savemodel.focus
                                            .contains(recipeIdModel.recipeId)
                                        ? "assets/platter/bookmark_filled.svg"
                                        : "assets/platter/bookmark.svg",
                                    color: Colors.black,
                                    height: PixelNumberfromFigma(21.73),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                        // SizedBox(
                        //   width: PixelNumberfromFigma(15),
                        // ),
                      ],
                    ),
                  ],
                ))),
        Consumer<Requestor>(builder: (context, requestor, widget) {
          return Loadingscreen(
            seconds: 1,
            white: !((requestor
                        .requestResponses["recipe_id ${recipeIdModel.recipeId}"]
                        ?.keys ??
                    [])
                .isNotEmpty),
          );
        }),
      ]),
    ));
  }
}
