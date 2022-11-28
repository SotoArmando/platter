import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:rive/rive.dart' as rive;
import 'package:url_launcher/url_launcher.dart';

class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  SlidingAppBar({
    required this.child,
    required this.controller,
    required this.visible,
  });

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    const background = Image(
        fit: BoxFit.fitWidth,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        image: AssetImage('assets/platter/welcomeback.png'));

    var welcome = SingleChildScrollView(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: SvgPicture.asset(
                        "assets/platter/globe.svg",
                        height: 23.06125,
                        color: Color.fromARGB(255, 255, 255, 255),
                        matchTextDirection: true,
                      ),
                    )),
              ),
            )
          ],
        ),
        Center(
          child: ElevatedButton(
            // Within the `FirstScreen` widget
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.pushNamed(context, '/second');
            },
            child: const Text('Launch screen'),
          ),
        ),
      ]),
    );

    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        background,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: PixelNumberfromFigma(209),
            child: const rive.RiveAnimation.asset('assets/platter/greatani.riv',
                fit: BoxFit.fitWidth),
          ),
        ),
        Positioned(
            bottom: PixelNumberfromFigma(69),
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/welcome_signin');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  child: Container(
                    height: PixelNumberfromFigma(43),
                    width: PixelNumberfromFigma(142),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(PixelNumberfromFigma(10.98))),
                    alignment: Alignment.center,
                    child: Textspace(
                      text: "Get Started",
                      size: 1,
                      alignment: Alignment.center,
                      headsize: 0.00001,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                ))),
        Positioned(
            bottom: PixelNumberfromFigma(69 + 43 + 34),
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/platter/307.png",
                  height: PixelNumberfromFigma(43),
                ))),
        Positioned(
          left: PixelNumberfromFigma(15),
          right: PixelNumberfromFigma(0),
          bottom: PixelNumberfromFigma(263),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RichText(
              textHeightBehavior:
                  const TextHeightBehavior(applyHeightToFirstAscent: false),
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: fontSizeNumber(3.0000001),
                    fontWeight: FontWeight.w600,
                    height: 1.365853659),
                children: <TextSpan>[
                  TextSpan(
                      text: 'With a\n',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: fontSizeNumber(3.0000001),
                          fontWeight: FontWeight.w700)),
                  TextSpan(text: 'Great Cooking App\n'),
                  TextSpan(
                      text: 'Comes\n',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: fontSizeNumber(3.0000001),
                          fontWeight: FontWeight.w700)),
                  TextSpan(text: 'Great Cooker'),
                ],
              ),
            ),
            SvgPicture.asset(
              "assets/platter/timer.svg",
              width: PixelNumberfromFigma(90.31 * 1.2720196495141103),
              color: Colors.white,
            ),
          ]),
        ),
        // Positioned(
        //   top: 24,
        //   left: 0,
        //   right: 0,
        //   child: Image.asset("assets/platter/greathead.png", fit: BoxFit.cover),
        // ),

        Positioned(
            top: PixelNumberfromFigma(24),
            right: PixelNumberfromFigma(7.5),
            child: InkWell(
                child: Image.asset(
                  "assets/platter/powered_by_fatsecret.png",
                  width: PixelNumberfromFigma(100),
                ),
                onTap: () async {
                  if (await canLaunchUrl(
                      Uri.parse("https://platform.fatsecret.com")))
                    await launchUrl(Uri.parse("https://platform.fatsecret.com"),
                        mode: LaunchMode.externalApplication);
                  else
                    // can't launch url, there is some error
                    throw "Could not launch https: //platform.fatsecret.com";
                })),
        Positioned(
          top: PixelNumberfromFigma(61),
          left: 0,
          right: 0,
          child: Textspace(
            text: "Platter",
            alignment: Alignment.center,
            style: GoogleFonts.inter(
                fontSize: fontSizeNumber(3.0000001) * 1.366829268,
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
        ),
        Positioned.fill(
            child: IgnorePointer(
          child: DecoratedBox(
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
          ),
        ))
      ],
    ));
  }
}
