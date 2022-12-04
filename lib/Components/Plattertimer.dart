import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class Plattertimer extends StatefulWidget {
  Plattertimer({Key? key}) : super(key: key);

  @override
  _PlattertimerState createState() => _PlattertimerState();
}

class _PlattertimerState extends State<Plattertimer> {
  Duration seconds = new Duration();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: fontSizeNumber(7.00000000001),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SvgPicture.asset(
                    //   "assets/platter/begin.svg",
                    //   width: PixelNumberfromFigma(10),
                    // ),
                    // SvgPicture.asset(
                    //   "assets/platter/end.svg",
                    //   width: PixelNumberfromFigma(7.5),
                    //   color: Colors.transparent,
                    // ),
                  ],
                )
              ],
            ),
          ),
          GradientTextspace(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF020608),
                  Color(0xFF020E1F),
                ]),
            textspace: Textspace(
              text:
                  "${seconds.inMinutes}:${seconds.inSeconds % 60 > 9 ? "" : "0"}${seconds.inSeconds % 60}",
              antiLeftpad: true,
              fixSize: true,
              size: 7.00000000001,
              headsize: 0,
              font: GoogleFonts.inter,
              style: GoogleFonts.inter(
                color: Colors.black,
                height: 0.01,
                fontWeight: FontWeight.w400,
              ),
              alignment: Alignment.bottomCenter,
            ),
          ),
          SizedBox(
            height: fontSizeNumber(7.00000000001),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SvgPicture.asset(
                    //   "assets/platter/begin.svg",
                    //   width: PixelNumberfromFigma(10),
                    //   color: Colors.transparent,
                    // ),
                    // SvgPicture.asset(
                    //   "assets/platter/end.svg",
                    //   width: PixelNumberfromFigma(7.5),
                    // ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      SizedBox(
        height: fontSizeNumber(0) * 0.733228098,
      ),
      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  seconds += Duration(seconds: 5);
                });
              },
              child: Container(
                // color: Colors.blue[300],
                alignment: Alignment.bottomCenter,
                width: fontSizeNumber(0) * 6.629834254,
                padding: EdgeInsets.only(
                    bottom: (fontSizeNumber(0) * 0.536700868) * 0.5),
                child: GradientTextspace(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xFF020608),
                        Color(0xFF020E1F),
                      ]),
                  textspace: Textspace(
                    text: "5S",
                    size: 2,
                    style: GoogleFonts.inter(color: Colors.black),
                    headsize: 0.0000001,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Container(
              height: fontSizeNumber(2) * 1.756097561,
              color: Color(0xffD7D7D7),
              constraints: BoxConstraints(minWidth: 1),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  seconds += Duration(seconds: 30);
                });
              },
              child: Container(
                // color: Colors.blue[300],
                alignment: Alignment.bottomCenter,
                width: fontSizeNumber(0) * 6.629834254,
                padding: EdgeInsets.only(
                    bottom: (fontSizeNumber(0) * 0.536700868) * 0.5),
                child: GradientTextspace(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xFF020608),
                        Color(0xFF020E1F),
                      ]),
                  textspace: Textspace(
                    text: "30S",
                    size: 2,
                    style: GoogleFonts.inter(color: Colors.black),
                    headsize: 0.0000001,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Container(
              height: fontSizeNumber(2) * 1.756097561,
              color: Color(0xffD7D7D7),
              constraints: BoxConstraints(minWidth: 1),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  seconds += Duration(minutes: 2);
                });
              },
              child: Container(
                // color: Colors.blue[300],
                alignment: Alignment.bottomCenter,
                width: fontSizeNumber(0) * 6.629834254,
                padding: EdgeInsets.only(
                    bottom: (fontSizeNumber(0) * 0.536700868) * 0.5),
                child: GradientTextspace(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xFF020608),
                        Color(0xFF020E1F),
                      ]),
                  textspace: Textspace(
                    text: "2M",
                    size: 2,
                    style: GoogleFonts.inter(color: Colors.black),
                    headsize: 0.0000001,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
