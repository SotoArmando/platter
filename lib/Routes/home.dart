import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Builder/CookingItem0.dart';
import 'package:p_l_atter/Components/Builder/Future/CookingItem0FutureBuilder.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Loadingscreen.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/GraphQl/tell.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:cancellation_token_http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  var token = http.CancellationToken();
  late Future<http.Response> data;
  var myfatsecret;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
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
                        Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                        Color.fromARGB(255, 255, 255, 255).withOpacity(0.005),
                        Color.fromARGB(255, 255, 255, 255).withOpacity(0.005),
                        Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                      ]),
                ),
                child: SingleChildScrollView(
                  child: Column(children: [
                    AspectRatio(
                      aspectRatio: 320 / 38,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: PixelNumberfromFigma(15),
                              right: PixelNumberfromFigma(28)),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Textspace(
                                size: 2,
                                text: "",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000)),
                              ),
                              // Image.asset(
                              //   "assets/platter/smile.png",
                              //   width: PixelNumberfromFigma(20),
                              //   color: Color(0xFF000000),
                              // )
                            ],
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: PixelNumberfromFigma(15),
                            right: PixelNumberfromFigma(15)),
                        alignment: Alignment.bottomLeft,
                        height: PixelNumberfromFigma(56),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                alignment: Alignment.bottomLeft,
                                size: 2,
                                text: "Good evening\nRecently",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF000000),
                                  height: (MediaQuery.of(context).size.width /
                                          8.421052632) /
                                      fontSizeNumber(2),
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: PixelNumberfromFigma(0)),
                                  alignment: Alignment.topCenter,
                                  width: PixelNumberfromFigma(30),
                                  child: InkWell(
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
                                        "assets/platter/notify.svg",
                                        color: Colors.black,
                                        height: fontSizeNumber(0) *
                                            1.617995264 *
                                            1.030,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: PixelNumberfromFigma(20),
                                ),
                                Container(
                                  width: PixelNumberfromFigma(30),
                                  padding: EdgeInsets.only(
                                      top: PixelNumberfromFigma(0)),
                                  alignment: Alignment.topCenter,
                                  child: InkWell(
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
                                        "assets/platter/history.svg",
                                        color: Colors.black,
                                        height: fontSizeNumber(0) * 1.617995264,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: PixelNumberfromFigma(18),
                                ),
                                Container(
                                  width: PixelNumberfromFigma(30),
                                  padding: EdgeInsets.only(
                                      top: PixelNumberfromFigma(0)),
                                  alignment: Alignment.topCenter,
                                  child: InkWell(
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
                                        "assets/platter/setting.svg",
                                        color: Colors.black,
                                        height: fontSizeNumber(0) * 1.617995264,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    SizedBox(
                      height: PixelNumberfromFigma(10),
                    ),

                    Consumer<Requestor>(builder: (context, requestor, widget) {
                      return CookingItem0FutureBuilder(
                        readJson: () => requestor.waitRequest("home0"),
                      );
                    }),
                    // Container(
                    //   // color: Colors.red[300],
                    //   // height: fontSizeNumber(4),
                    //   child: Stack(alignment: Alignment.center, children: [
                    //     Container(
                    //       height: 1,
                    //       decoration: BoxDecoration(
                    //           border: Border(
                    //               top: (BorderSide(
                    //                   color: Color(0xFFEDEDED),
                    //                   width: PixelNumberfromFigma(1))))),
                    //     ),
                    //     // Container(
                    //     //   height: fontSizeNumber(0) * 1.617995264,
                    //     //   width: fontSizeNumber(0) * 1.617995264,
                    //     //   child: Stack(
                    //     //     alignment: Alignment.center,
                    //     //     children: [
                    //     //       SvgPicture.asset("assets/platter/whiteFrame.svg"),
                    //     //       Container(
                    //     //           constraints: BoxConstraints(
                    //     //             maxHeight: fontSizeNumber(2),
                    //     //             maxWidth: fontSizeNumber(2),
                    //     //           ),
                    //     //           decoration: BoxDecoration(
                    //     //               color: Colors.white,
                    //     //               shape: BoxShape.circle,
                    //     //               border: Border.all(
                    //     //                   width: sqrt(sqrt(sqrt(fontSizeNumber(0)))),
                    //     //                   color: Color(0xFFE2E2E2)))),
                    //     //       Container(
                    //     //           constraints: BoxConstraints(
                    //     //             maxHeight: fontSizeNumber(1),
                    //     //             maxWidth: fontSizeNumber(1),
                    //     //           ),
                    //     //           decoration: BoxDecoration(
                    //     //               // color: Colors.white,
                    //     //               shape: BoxShape.circle,
                    //     //               border: Border.all(
                    //     //                   width: sqrt(sqrt(sqrt(fontSizeNumber(0)))),
                    //     //                   color: Color(0xFFE2E2E2))))
                    //     //     ],
                    //     //   ),
                    //     // ),
                    //   ]),
                    // ),
                    Consumer<Requestor>(builder: (context, requestor, widget) {
                      return CookingItem0FutureBuilder(
                          readJson: () => requestor.waitRequest("home1"));
                    }),

                    // Container(
                    //   // color: Colors.red[300],
                    //   // height: fontSizeNumber(4),
                    //   child: Stack(alignment: Alignment.center, children: [
                    //     Container(
                    //       height: 1,
                    //       decoration: BoxDecoration(
                    //           border: Border(
                    //               top: (BorderSide(
                    //                   color: Color(0xFFEDEDED), width: 1)))),
                    //     ),
                    //     // Container(
                    //     //   height: fontSizeNumber(2),
                    //     //   width: fontSizeNumber(2),
                    //     //   child: Stack(
                    //     //     alignment: Alignment.center,
                    //     //     children: [
                    //     //       SvgPicture.asset("assets/platter/whiteFrame.svg"),
                    //     //       Container(
                    //     //           constraints: BoxConstraints(
                    //     //             maxHeight: fontSizeNumber(2),
                    //     //             maxWidth: fontSizeNumber(2),
                    //     //           ),
                    //     //           decoration: BoxDecoration(
                    //     //               color: Colors.white,
                    //     //               shape: BoxShape.circle,
                    //     //               border: Border.all(
                    //     //                   width: sqrt(sqrt(sqrt(fontSizeNumber(0)))),
                    //     //                   color: Color(0xFFE2E2E2)))),
                    //     //       Container(
                    //     //           constraints: BoxConstraints(
                    //     //             maxHeight: fontSizeNumber(1),
                    //     //             maxWidth: fontSizeNumber(1),
                    //     //           ),
                    //     //           decoration: BoxDecoration(
                    //     //               // color: Colors.white,
                    //     //               shape: BoxShape.circle,
                    //     //               border: Border.all(
                    //     //                   width: sqrt(sqrt(sqrt(fontSizeNumber(0)))),
                    //     //                   color: Color(0xFFE2E2E2))))
                    //     //     ],
                    //     //   ),
                    //     // ),
                    //   ]),
                    // ),
                    AspectRatio(
                      aspectRatio: 320 / 38,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: PixelNumberfromFigma(15),
                              right: PixelNumberfromFigma(28)),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  size: 2,
                                  text: "More Content",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF000000)),
                                ),
                              ),
                              // Image.asset(
                              //   "assets/platter/smile.png",
                              //   width: PixelNumberfromFigma(20),
                              //   color: Color(0xFF000000),
                              // )
                            ],
                          )),
                    ),
                    Consumer<Requestor>(builder: (context, requestor, widget) {
                      return CookingItem0FutureBuilder(
                          readJson: () => requestor.waitRequest("home2"));
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/platter/play_store_512.png",
                          width: fontSizeNumber(0) * 3.022099448,
                        ),
                        SizedBox(
                          width: fontSizeNumber(0) * 0.845303867,
                        ),
                        SizedBox(
                            width: fontSizeNumber(0) * 10.339384373,
                            height: fontSizeNumber(0) * 4.130228887,
                            child: Column(
                              children: [
                                GradientTextspace(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color.fromARGB(255, 2, 6, 8),
                                        Color.fromARGB(255, 2, 14, 31),
                                      ]),
                                  textspace: Column(children: [
                                    Textspace(
                                      headsize: 0.0001,
                                      text: "\nSweet Breakfast",
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Textspace(
                                      text: "Platter",
                                      headsize: 0.0001,
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: fontSizeNumber(0) * 0.507498027,
                    ),
                    Consumer<Requestor>(builder: (context, requestor, widget) {
                      return CookingItem0FutureBuilder(
                          readJson: () => requestor.waitRequest("home3"));
                    }),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/platter/play_store_512.png",
                          width: fontSizeNumber(0) * 3.022099448,
                        ),
                        SizedBox(
                          width: fontSizeNumber(0) * 0.845303867,
                        ),
                        SizedBox(
                            width: fontSizeNumber(0) * 10.339384373,
                            height: fontSizeNumber(0) * 4.130228887,
                            child: Column(
                              children: [
                                Textspace(
                                  headsize: 0.0001,
                                  text: "\nLunch",
                                ),
                                Textspace(
                                  text: "Platter",
                                  headsize: 0.0001,
                                  style: GoogleFonts.inter(
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: fontSizeNumber(0) * 0.507498027,
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
                                child: Text("Powered by FatSecret"),
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
                  ]),
                )),
            Consumer<Requestor>(builder: (context, requestor, widget) {
              return Loadingscreen(
                white: !((requestor.requestResponses["home0"]?.keys ?? [])
                        .isNotEmpty &&
                    (requestor.requestResponses["home1"]?.keys ?? [])
                        .isNotEmpty &&
                    (requestor.requestResponses["home2"]?.keys ?? [])
                        .isNotEmpty),
              );
            }),
          ],
        ));
  }
}
