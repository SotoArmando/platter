import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data?["name"] == null) {
      requesData();
    }
  }

  void requesData() {
    RestClient().recipesDetail(widget.data?["id"] ?? "").then((Response) {
      dynamic data = [];
      try {
        data = jsonDecode(Response.body ?? "{}")["recipe"];
      } catch (e) {}

      setState(() {
        requestResponse = data;
        loaded = true;
      });
    });
  }

  void updateToNextId() {
    if (requestResponse?["recipe_id"] != null) {
      var itNeedsupdate =
          (requestResponse?["recipe_id"] != widget.data["id"]) &&
              (widget.data["id"] != null);
      if (itNeedsupdate) {
        requesData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.data?["id"] ?? "";
    String name = requestResponse?["recipe_name"] ??
        widget.data?["name"] ??
        "Classic Chicken Noodle Soup";
    var description = requestResponse?["recipe_description"] ??
        widget.data?["description"] ??
        "4 cups shredded chicken breast";
    var thumbnail_url = requestResponse?["recipe_images"]?["recipe_image"] ??
        widget.data?["thumbnail_url"] ??
        "https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";

    final ingredients = ((requestResponse?["ingredients"]?["ingredient"] ?? [])
            as List<dynamic>)
        .map((e) => e["ingredient_description"])
        .join("\n");

    final directions =
        ((requestResponse?["directions"]?["direction"] ?? []) as List<dynamic>);
    updateToNextId();
    return Consumer<Savemodel>(builder: (context, providedSavemodel, child) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(border: Border.all(color: Color(0xffD7D7D7))),
        constraints: BoxConstraints(minHeight: fontSizeNumber(0) * 4.577742699),
        margin: EdgeInsets.only(top: fontSizeNumber(0) * 0.789265983),
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
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    providedSavemodel.addLike(id);
                  },
                  child: SvgPicture.asset(
                    providedSavemodel.likes.contains(id)
                        ? "assets/platter/like_outlined.svg"
                        : "assets/platter/like.svg",
                    color: Colors.black,
                    height: PixelNumberfromFigma(21.73),
                  ),
                ),
                Expanded(
                    child: Container(
                  // color: Colors.red,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      (providedSavemodel.focus.contains(id))
                          ? "assets/platter/bookmark_filled.svg"
                          : "assets/platter/bookmark.svg",
                      color: Color(0xFF000000),
                      height: fontSizeNumber(0) * 1.617995264,
                    ),
                    onPressed: () {
                      if (providedSavemodel.focus.contains(id)) {
                        providedSavemodel.removeFocus(id);
                      } else {
                        providedSavemodel.addFocus(id);
                      }
                    },
                  ),
                )),
              ],
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (loaded == false) {
                    requesData();
                  }
                  open = !open;
                });
              },
              child: AnimatedSize(
                  vsync: this,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 250),
                  child: IntrinsicHeight(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                        !open
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: fontSizeNumber(0) * 0.789265983,
                                    right: fontSizeNumber(0) * 1.34175217,
                                    bottom: fontSizeNumber(0) * 0.868192581,
                                    top: fontSizeNumber(0) * 0.552486188),
                                color: Color(0xFFCFCFCF),
                                width: fontSizeNumber(0) * 2.999210734,
                                constraints: BoxConstraints(
                                    // minHeight: fontSizeNumber(0) * 4.577742699,
                                    ),
                                child: Image.network(
                                  thumbnail_url,
                                  fit: BoxFit.cover,
                                  height: fontSizeNumber(0) * 2.999210734,
                                ),
                              )
                            : SizedBox(),
                        Flexible(
                            flex: 1,
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: fontSizeNumber(0) * 4.577742699,
                              ),
                              padding: EdgeInsets.only(
                                  left: !open
                                      ? 0
                                      : fontSizeNumber(0) * 1.894238358,
                                  right: !open
                                      ? 0
                                      : fontSizeNumber(0) * 1.894238358,
                                  bottom: open
                                      ? 0
                                      : fontSizeNumber(0) * 0.584846093,
                                  top: !open ? PixelNumberfromFigma(4.5) : 0),
                              child: Column(
                                // mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  open
                                      ? Container(
                                          // color: Colors.blue[300],
                                          height:
                                              fontSizeNumber(0) * 2.683504341,
                                          padding: EdgeInsets.only(
                                              top: PixelNumberfromFigma(1)),
                                          child: Transform(
                                              transform:
                                                  Matrix4.translationValues(
                                                      0, 1.341752166, 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: GradientTextspace(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                          colors: [
                                                            Color.fromARGB(
                                                                255, 2, 6, 8),
                                                            Color.fromARGB(
                                                                255, 2, 14, 31),
                                                          ]),
                                                      textspace: Textspace(
                                                        text: "$name",
                                                        size: 1.0001,
                                                        headsize: 0,
                                                        fixSize: true,
                                                        fixProportion: 1.5,
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 0),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        )
                                      : Textspace(
                                          text: name,
                                          size: 1.0001,
                                          headsize: 0,
                                          fixSize: true,
                                          fixProportion: 1.5,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              height: 0),
                                        ),
                                  !open
                                      ? SizedBox(
                                          height: PixelNumberfromFigma(10.33),
                                        )
                                      : SizedBox(),
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: open
                                              ? PixelNumberfromFigma(10)
                                              : 0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: !open
                                                      ? Colors.transparent
                                                      : Color(0xFFF5F6F8)))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: GradientTextspace(
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 2, 6, 8),
                                                    Color.fromARGB(
                                                        255, 2, 14, 31),
                                                  ]),
                                              textspace: Textspace(
                                                  text: open
                                                      ? "$ingredients"
                                                      : description,
                                                  headsize: 0,
                                                  style: TextStyle(height: 1)),
                                            ),
                                          ),
                                          open
                                              ? Container(
                                                  height:
                                                      PixelNumberfromFigma(75),
                                                  width:
                                                      PixelNumberfromFigma(100),
                                                  child: Stack(
                                                    children: [
                                                      Positioned.fill(
                                                          child: Image.network(
                                                        thumbnail_url,
                                                        fit: BoxFit.contain,
                                                        width:
                                                            PixelNumberfromFigma(
                                                                100),
                                                        height:
                                                            PixelNumberfromFigma(
                                                                75),
                                                      )),
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
                                                        )),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      )),
                                  open
                                      ? Container(
                                          // color: Colors.red[300],
                                          child: SizedBox(
                                              height: fontSizeNumber(0) * 7.75,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    child: PageView(
                                                      padEnds: false,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      controller: _controller,
                                                      children: [
                                                        for (var direction
                                                            in directions)
                                                          Container(
                                                              padding: EdgeInsets.only(
                                                                  top: fontSizeNumber(
                                                                          0) *
                                                                      1.262825572),
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child:
                                                                  GradientTextspace(
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
                                                                          8),
                                                                      Color.fromARGB(
                                                                          255,
                                                                          2,
                                                                          14,
                                                                          31),
                                                                    ]),
                                                                textspace: Textspace(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    style: GoogleFonts.inter(
                                                                        fontWeight: FontWeight
                                                                            .w500,
                                                                        height:
                                                                            1.1,
                                                                        color: Color(
                                                                            0xFF1C1C1C),
                                                                        letterSpacing:
                                                                            fontSizeNumber(0) *
                                                                                0.015),
                                                                    text:
                                                                        "Step ${directions.indexOf(direction) + 1}. ${direction["direction_description"]}"),
                                                              )),
                                                      ],
                                                    ),
                                                  ),
                                                  IgnorePointer(
                                                    child: Container(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ))
                      ]))),
            )),
      );
    });
  }
}
