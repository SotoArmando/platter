import 'package:flutter/cupertino.dart';
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
      padding: EdgeInsets.only(top: PixelNumberfromFigma(70)),
      child: Column(
        children: [
          Image.asset(
            "assets/platter/fatsecret.jpg",
            width: PixelNumberfromFigma(111.55),
          ),
          Image.asset(
            "assets/platter/1024.png",
            width: PixelNumberfromFigma(111.55),
          )
        ],
      ),
    );
  }
}
