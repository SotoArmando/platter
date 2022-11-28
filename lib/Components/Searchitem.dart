import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Preferencesmodel.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';
import 'package:cancellation_token_http/http.dart' as http;

class Searchitem extends StatefulWidget {
  final String title;
  final Color mycolor;
  Searchitem({Key? key, this.title = "", this.mycolor = Colors.transparent})
      : super(key: key);

  @override
  _SearchitemState createState() => _SearchitemState();
}

class _SearchitemState extends State<Searchitem> {
  Map<String, List<String>> o = {
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
    // "Other": ["", "", ""]
  };

  @override
  Widget build(BuildContext context) {
    var preferencesModel =
        Provider.of<Preferencesmodel>(context, listen: false);

    var providedRequestor = Provider.of<Requestor>(context);

    return Expanded(
        child: Material(
      elevation: 0,
      color: widget.mycolor,
      child: InkWell(
          splashColor: Colors.amber[100],
          onTap: () {
            preferencesModel.update(widget.title);

            for (String value in o[widget.title]!) {
              providedRequestor.addRequest(
                  "${widget.title} $value",
                  (http.CancellationToken token) => RestClient().recipesSearch(
                      value,
                      recipe_type: widget.title,
                      canceltoken: token),
                  now: true);
            }

            Navigator.pushNamed(context, "/category");
          },
          child: AspectRatio(
            aspectRatio: 94 / 102,
            // width: 100,
            // color: Colors.transparent,
            child: Stack(clipBehavior: Clip.none, children: [
              Container(
                color: Colors.white70.withOpacity(0.01),
                margin: EdgeInsets.only(
                  bottom: PixelNumberfromFigma(25),
                ),
              ),
              Positioned(
                  left: -0.2,
                  right: -0.2,
                  top: -0.2,
                  bottom: -0.2,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(
                        // bottom: PixelNumberfromFigma(15 / 1.2720196495141103),
                        ),
                    child: AspectRatio(
                        aspectRatio: 94 / 32,
                        child: Container(
                          color: Colors.white,
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    // height: PixelNumberfromFigma(25),
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(
                                        top: PixelNumberfromFigma(7.4),
                                        left: PixelNumberfromFigma(8)),
                                    child: Stack(children: [
                                      GradientTextspace(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Color.fromARGB(255, 2, 6, 8),
                                                Color.fromARGB(255, 2, 14, 31),
                                              ]),
                                          textspace: Textspace(
                                              text: widget.title,
                                              size: 1,
                                              maxLines: 2,
                                              headsize: 0.0001,
                                              alignment: Alignment.topLeft,
                                              style: GoogleFonts.inter(
                                                  fontSize: fontSizeNumber(1),
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff000000)))),
                                      Textspace(
                                          text: widget.title,
                                          size: 1,
                                          maxLines: 2,
                                          headsize: 0.0001,
                                          alignment: Alignment.topLeft,
                                          style: GoogleFonts.inter(
                                            fontSize: fontSizeNumber(1),
                                            fontWeight: FontWeight.w500,
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth =
                                                  PixelNumberfromFigma(0.2)
                                              ..color = Color(0xff000000),
                                          )),
                                    ]),
                                  ),
                                ),
                                // Container(
                                //   // height: PixelNumberfromFigma(25),

                                //   alignment: Alignment.topCenter,
                                //   padding: EdgeInsets.only(
                                //       top: PixelNumberfromFigma(7.68),
                                //       right: PixelNumberfromFigma(9.33)),
                                //   // color: Colors.white,
                                //   child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.end,
                                //       children: [
                                //         SvgPicture.asset(
                                //           "assets/platter/circle.svg",
                                //           width: PixelNumberfromFigma(12.67),
                                //           height: PixelNumberfromFigma(12.67),
                                //           color: Color(0xFF3C3C3C),
                                //         )
                                //       ]),
                                // ),
                              ]),
                        )),
                  ))
            ]),
          )),
    ));
  }
}
