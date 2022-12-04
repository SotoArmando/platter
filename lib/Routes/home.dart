import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Builder/Future/CookingItem0FutureBuilder.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Loadingscreen.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:cancellation_token_http/http.dart' as http;
import 'package:p_l_atter/main.dart';
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
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //       begin: Alignment.bottomCenter,
                //       end: Alignment.topCenter,
                //       stops: const [
                //         0,
                //         .10,
                //         .90,
                //         1
                //       ],
                //       colors: [
                //         const Color.fromARGB(255, 255, 0, 150)
                //             .withOpacity(0.005),
                //         const Color.fromARGB(255, 255, 255, 255)
                //             .withOpacity(0.005),
                //         const Color.fromARGB(255, 255, 255, 255)
                //             .withOpacity(0.005),
                //         const Color.fromARGB(255, 255, 0, 150)
                //             .withOpacity(0.005),
                //       ]),
                // ),
                child: SingleChildScrollView(
              child: Column(children: [
                AspectRatio(
                  aspectRatio: 320 / 38,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: pixelNumberfromFigma(15),
                          right: pixelNumberfromFigma(28)),
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
                        left: pixelNumberfromFigma(15),
                        right: pixelNumberfromFigma(15)),
                    alignment: Alignment.bottomLeft,
                    height: pixelNumberfromFigma(56),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GradientTextspace(
                          gradient: const LinearGradient(
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
                              color: const Color(0xFF000000),
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
                              padding:
                                  EdgeInsets.only(top: pixelNumberfromFigma(0)),
                              alignment: Alignment.topCenter,
                              width: pixelNumberfromFigma(30),
                              child: InkWell(
                                child: GradientTextspace(
                                  gradient: const LinearGradient(
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
                                    height:
                                        fontSizeNumber(0) * 1.617995264 * 1.030,
                                  ),
                                ),
                                onTap: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                              ),
                            ),
                            SizedBox(
                              width: pixelNumberfromFigma(20),
                            ),
                            Container(
                              width: pixelNumberfromFigma(30),
                              padding:
                                  EdgeInsets.only(top: pixelNumberfromFigma(0)),
                              alignment: Alignment.topCenter,
                              child: InkWell(
                                child: GradientTextspace(
                                  gradient: const LinearGradient(
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
                                onTap: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                              ),
                            ),
                            SizedBox(
                              width: pixelNumberfromFigma(19),
                            ),
                            Container(
                              width: pixelNumberfromFigma(30),
                              padding:
                                  EdgeInsets.only(top: pixelNumberfromFigma(0)),
                              alignment: Alignment.topCenter,
                              child: InkWell(
                                child: GradientTextspace(
                                  gradient: const LinearGradient(
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
                                onTap: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: pixelNumberfromFigma(10),
                ),
                Consumer<Requestor>(builder: (context, requestor, widget) {
                  return CookingItem0FutureBuilder(
                    readJson: () => requestor.waitRequest("home0"),
                  );
                }),
                Consumer<Requestor>(builder: (context, requestor, widget) {
                  return CookingItem0FutureBuilder(
                      readJson: () => requestor.waitRequest("home1"));
                }),
                AspectRatio(
                  aspectRatio: 320 / 38,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: pixelNumberfromFigma(15),
                          right: pixelNumberfromFigma(28)),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientTextspace(
                            gradient: const LinearGradient(
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
                              gradient: const LinearGradient(
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
                            const Textspace(
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
                                  "https://platform.fatsecret.com"))) {
                                await launchUrl(
                                    Uri.parse("https://platform.fatsecret.com"),
                                    mode: LaunchMode.externalApplication);
                              } else {
                                // can't launch url, there is some error
                                throw "Could not launch https: //platform.fatsecret.com";
                              }
                            })
                      ],
                    ))
              ]),
            )),
            // Consumer<Requestor>(builder: (context, requestor, widget) {
            //   return Loadingscreen(
            //     white: !((requestor.requestResponses["home0"]?.keys ?? [])
            //             .isNotEmpty &&
            //         (requestor.requestResponses["home1"]?.keys ?? [])
            //             .isNotEmpty &&
            //         (requestor.requestResponses["home2"]?.keys ?? [])
            //             .isNotEmpty),
            //   );
            // }),
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
          ],
        ));
  }
}
