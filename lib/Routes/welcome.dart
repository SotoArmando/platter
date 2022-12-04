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

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const background = Image(
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        image: AssetImage('assets/platter/welcomeback.png'));

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
            height: pixelNumberfromFigma(209),
            child: const rive.RiveAnimation.asset('assets/platter/greatani.riv',
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
            bottom: pixelNumberfromFigma(69 - 50),
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/welcome_signup');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF08A3FC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      child: Container(
                        height: pixelNumberfromFigma(43),
                        width: pixelNumberfromFigma(142),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                                pixelNumberfromFigma(10.98))),
                        alignment: Alignment.center,
                        child: GradientTextspace(
                          gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(255, 246, 252, 255),
                                Color.fromARGB(255, 227, 239, 255),
                              ]),
                          textspace: Textspace(
                            text: "Sign up",
                            size: 1,
                            alignment: Alignment.center,
                            headsize: 0.00001,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: pixelNumberfromFigma(15)),
                Container(
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
                        height: pixelNumberfromFigma(43),
                        width: pixelNumberfromFigma(142),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                                pixelNumberfromFigma(10.98))),
                        alignment: Alignment.center,
                        child: GradientTextspace(
                          gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(255, 2, 6, 8),
                                Color.fromARGB(255, 2, 14, 31),
                              ]),
                          textspace: Textspace(
                            text: "Sign in",
                            size: 1,
                            alignment: Alignment.center,
                            headsize: 0.00001,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ))
              ],
            )),
        Positioned(
            bottom: pixelNumberfromFigma(69 + 43 + 34),
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/platter/307.png",
                  height: pixelNumberfromFigma(43),
                ))),
        Positioned(
            right: pixelNumberfromFigma(15),
            bottom: pixelNumberfromFigma(263),
            child: GradientTextspace(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    0,
                    .10,
                    .90,
                    1
                  ],
                  colors: [
                    Color.fromARGB(255, 255, 232, 246),
                    const Color.fromARGB(255, 255, 255, 255),
                    const Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 240, 249),
                  ]),
              textspace: SvgPicture.asset(
                "assets/platter/timer.svg",
                width: pixelNumberfromFigma(90.31),
                color: Colors.black,
              ),
            )),
        Positioned(
          left: pixelNumberfromFigma(15),
          right: pixelNumberfromFigma(0),
          bottom: pixelNumberfromFigma(263),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            GradientTextspace(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0,
                    .50,
                    .75,
                    1
                  ],
                  colors: [
                    Color.fromARGB(255, 243, 250, 252),
                    Color.fromARGB(255, 255, 249, 252),
                    Color.fromARGB(255, 243, 250, 252),
                    Color.fromARGB(255, 255, 249, 252),
                  ]),
              textspace: RichText(
                textHeightBehavior:
                    const TextHeightBehavior(applyHeightToFirstAscent: false),
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: fontSizeNumber(3.0000001),
                      fontWeight: FontWeight.w700,
                      height: 1.365853659),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'With a\n',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: fontSizeNumber(3.0000001),
                            fontWeight: FontWeight.w800)),
                    const TextSpan(text: 'Great Cooking App\n'),
                    TextSpan(
                        text: 'Comes\n',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: fontSizeNumber(3.0000001),
                            fontWeight: FontWeight.w800)),
                    const TextSpan(text: 'Great Cooker'),
                  ],
                ),
              ),
            )
          ]),
        ),
        // Positioned(
        //   top: 24,
        //   left: 0,
        //   right: 0,
        //   child: Image.asset("assets/platter/greathead.png", fit: BoxFit.cover),
        // ),

        Positioned(
            top: pixelNumberfromFigma(24),
            right: pixelNumberfromFigma(7.5),
            child: InkWell(
                child: const Text(
                  "Powered by FatSecret",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () async {
                  if (await canLaunchUrl(
                      Uri.parse("https://platform.fatsecret.com"))) {
                    await launchUrl(Uri.parse("https://platform.fatsecret.com"),
                        mode: LaunchMode.externalApplication);
                  } else {
                    throw "Could not launch https: //platform.fatsecret.com";
                  }
                })),
        Positioned(
            top: pixelNumberfromFigma(61),
            left: 0,
            right: 0,
            child: GradientTextspace(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    0,
                    .10,
                    .90,
                    1
                  ],
                  colors: [
                    Color.fromARGB(255, 255, 232, 246),
                    const Color.fromARGB(255, 255, 255, 255),
                    const Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 240, 249),
                  ]),
              textspace: Textspace(
                text: "Platter",
                alignment: Alignment.center,
                style: GoogleFonts.inter(
                    fontSize: fontSizeNumber(3.0000001) * 1.366829268,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
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
                    .10,
                    .90,
                    1
                  ],
                  colors: [
                    const Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.005),
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.005),
                    const Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                  ]),
            ),
          ),
        ))
      ],
    ));
  }
}
