import 'dart:convert';

import 'package:cancellation_token_http/http.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;

class CookingAssistantItem extends StatefulWidget {
  final dynamic data;
  const CookingAssistantItem({super.key, dynamic this.data});

  @override
  State<CookingAssistantItem> createState() => _CookingAssistantItemState();
}

class _CookingAssistantItemState extends State<CookingAssistantItem>
    with TickerProviderStateMixin {
  bool open = false;
  var _controller = PageController(viewportFraction: 1);
  dynamic requestResponse;
  bool loaded = false;
  late Savemodel providedSavemodel =
      Provider.of<Savemodel>(context, listen: false);
  late Requestor providedRequestor =
      Provider.of<Requestor>(context, listen: false);

  late String id = widget.data?["id"] ?? "";
  late String name = widget.data?["name"] ?? "";

  late String description =
      widget.data?["description"] ?? "4 cups shredded chicken breast";
  late String thumbnail_url = widget.data?["thumbnail_url"] ??
      "https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";

  String ingredients = "";

  List<dynamic> directions = [];
  final ignore = SizedBox();

  late Widget animation = rive.RiveAnimation.asset(
    'assets/platter/like.riv',
    stateMachines: [
      providedSavemodel.likes.contains(id)
          ? 'State Machine 2'
          : 'State Machine 1'
    ],
    fit: BoxFit.contain,
  );

  late Widget animation1 = rive.RiveAnimation.asset(
    'assets/platter/bookmark.riv',
    stateMachines: [
      providedSavemodel.focus.contains(id)
          ? 'State Machine 2'
          : 'State Machine 1'
    ],
    fit: BoxFit.contain,
  );

  @override
  void initState() {
    // print(providedSavemodel.likes);
    // print(id);
    // TODO: implement initState

    if (thumbnail_url is List<dynamic>) {
      thumbnail_url = thumbnail_url[0];
    }
    if (name == "") {
      requesData();
      loaded = true;
    }
    super.initState();
  }

  void requesData({bool toggle = false}) {
    providedRequestor.addRequest(
        "recipe_id ${widget.data?["id"] ?? ""}",
        (CancellationToken token) =>
            RestClient().recipesDetail(widget.data?["id"] ?? ""),
        now: true);

    providedRequestor
        .waitRequest("recipe_id ${widget.data?["id"] ?? ""}")
        .then((resp) {
      final data = jsonDecode(resp.body)["recipe"];
      setState(() {
        id = data["recipe_id"] ?? "";
        name = data?["recipe_name"] ?? "Classic Chicken Noodle Soup";
        description = data?["recipe_description"] ?? "";
        var image = data?["recipe_images"]?["recipe_image"] ??
            "https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";

        if (image is List<dynamic>) {
          thumbnail_url = image[0];
        } else {
          thumbnail_url = image;
        }

        ingredients = (data?["ingredients"]?["ingredient"] ?? [])
            .map((e) => e["ingredient_description"])
            .join("\n");

        directions = data?["directions"]?["direction"] ?? [];
        if (toggle == true) {
          open = !open;
        }
      });
    });
  }

  void updateToNextId() {
    if (requestResponse?["recipe_id"] != null) {
      var itNeedsupdate =
          (requestResponse?["recipe_id"] != widget.data["id"]) &&
              (widget.data["id"] != null);
      if (itNeedsupdate) {
        requesData(toggle: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String query = widget.data?["query"];
    // if (widget.data?["name"] == null) {
    //   requesData();
    // }
    // updateToNextId();

    return FutureBuilder<Response>(
        initialData: providedRequestor
            .requestResponses["recipe_id ${widget.data?["id"] ?? ""}"]?[0],
        future: open == false
            ? name == ""
                ? providedRequestor
                    .waitRequest("recipe_id ${widget.data?["id"] ?? ""}")
                : null
            : providedRequestor
                .waitRequest("recipe_id ${widget.data?["id"] ?? ""}"),
        builder: (context, snap) {
          String? reqid, reqname, reqdescription, reqingredients;
          dynamic reqimage;
          List<dynamic> reqdirections = [];
          bool isInQuery = false;
          if (snap.hasData && snap.data!.body.contains("recipe_name")) {
            final data = jsonDecode(snap.data!.body)["recipe"];
            reqid = data["recipe_id"] ?? "";

            reqname = data?["recipe_name"];
            reqdescription = data?["recipe_description"];
            reqimage = data?["recipe_images"]?["recipe_image"] ??
                "https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";

            if (reqimage is List<dynamic>) {
              reqimage = reqimage[0];
            }

            reqingredients = (data?["ingredients"]?["ingredient"] ?? [])
                .map((e) => e["ingredient_description"])
                .join("\n");

            reqdirections = data?["directions"]?["direction"] ?? [];
            // requestResponse = jsonDecode(response.data!.body)["recipe"];
            isInQuery = snap.data!.body.contains(query);
          }

          return !isInQuery && query.isNotEmpty
              ? ignore
              : Stack(children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffD7D7D7))),
                    constraints: BoxConstraints(
                        minHeight: fontSizeNumber(0) * 4.577742699),
                    margin:
                        EdgeInsets.only(top: fontSizeNumber(0) * 0.789265983),
                    child: Slidable(
                        endActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const ScrollMotion(),
                          extentRatio: 0.30,
                          // A pane can dismiss the Slidable.

                          // All actions are defined in the children parameter.
                          children: [
                            // A SlidableAction can have an icon and/or a label.
                            // Expanded(
                            //     child: Container(
                            //   // color: Colors.red,
                            //   alignment: Alignment.center,
                            //   child: IconButton(
                            //     icon: SvgPicture.asset(
                            //       "assets/platter/delete.svg",
                            //       color: Color(0xFF000000),
                            //       height: fontSizeNumber(0) * 1.617995264,
                            //     ),
                            //     onPressed: () {
                            //       if (providedSavemodel.likes.contains(id)) {
                            //         providedSavemodel.removeLike(id);
                            //       } else {
                            //         providedSavemodel.addLike(id);
                            //       }
                            //     },
                            //   ),
                            // )),
                            SizedBox(
                              width: pixelNumberfromFigma(20),
                            ),
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
                                        providedSavemodel.addLike(id);
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
                              ),
                            ),
                            Expanded(
                              child: Transform.scale(
                                  scale: 1,
                                  child: SizedBox(
                                    width: pixelNumberfromFigma(21.73) /
                                        1.294642857,
                                    height: pixelNumberfromFigma(21.73),
                                    // color: Colors.amber,
                                    child: Container(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      child: TapRegion(
                                          onTapInside: (value) {
                                            providedSavemodel.addFocus(id);
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
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            if (loaded == false) {
                              requesData(toggle: true);
                              loaded = true;
                            } else {
                              setState(() {
                                open = !open;
                              });
                            }
                          },
                          child: AnimatedSize(
                              vsync: this,
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 250),
                              child: IntrinsicHeight(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                    !open
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                left: fontSizeNumber(0) *
                                                    0.789265983,
                                                right: fontSizeNumber(0) *
                                                    1.34175217,
                                                bottom: fontSizeNumber(0) *
                                                    0.868192581,
                                                top: fontSizeNumber(0) *
                                                    0.552486188),
                                            color: Color(0xFFCFCFCF),
                                            width:
                                                fontSizeNumber(0) * 2.999210734,
                                            constraints: const BoxConstraints(
                                                // minHeight: fontSizeNumber(0) * 4.577742699,
                                                ),
                                            child: Image.network(
                                              reqimage ?? thumbnail_url,
                                              fit: BoxFit.cover,
                                              height: fontSizeNumber(0) *
                                                  2.999210734,
                                            ),
                                          )
                                        : ignore,
                                    Flexible(
                                        flex: 1,
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight:
                                                fontSizeNumber(0) * 4.577742699,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: !open
                                                  ? 0
                                                  : fontSizeNumber(0) *
                                                      1.894238358,
                                              right: !open
                                                  ? 0
                                                  : fontSizeNumber(0) *
                                                      1.894238358,
                                              bottom: open
                                                  ? 0
                                                  : fontSizeNumber(0) *
                                                      0.584846093,
                                              top: !open
                                                  ? pixelNumberfromFigma(4.5)
                                                  : 0),
                                          child: Column(
                                            // mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              open
                                                  ? Container(
                                                      // color: Colors.blue[300],
                                                      height:
                                                          fontSizeNumber(0) *
                                                              2.683504341,
                                                      padding: EdgeInsets.only(
                                                          top:
                                                              pixelNumberfromFigma(
                                                                  1)),
                                                      child: Transform(
                                                          transform: Matrix4
                                                              .translationValues(
                                                                  0,
                                                                  1.341752166,
                                                                  0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    GradientTextspace(
                                                                  gradient: const LinearGradient(
                                                                      begin: Alignment
                                                                          .bottomCenter,
                                                                      end: Alignment
                                                                          .topCenter,
                                                                      colors: [
                                                                        Color.fromARGB(
                                                                            255,
                                                                            2,
                                                                            6,
                                                                            8),
                                                                        Color.fromARGB(
                                                                            255,
                                                                            2,
                                                                            14,
                                                                            31),
                                                                      ]),
                                                                  textspace:
                                                                      Textspace(
                                                                    text:
                                                                        "${reqname ?? name}",
                                                                    size:
                                                                        1.0001,
                                                                    headsize: 0,
                                                                    fixSize:
                                                                        true,
                                                                    fixProportion:
                                                                        1.5,
                                                                    style: GoogleFonts.inter(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        height:
                                                                            0),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    )
                                                  : Textspace(
                                                      text:
                                                          "${reqname ?? name}",
                                                      size: 1.0001,
                                                      headsize: 0,
                                                      fixSize: true,
                                                      fixProportion: 1.5,
                                                      style: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0),
                                                    ),
                                              !open
                                                  ? SizedBox(
                                                      height:
                                                          pixelNumberfromFigma(
                                                              10.33),
                                                    )
                                                  : ignore,
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      top: open
                                                          ? pixelNumberfromFigma(
                                                              10)
                                                          : 0),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: !open
                                                                  ? Colors
                                                                      .transparent
                                                                  : Color(
                                                                      0xFFF5F6F8)))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Flexible(
                                                        child:
                                                            GradientTextspace(
                                                          gradient: const LinearGradient(
                                                              begin: Alignment
                                                                  .bottomCenter,
                                                              end: Alignment
                                                                  .topCenter,
                                                              colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    2,
                                                                    6,
                                                                    8),
                                                                Color.fromARGB(
                                                                    255,
                                                                    2,
                                                                    14,
                                                                    31),
                                                              ]),
                                                          textspace: Textspace(
                                                              text: open
                                                                  ? "${reqingredients ?? ingredients}"
                                                                  : reqdescription ??
                                                                      description,
                                                              headsize: 0,
                                                              style:
                                                                  const TextStyle(
                                                                      height:
                                                                          1)),
                                                        ),
                                                      ),
                                                      open
                                                          ? Container(
                                                              height:
                                                                  pixelNumberfromFigma(
                                                                      75),
                                                              width:
                                                                  pixelNumberfromFigma(
                                                                      100),
                                                              child: Stack(
                                                                children: [
                                                                  Positioned
                                                                      .fill(
                                                                          child:
                                                                              Image.network(
                                                                    reqimage ??
                                                                        thumbnail_url,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    width:
                                                                        pixelNumberfromFigma(
                                                                            100),
                                                                    height:
                                                                        pixelNumberfromFigma(
                                                                            75),
                                                                  )),
                                                                  Positioned
                                                                      .fill(
                                                                    child: DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                          begin: Alignment
                                                                              .bottomCenter,
                                                                          end: Alignment
                                                                              .topCenter,
                                                                          colors: [
                                                                            const Color.fromARGB(255, 2, 6, 8).withOpacity(0.01),
                                                                            const Color.fromARGB(255, 2, 14, 31).withOpacity(0.01),
                                                                          ]),
                                                                    )),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          : ignore,
                                                    ],
                                                  )),
                                              open
                                                  ? Container(
                                                      // color: Colors.red[300],
                                                      child: SizedBox(
                                                          height:
                                                              fontSizeNumber(
                                                                      0) *
                                                                  7.75,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                child: PageView(
                                                                  padEnds:
                                                                      false,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  controller:
                                                                      _controller,
                                                                  children: [
                                                                    for (var direction
                                                                        in directions)
                                                                      Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: fontSizeNumber(0) *
                                                                                  1.262825572),
                                                                          alignment: Alignment
                                                                              .topLeft,
                                                                          child:
                                                                              GradientTextspace(
                                                                            gradient:
                                                                                const LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
                                                                              Color.fromARGB(255, 2, 6, 8),
                                                                              Color.fromARGB(255, 2, 14, 31),
                                                                            ]),
                                                                            textspace: Textspace(
                                                                                alignment: Alignment.topLeft,
                                                                                style: GoogleFonts.inter(fontWeight: FontWeight.w500, height: 1.1, color: const Color(0xFF1C1C1C), letterSpacing: fontSizeNumber(0) * 0.015),
                                                                                text: "Step ${directions.indexOf(direction) + 1}. ${direction["direction_description"]}"),
                                                                          )),
                                                                  ],
                                                                ),
                                                              ),
                                                              const IgnorePointer(
                                                                child: SizedBox(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    )
                                                  : ignore
                                            ],
                                          ),
                                        ))
                                  ]))),
                        )),
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
                ]);
        });
  }
}
