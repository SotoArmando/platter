import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class Aboutus extends StatefulWidget {
  Aboutus({Key? key}) : super(key: key);

  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: pixelNumberfromFigma(70)),
      child: Column(
        children: [
          Image.asset(
            "assets/platter/fatsecret.jpg",
            width: pixelNumberfromFigma(111.55),
          ),
          SizedBox(
            height: pixelNumberfromFigma(34.45),
          ),
          Text("Powered by Fatsecret"),
          SizedBox(
            height: pixelNumberfromFigma(83),
          ),
          Image.asset(
            "assets/platter/1024.png",
            width: pixelNumberfromFigma(111.55),
          ),
          SizedBox(
            height: pixelNumberfromFigma(34),
          ),
          Text("Platter inc all rights reserverd"),
          SizedBox(
            height: pixelNumberfromFigma(11.45),
          ),
          Text("Brough you thanks to Sotoarmando"),
        ],
      ),
    );
  }
}
