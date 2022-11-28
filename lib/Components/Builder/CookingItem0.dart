import 'dart:math';

import 'package:cancellation_token_http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Recipeid.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';

class Cookingitem0 extends StatelessWidget {
  final data;
  const Cookingitem0({Key? key, dynamic this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = data?["recipe_id"] ?? "Empty";
    final String name = data?["recipe_name"] ?? "Empty";

    final String description = data?["recipe_description"] ?? "Empty";
    final String thumbnail_url = data?["recipe_image"] ??
        "https://static.vecteezy.com/system/resources/previews/004/141/669/original/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";

    var providedRequestor = Provider.of<Requestor>(context);
    return Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   width: fontSizeNumber(0) * 1.183898974,
          // ),

          InkWell(
            onTap: () {
              Provider.of<Recipeid>(context, listen: false).update(id);
              providedRequestor.addRequest("recipe_id $id",
                  (CancellationToken token) => RestClient().recipesDetail(id),
                  now: true);
              Navigator.pushNamed(context, '/details');
            },
            child: Container(
              // color: Colors.red[300],
              alignment: Alignment.center,
              width: fontSizeNumber(0) * 7.717285714,

              // constraints: BoxConstraints(minHeight: fontSizeNumber(0) * 10.397790055),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      // decoration: BoxDecoration(
                      //     // color: Colors.blue[300],
                      //     border: Border(
                      //         top: BorderSide(color: Color(0xffF4F4F4)))),
                      // color: Colors.amber[300],
                      constraints: BoxConstraints(
                          minHeight: fontSizeNumber(0) * 2.683504341),
                      // padding: EdgeInsets.only(bottom: fontSizeNumberMini(0)),
                      alignment: Alignment.bottomLeft,
                      child: Stack(
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
                              text: name,
                              height: fontSizeNumber(0.9),
                              maxLines: 2,
                              headsize: 0.0003,
                              alignment: Alignment.topLeft,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  height: 1.183898974,
                                  fontSize: fontSizeNumber(0),
                                  color: Color(0xFF000000)),
                            ),
                          ),
                        ],
                      )),

                  AspectRatio(
                      aspectRatio: 1 / (sqrt(sqrt(1.61803398875))),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              thumbnail_url,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color.fromARGB(255, 2, 6, 8)
                                        .withOpacity(0.01),
                                    Color.fromARGB(255, 2, 14, 31)
                                        .withOpacity(0.01),
                                  ]),
                            )),
                          )
                        ],
                      ))

                  // Textspace(
                  //     text:
                  //         "This is a good description so we can work later."),
                ],
              ),
            ),
          ),

          SizedBox(
            width: fontSizeNumber(0) * 1.183898974,
          ),
        ]);
  }
}
