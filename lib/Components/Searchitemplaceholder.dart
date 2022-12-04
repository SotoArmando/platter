import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class Searchitemplaceholder extends StatefulWidget {
  Searchitemplaceholder({Key? key}) : super(key: key);

  @override
  _SearchitemplaceholderState createState() => _SearchitemplaceholderState();
}

class _SearchitemplaceholderState extends State<Searchitemplaceholder> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AspectRatio(
      aspectRatio: 94 / 102,
      // width: 100,

      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 94 / 32,
                        child: Container(
                          color: Colors.transparent,
                          // height: PixelNumberfromFigma(25),
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(left: pixelNumberfromFigma(8)),
                          child: Text("",
                              style: GoogleFonts.inter(
                                  fontSize: fontSizeNumber(0))),
                        ),
                      ),
                    ]),
              ),
            ),
          ]),
    ));
  }
}
