import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:url_launcher/url_launcher.dart';

class nativeAd extends StatefulWidget {
  nativeAd({Key? key}) : super(key: key);

  @override
  _nativeAdState createState() => _nativeAdState();
}

class _nativeAdState extends State<nativeAd> {
  // TODO: Add a native ad instance
  NativeAd? _ad;

  @override
  void initState() {
    super.initState();

    // TODO: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
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
    _ad?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          isAdLoaded ? AdWidget(ad: _ad!) : const CircularProgressIndicator(),
    );
  }
}

class CookingDetails extends StatefulWidget {
  const CookingDetails({super.key});

  @override
  State<CookingDetails> createState() => _CookingDetailsState();
}

class _CookingDetailsState extends State<CookingDetails> {
  final _controller = PageController(
      viewportFraction: 1 - (0.16312312312 * (pow(1.2720196495141103, 2))));
  rive.SMIBool? _bump;
  final ignore = const SizedBox();
  List<List<String>> amazondata = [];
  late Savemodel providedSavemodel;
  late Requestor providedRequestor;
  late Recipeid recipeIdModel;

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
    // loadAsset();
    providedSavemodel = Provider.of<Savemodel>(context, listen: false);
    providedRequestor = Provider.of<Requestor>(context, listen: false);
    recipeIdModel = Provider.of<Recipeid>(context, listen: false);
    if (providedSavemodel.likes.contains(recipeIdModel.recipeId)) {
      Future<void>.delayed(const Duration(milliseconds: 25)).then((voi) {
        _bump?.change(true);
      });
    }
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Share Via'),
            children: <Widget>[
              for (String i in [
                "Whatsapp",
                "Facebook",
                "Instagram",
                "Twitter",
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

  late Widget animation = rive.RiveAnimation.asset(
    'assets/platter/like.riv',
    stateMachines: [
      providedSavemodel.likes.contains(recipeIdModel.recipeId)
          ? 'State Machine 2'
          : 'State Machine 1'
    ],
    fit: BoxFit.contain,
  );

  late Widget animation1 = rive.RiveAnimation.asset(
    'assets/platter/bookmark.riv',
    stateMachines: [
      providedSavemodel.focus.contains(recipeIdModel.recipeId)
          ? 'State Machine 2'
          : 'State Machine 1'
    ],
    fit: BoxFit.contain,
  );

  void _onRiveInit(rive.Artboard artboard) {
    final controller =
        rive.StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('Boolean 1') as rive.SMIBool;
  }

  void _hitBump() {
    _bump?.change(!_bump!.value);
  }

  @override
  Widget build(BuildContext context) {
    // final providedRequestor = Provider.of<Requestor>(context, listen: false);

    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: FutureBuilder<http.Response>(
              future: providedRequestor
                  .waitRequest("recipe_id ${recipeIdModel.recipeId}"),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.done ||
                    (snap.hasData &&
                        snap.data!.body.contains("error") == false)) {
                  dynamic data = [];
                  data = jsonDecode(snap.data?.body ?? "{}")["recipe"];

                  final name = data?["recipe_name"] ?? "";
                  final recipe_description = data?["recipe_description"] ?? "";
                  var recipe_image = data?["recipe_images"]?["recipe_image"] ??
                      "https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";

                  if (recipe_image is List<dynamic>) {
                    recipe_image = recipe_image[0];
                  }

                  final ingredients =
                      (data?["ingredients"]?["ingredient"] ?? [])
                          .map((e) => e["ingredient_description"])
                          .join("\n");

                  final directions = data?["directions"]?["direction"] ?? [];

                  return SingleChildScrollView(
                      child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [
                            0,
                            .10,
                            .90,
                            1
                          ],
                          colors: [
                            const Color.fromARGB(255, 255, 0, 150)
                                .withOpacity(0.005),
                            const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.000),
                            const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.000),
                            const Color.fromARGB(255, 255, 0, 150)
                                .withOpacity(0.005),
                          ]),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: pixelNumberfromFigma(25.6 + 15 + 7.5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: pixelNumberfromFigma(15),
                              right: pixelNumberfromFigma(15)),
                          child: Column(children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: pixelNumberfromFigma(183 + 10),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: pixelNumberfromFigma(52.33),
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
                                                      pixelNumberfromFigma(97),
                                                  maxWidth:
                                                      pixelNumberfromFigma(97),
                                                ),
                                                child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height:
                                                            pixelNumberfromFigma(
                                                                97),
                                                        width:
                                                            pixelNumberfromFigma(
                                                                97),
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              30,
                                                              131,
                                                              255),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.asset(
                                                            "assets/platter/play_store_512.png",
                                                            fit:
                                                                BoxFit.contain),
                                                      ),
                                                      Container(
                                                        transform: Matrix4
                                                            .translationValues(
                                                                0,
                                                                pixelNumberfromFigma(
                                                                    19.13 +
                                                                        34.78743488 -
                                                                        5),
                                                                0),
                                                        width:
                                                            pixelNumberfromFigma(
                                                                88.8),
                                                        height:
                                                            pixelNumberfromFigma(
                                                                34.87),
                                                        child: SvgPicture.asset(
                                                          "assets/platter/line0.svg",
                                                          fit: BoxFit.contain,
                                                          color: const Color(
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
                                                      pixelNumberfromFigma(97),
                                                  maxWidth:
                                                      pixelNumberfromFigma(97),
                                                ),
                                                child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height:
                                                            pixelNumberfromFigma(
                                                                97),
                                                        width:
                                                            pixelNumberfromFigma(
                                                                97),
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        decoration:
                                                            const BoxDecoration(
                                                          // color: Color.fromARGB(
                                                          //     255, 255, 78, 78),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                            recipe_image,
                                                            fit: BoxFit.cover),
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
                                                                const Color.fromARGB(
                                                                        255,
                                                                        2,
                                                                        6,
                                                                        8)
                                                                    .withOpacity(
                                                                        0.01),
                                                                const Color.fromARGB(
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
                                                            pixelNumberfromFigma(
                                                                97),
                                                        width:
                                                            pixelNumberfromFigma(
                                                                97),
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        child: Image.network(
                                                            recipe_image,
                                                            fit: BoxFit.cover),
                                                      ),
                                                      Container(
                                                        transform: Matrix4
                                                            .translationValues(
                                                                0,
                                                                pixelNumberfromFigma(
                                                                    19.13 +
                                                                        34.78743488 -
                                                                        5),
                                                                0),
                                                        width:
                                                            pixelNumberfromFigma(
                                                                88.8),
                                                        height:
                                                            pixelNumberfromFigma(
                                                                34.87),
                                                        child: SvgPicture.asset(
                                                          "assets/platter/line0.svg",
                                                          fit: BoxFit.contain,
                                                          color: const Color(
                                                              0xFF000000),
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ]),
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Stack(
                                            alignment: Alignment.bottomLeft,
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                      minHeight:
                                                          pixelNumberfromFigma(
                                                              52.33)),
                                                  child: Textspace(
                                                    headsize: 0.0001,
                                                    height:
                                                        pixelNumberfromFigma(
                                                            52.33),
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            pixelNumberfromFigma(
                                                                10)),
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    style: GoogleFonts.workSans(
                                                        fontSize:
                                                            fontSizeNumber(2),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        foreground: Paint()
                                                          ..style =
                                                              PaintingStyle
                                                                  .stroke
                                                          ..strokeWidth =
                                                              fontSizeNumber(
                                                                      0) *
                                                                  0.00789266
                                                          ..color = const Color(
                                                              0xFF000000)),
                                                    text: name,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        minHeight:
                                                            pixelNumberfromFigma(
                                                                52.33)),
                                                    child: Textspace(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              pixelNumberfromFigma(
                                                                  10)),
                                                      text: name,
                                                      height:
                                                          pixelNumberfromFigma(
                                                              52.33),
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      headsize: 0.0001,
                                                      style: GoogleFonts.workSans(
                                                          color: const Color(
                                                              0xFF000000),
                                                          fontSize:
                                                              fontSizeNumber(2),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ))
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            GradientTextspace(
                                gradient: const LinearGradient(
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
                                          color: const Color(0xFF000000),
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
                                                top: pixelNumberfromFigma(0)),
                                            height:
                                                fontSizeNumber(0) * 2.28887135,
                                            headsize: 0.0001,
                                            text: "Myfatsecret",
                                            textOverflow: TextOverflow.visible,
                                            maxLines: 1,
                                            style: GoogleFonts.inter(
                                                color: const Color(0xFF000000),
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
                                      text: "$recipe_description\n$ingredients",
                                      headsize: 0.0001,
                                    ),
                                    // SizedBox(
                                    //   height: pixelNumberfromFigma(91),
                                    // ),
                                  ],
                                ))
                          ]),
                        ),
                        SizedBox(
                            height: fontSizeNumber(0) * 23.1,
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: pixelNumberfromFigma(15)),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.64,
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
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64),
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
                                                        "Step ${directions.indexOf(direction) + 1}. ${direction["direction_description"]}"),
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
                                                            PaintingStyle.stroke
                                                        ..strokeWidth =
                                                            fontSizeNumber(0) *
                                                                0.093441119
                                                        ..color = const Color
                                                                .fromARGB(
                                                            255, 0, 0, 0),
                                                    ),
                                                    text:
                                                        "Step ${directions.indexOf(direction) + 1}. ${direction["direction_description"]}"),
                                              ],
                                            )),
                                      Container(
                                          alignment: Alignment.topLeft,
                                          constraints: BoxConstraints(
                                              maxWidth: fontSizeNumber(10.9)),
                                          child: Stack(
                                            children: [
                                              Textspace(
                                                  alignment: Alignment.topLeft,
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w300,
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
                                                  alignment: Alignment.topLeft,
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w300,
                                                    height: 1.866666667,
                                                    fontSize:
                                                        fontSizeNumber(0) *
                                                            1.183898974,
                                                    letterSpacing:
                                                        fontSizeNumber(0) *
                                                            0.09,
                                                    foreground: Paint()
                                                      ..style =
                                                          PaintingStyle.stroke
                                                      ..strokeWidth =
                                                          fontSizeNumber(0) *
                                                              0.093441119
                                                      ..color =
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0),
                                                  ),
                                                  text:
                                                      "Well done, you finished."),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                const Positioned.fill(
                                  child: IgnorePointer(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
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
                                            Color.fromARGB(255, 255, 255, 255),
                                            Color(0x00FAFAFA),
                                            Color(0x00FAFAFA),
                                            Color.fromARGB(2, 129, 129, 129),
                                            Color(0x00FAFAFA),
                                            Color(0x00FAFAFA),
                                            Color.fromARGB(255, 255, 255, 255),
                                          ], // Gradient from https://learnui.design/tools/gradient-generator.html
                                          tileMode: TileMode.mirror,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                          width: pixelNumberfromFigma(50.57),
                                        ),
                                        SizedBox(
                                          height: fontSizeNumber(4),
                                        ),
                                        // SvgPicture.asset(
                                        //   "assets/platter/Group190.svg",
                                        //   width: pixelNumberfromFigma(50.57),
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(height: pixelNumberfromFigma(91)),
                        Stack(
                          children: [
                            Container(
                                height: 72.0,
                                alignment: Alignment.center,
                                child: nativeAd()),
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
                            ))
                          ],
                        ),
                        SizedBox(
                            height: pixelNumberfromFigma(38),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: pixelNumberfromFigma(15),
                                  right: pixelNumberfromFigma(15)),
                              decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  border: Border(
                                      top: BorderSide(
                                          width: pixelNumberfromFigma(1),
                                          color: const Color(0xFFEDEDED)))),
                              child: Transform(
                                  transform: Matrix4.translationValues(
                                      0, pixelNumberfromFigma(3) * -1, 0),
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
                              left: pixelNumberfromFigma(15),
                              right: pixelNumberfromFigma(15)),
                          child: Column(
                            children: [
                              Container(
                                height: pixelNumberfromFigma(173),
                                alignment: Alignment.centerLeft,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    for (var a in amazondata)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 19),
                                        child: InkWell(
                                            onTap: () async {
                                              if (await canLaunchUrl(
                                                  Uri.parse(a[0]))) {
                                                await launchUrl(Uri.parse(a[0]),
                                                    mode: LaunchMode
                                                        .externalApplication);
                                              } else {
                                                // can't launch url, there is some error
                                                throw "Could not launch ${a[0]}";
                                              }
                                            },
                                            child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxHeight:
                                                        pixelNumberfromFigma(
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
                                                            padding: EdgeInsets.only(
                                                                top:
                                                                    pixelNumberfromFigma(
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
                                                                            maxHeight:
                                                                                pixelNumberfromFigma(79 - 15)),
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
                                                                          fit: BoxFit
                                                                              .contain),
                                                                    ),
                                                                  ),
                                                                  Textspace(
                                                                    text: a[2],
                                                                    maxLines: 3,
                                                                    headsize:
                                                                        0.0001,
                                                                    style: GoogleFonts.inter(
                                                                        fontWeight:
                                                                            FontWeight
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
                                                                  const Color.fromARGB(
                                                                          255,
                                                                          70,
                                                                          193,
                                                                          255)
                                                                      .withOpacity(
                                                                          0.01),
                                                                  const Color.fromARGB(
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
                          height: pixelNumberfromFigma(38),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: pixelNumberfromFigma(15),
                                right: pixelNumberfromFigma(15)),
                            decoration: BoxDecoration(
                                // color: Colors.blue,
                                border: Border(
                                    top: BorderSide(
                                        width: pixelNumberfromFigma(1),
                                        color: const Color(0xFFEDEDED)))),
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
                          height: pixelNumberfromFigma(198),
                          child: CookingItem0FutureBuilder(
                              readJson: () =>
                                  providedRequestor.waitRequest("home0")),
                        ),
                      ],
                    ),
                  ));
                } else {
                  return ignore;
                }
              }),
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
                            color: const Color(0xFFF5F6F8),
                            width: pixelNumberfromFigma(1)))),
                padding: EdgeInsets.only(
                    left: pixelNumberfromFigma(15),
                    top: pixelNumberfromFigma(15),
                    bottom: pixelNumberfromFigma(7.5),
                    right: pixelNumberfromFigma(15)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                                scale: 1.30,
                                child: SizedBox(
                                  width:
                                      pixelNumberfromFigma(21.73) / 1.125172572,
                                  height: pixelNumberfromFigma(21.73),
                                  // color: Colors.amber,
                                  child: Container(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    child: Container(
                                      // color: Colors.blue,
                                      height: pixelNumberfromFigma(21.73) /
                                          1.125172572,
                                      width: pixelNumberfromFigma(21.73),
                                      child: TapRegion(
                                        onTapInside: (event) {
                                          providedSavemodel
                                              .addLike(recipeIdModel.recipeId);
                                        },
                                        child: animation,
                                      ),
                                    ),
                                  ),

                                  // SvgPicture.asset(
                                  //   providedSavemodel.likes
                                  //           .contains(recipeIdModel.recipeId)
                                  //       ? "assets/platter/like_outlined.svg"
                                  //       : "assets/platter/like.svg",
                                  //   color: Colors.black,
                                  //   height: pixelNumberfromFigma(21.73),
                                  // ),
                                )),
                            SizedBox(
                              width: pixelNumberfromFigma(22.5 - 2.173),
                            ),
                            InkWell(
                              onTap: () {
                                _askedToLead();
                              },
                              splashColor: Colors.transparent,
                              child: SvgPicture.asset(
                                "assets/platter/share.svg",
                                color: Colors.black,
                                height: pixelNumberfromFigma(25.6),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                                scale: 1,
                                child: SizedBox(
                                  width:
                                      pixelNumberfromFigma(21.73) / 1.294642857,
                                  height: pixelNumberfromFigma(21.73),
                                  // color: Colors.amber,
                                  child: Container(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    child: TapRegion(
                                        onTapInside: (value) {
                                          providedSavemodel
                                              .addFocus(recipeIdModel.recipeId);
                                        },
                                        child: SizedBox(
                                          // color: Colors.blue,
                                          height: pixelNumberfromFigma(21.73),
                                          width: pixelNumberfromFigma(21.73) /
                                              1.294642857,
                                          child: animation1,
                                        )),
                                  ),

                                  // SvgPicture.asset(
                                  //   providedSavemodel.likes
                                  //           .contains(recipeIdModel.recipeId)
                                  //       ? "assets/platter/like_outlined.svg"
                                  //       : "assets/platter/like.svg",
                                  //   color: Colors.black,
                                  //   height: pixelNumberfromFigma(21.73),
                                  // ),
                                )),
                          ],
                        )
                        // SizedBox(
                        //   width: PixelNumberfromFigma(15),
                        // ),
                      ],
                    ),
                  ],
                ))),
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
      ]),
    ));
  }
}
