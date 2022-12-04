import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Loaduntil.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Recipeid.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:p_l_atter/main.dart';
import 'package:provider/provider.dart';
import 'package:cancellation_token_http/http.dart' as http;

class Appdrawer extends StatefulWidget {
  Appdrawer({Key? key}) : super(key: key);

  @override
  _AppdrawerState createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  late Recipeid providedRecipeId =
      Provider.of<Recipeid>(context, listen: false);
  late Loaduntil providedLoaduntil =
      Provider.of<Loaduntil>(context, listen: false);
  late Requestor providedRequestor =
      Provider.of<Requestor>(context, listen: false);
  late Savemodel saveModel = Provider.of<Savemodel>(context, listen: false);
  late double height = MediaQuery.of(context).viewPadding.top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(children: [
          SizedBox(
            height: height,
          ),
          Padding(
            padding: EdgeInsets.only(left: pixelNumberfromFigma(15)),
            child: SizedBox(
              height: pixelNumberfromFigma(118),
              child: Column(
                children: [
                  for (var i in [0])
                    Expanded(
                        child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Textspace(
                              headsize: 0.00001,
                              text: "Platter app beta release",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  height: 1.183898974,
                                  fontSize: fontSizeNumber(0),
                                  color: const Color(0xFF000000)),
                            ),
                            Textspace(
                              headsize: 0.00001,
                              text: "@sotoarmando",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  height: 1.183898974,
                                  fontSize: fontSizeNumber(0),
                                  color: const Color(0xFF000000)),
                            ),
                          ]),
                    )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: pixelNumberfromFigma(16),
          ),
          // Text("${saveModel.userHistory}"),
          Container(
            child: SizedBox(
              height: pixelNumberfromFigma(106 + 23 + 30),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                SizedBox(
                  width: pixelNumberfromFigma(15),
                ),
                FutureBuilder<http.Response>(
                  future: providedRequestor.waitRequest("history"),
                  initialData: providedRequestor.requestResponses["history"]![
                      providedRequestor.loadingrequests["history"]!.keys.last],
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.done &&
                        snap.hasData &&
                        "${jsonDecode(snap.data!.body)["error"]}" == "null") {
                      dynamic data = [];
                      try {
                        data = jsonDecode(snap.data?.body ?? "{}")["recipes"]
                            ["recipe"];

                        if (data is List<dynamic>) {
                          data.sort((a, b) => saveModel.userHistory
                              .indexOf(a["recipe_id"])
                              .compareTo(saveModel.userHistory
                                  .indexOf(b["recipe_id"])));
                        } else {
                          data = [data];
                        }
                      } catch (e) {}

                      return Row(
                        children: [
                          for (var i in data.reversed)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Container(
                                    width: fontSizeNumber(0) * 7.717285714,
                                    child: Column(
                                      children: [
                                        Container(
                                            // decoration: BoxDecoration(
                                            //     // color: Colors.blue[300],
                                            //     border: Border(
                                            //         top: BorderSide(color: Color(0xffF4F4F4)))),
                                            // color: Colors.amber[300],
                                            constraints: BoxConstraints(
                                                minHeight: fontSizeNumber(0) *
                                                    2.683504341),
                                            // padding: EdgeInsets.only(bottom: fontSizeNumberMini(0)),
                                            alignment: Alignment.bottomLeft,
                                            child: Stack(
                                              children: [
                                                Textspace(
                                                  text: i["recipe_name"],
                                                  height: fontSizeNumber(0.9),
                                                  maxLines: 2,
                                                  headsize: 0.0003,
                                                  alignment: Alignment.topLeft,
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.183898974,
                                                      fontSize:
                                                          fontSizeNumber(0),
                                                      color: const Color(
                                                          0xFF000000)),
                                                ),
                                              ],
                                            )),
                                        AspectRatio(
                                          aspectRatio: 83 / 91,
                                          child: Image.network(
                                            i["recipe_image"],
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    final id = i["recipe_id"];
                                    providedRecipeId.update(id);
                                    providedRequestor.addRequest(
                                        "addhistory${DateTime.now().millisecondsSinceEpoch}",
                                        (http.CancellationToken token) =>
                                            RestClient().addFavoriteToProfile(
                                              saveModel.history["auth_token"]!,
                                              saveModel.history["auth_secret"]!,
                                              id,
                                            ),
                                        now: true);

                                    providedRequestor.addRequest(
                                        "recipe_id $id",
                                        (http.CancellationToken token) =>
                                            RestClient().recipesDetail(id),
                                        now: true);

                                    final waitall = Future.wait([
                                      providedRequestor
                                          .waitRequest("recipe_id $id"),
                                      providedRequestor.waitRequest(
                                          "addhistory${DateTime.now().millisecondsSinceEpoch}")
                                    ]);

                                    providedLoaduntil.loaduntil(() => waitall);

                                    waitall.whenComplete(() {
                                      navigatorKey.currentState!
                                          .pushNamed("/details");
                                    });

                                    scaffoldKey.currentState!.closeDrawer();
                                  },
                                ),
                                SizedBox(
                                  width: pixelNumberfromFigma(15),
                                )
                              ],
                            )
                        ],
                      );
                    }

                    return Text("loading");
                  },
                ),
              ]),
            ),
          ),
          // InkWell(
          //   child: Container(
          //     padding: EdgeInsets.only(left: pixelNumberfromFigma(15)),
          //     alignment: Alignment.centerLeft,
          //     height: pixelNumberfromFigma(56),
          //     child: Text("Rive test"),
          //   ),
          //   onTap: () {
          //     scaffoldKey.currentState!.closeDrawer();
          //     Navigator.of(navigatorKey.currentContext!).pushNamed("/test");
          //   },
          // ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: pixelNumberfromFigma(15)),
              alignment: Alignment.centerLeft,
              height: pixelNumberfromFigma(56),
              child: Text(
                "About",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    height: 1.183898974,
                    fontSize: fontSizeNumber(0),
                    color: const Color(0xFF000000)),
              ),
            ),
            onTap: () {
              scaffoldKey.currentState!.closeDrawer();
              Navigator.of(navigatorKey.currentContext!).pushNamed("/about");
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: pixelNumberfromFigma(15)),
              alignment: Alignment.centerLeft,
              height: pixelNumberfromFigma(56),
              child: Text(
                "Sign out",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    height: 1.183898974,
                    fontSize: fontSizeNumber(0),
                    color: const Color(0xFF000000)),
              ),
            ),
            onTap: () {
              scaffoldKey.currentState!.closeDrawer();
              saveModel.clearSavePath();
              Navigator.of(navigatorKey.currentContext!).pushNamed("/welcome");
            },
          ),
        ]),
      ),
    );
  }
}

//  SizedBox(
//           height: PixelNumberfromFigma(118),
//           child: Column(children: [
//             for (var i in [1, 2])
//               Expanded(
//                   child: Container(
//                 child: Column(children: [
//                   Textspace(
//                     text: "Great news: new feature",
//                   ),
//                   Textspace(
//                     text: "Great news: new devblog",
//                   ),
//                 ]),
//               )),
//             SizedBox(
//               height: PixelNumberfromFigma(16),
//             ),
//             SizedBox(
//               height: PixelNumberfromFigma(106 + 23),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       for (var i in [1, 2, 3, 4])
//                         Column(
//                           children: [
//                             Textspace(
//                               text: "recipe_name",
//                             ),
//                             AspectRatio(
//                               aspectRatio: 83 / 91,
//                               child: Container(color: Colors.red),
//                             )
//                           ],
//                         )
//                     ]),
//               ),
//             )
//           ]),
//         )
