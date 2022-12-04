import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Builder/Future/CookingItem0FutureBuilder.dart';
import 'package:p_l_atter/Components/Loadingscreen.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Preferencesmodel.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/GraphQl/tell.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:cancellation_token_http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Categoryscreen extends StatelessWidget {
  Categoryscreen({Key? key}) : super(key: key);

  dynamic o = {
    "Breakfast": ["Egg", "Bread", "Beans"],
    "Dessert": ["Cream", "Chocolate", "Pudding"],
    "Baked": ["Bread", "Cake", "Pizza"],
    "Beverage": ["Smoothie", "Juice", "Shake"],
    "Lunch": ["Meat", "Pasta", "Sandwich"],
    "Main Dish": ["Stir-Fry", "Burger", "Mexican"],
    "Salad and Salad Dressing": ["Vegetable", "Fruit", "Bean"],
    "Sauce and Condiment": ["Sauce", "Dressing", "Salsa"],
    "Side Dish": ["Condiments", "Meat Marinade", "Tomato Sauce"],
    "Snack": ["Dip & Spreads Snack", "Sweet Snack", "Salty Snack"],
    "Soup": ["Vegetable", "Bean", "Soup"],
    "Appetizer": ["Roll", "Cheese", "Fried"],
    "Other": ["", "", ""]
  };

  @override
  Widget build(BuildContext context) {
    var preferencesModel =
        Provider.of<Preferencesmodel>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 320 / 74,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: pixelNumberfromFigma(15),
                          right: pixelNumberfromFigma(28)),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Textspace(
                              text: preferencesModel.categoryScreen,
                              size: 2,
                              headsize: 0.001,
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                          // Image.asset(
                          //   "assets/platter/smile.png",
                          //   width: PixelNumberfromFigma(20),
                          //   color: Color(0xFF3C3C3C),
                          // )
                        ],
                      )),
                ),
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
                            text: o[preferencesModel.categoryScreen][0],
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
                Consumer<Requestor>(builder: (context, requestor, widget) {
                  return CookingItem0FutureBuilder(
                      readJson: () => requestor.waitRequest(
                          "${preferencesModel.categoryScreen} ${o[preferencesModel.categoryScreen][0]}"));
                }),
                Container(
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: (BorderSide(
                                  color: Color(0xFFEDEDED), width: 1)))),
                    ),
                  ]),
                ),
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
                            text: o[preferencesModel.categoryScreen][1],
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
                Consumer<Requestor>(builder: (context, requestor, widget) {
                  return CookingItem0FutureBuilder(
                      readJson: () => requestor.waitRequest(
                          "${preferencesModel.categoryScreen} ${o[preferencesModel.categoryScreen][1]}"));
                }),
                Container(
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                          border: Border(
                              top: (BorderSide(
                                  color: Color(0xFFEDEDED), width: 1)))),
                    ),
                  ]),
                ),
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
                            text: o[preferencesModel.categoryScreen][2],
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
                Consumer<Requestor>(builder: (context, requestor, widget) {
                  return CookingItem0FutureBuilder(
                      readJson: () => requestor.waitRequest(
                          "${preferencesModel.categoryScreen} ${o[preferencesModel.categoryScreen][2]}"));
                }),
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

            // Consumer<Requestor>(builder: (context, requestor, widget) {
            //   return Loadingscreen(
            //     seconds: 3,
            //     white: !((requestor
            //                     .requestResponses[
            //                         "${preferencesModel.categoryScreen} ${o[preferencesModel.categoryScreen][0]}"]
            //                     ?.keys ??
            //                 [])
            //             .isNotEmpty &&
            //         (requestor
            //                     .requestResponses[
            //                         "${preferencesModel.categoryScreen} ${o[preferencesModel.categoryScreen][1]}"]
            //                     ?.keys ??
            //                 [])
            //             .isNotEmpty &&
            //         (requestor
            //                     .requestResponses[
            //                         "${preferencesModel.categoryScreen} ${o[preferencesModel.categoryScreen][2]}"]
            //                     ?.keys ??
            //                 [])
            //             .isNotEmpty),
            //   );
            // }),
          ],
        ));
  }
}
