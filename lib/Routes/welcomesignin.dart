import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:p_l_atter/main.dart';
import 'package:provider/provider.dart';
import 'package:cancellation_token_http/http.dart' as http;

class Welcomesignin extends StatefulWidget {
  Welcomesignin({Key? key}) : super(key: key);

  @override
  _WelcomesigninState createState() => _WelcomesigninState();
}

class _WelcomesigninState extends State<Welcomesignin> {
  var emailInput = TextEditingController();
  var passwordInput = TextEditingController();
  late Savemodel providedSaveModel =
      Provider.of<Savemodel>(context, listen: false);
  late Requestor providedRequestor =
      Provider.of<Requestor>(context, listen: false);
  // Future<void> _askedToLead() async {
  //   switch (await showDialog<int>(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           title: const Text('Verified!'),
  //           children: <Widget>[
  //             Padding(
  //               padding: EdgeInsets.only(left: PixelNumberfromFigma(15)),
  //               child: Textspace(
  //                   text: "Voila! You have successfully verified the account."),
  //             ),
  //             Container(
  //                 alignment: Alignment.center,
  //                 child: ElevatedButton(
  //                   onPressed: () {
  //                     Navigator.pop(context, 0);
  //                     Navigator.pushNamed(context, '/second');
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.white,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(12), // <-- Radius
  //                     ),
  //                   ),
  //                   child: Container(
  //                     height: PixelNumberfromFigma(43),
  //                     width: PixelNumberfromFigma(142),
  //                     decoration: BoxDecoration(
  //                         color: Colors.transparent,
  //                         borderRadius: BorderRadius.circular(
  //                             PixelNumberfromFigma(10.98))),
  //                     alignment: Alignment.center,
  //                     child: Textspace(
  //                       text: "Go to main",
  //                       size: 1,
  //                       alignment: Alignment.center,
  //                       headsize: 0.00001,
  //                       style: GoogleFonts.inter(
  //                           fontWeight: FontWeight.w500, color: Colors.black),
  //                     ),
  //                   ),
  //                 ))
  //           ],
  //         );
  //       })) {
  //     case 0:
  //       // Let's go.
  //       // ...
  //       break;
  //     case 1:
  //       // ...
  //       break;
  //     case null:
  //       // dialog dismissed
  //       break;
  //   }
  // }

  Future<void> handleUserEmailVerification(
      Savemodel providedSaveModel, Requestor providedRequestor) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailInput.text, password: passwordInput.text);
      await providedSaveModel.addPath(emailInput.text);
      providedRequestor.addRequest(
          "favorite",
          (http.CancellationToken token) => RestClient().getUserFavorites(
              providedSaveModel.authToken[0], providedSaveModel.authSecret[0]));
      providedRequestor.addRequest(
          "history",
          (http.CancellationToken token) => RestClient().getUserFavorites(
              providedSaveModel.history["auth_token"]!,
              providedSaveModel.history["auth_secret"]!));

      navigatorKey.currentState!.pushNamed('/second');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF02A1FC),
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Positioned(
              top: pixelNumberfromFigma(61),
              left: 0,
              right: 0,
              child: Column(children: [
                Container(
                    alignment: Alignment.center,
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
                SizedBox(height: pixelNumberfromFigma(41)),
                Image.asset(
                  "assets/platter/307.png",
                  height: pixelNumberfromFigma(97),
                )
              ]),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Transform(
                        transform: Matrix4.translationValues(0, 1, 0),
                        child: SvgPicture.asset(
                          "assets/platter/greatload.svg",
                          fit: BoxFit.fitHeight,
                          height: pixelNumberfromFigma(50),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: pixelNumberfromFigma(15)),
                        color: Colors.white,
                        height: pixelNumberfromFigma(322 + 28),
                        child: Column(children: [
                          SizedBox(
                            height: pixelNumberfromFigma(15),
                          ),
                          SizedBox(
                            height: pixelNumberfromFigma(39),
                            child: Material(
                              color: Colors.white,
                              elevation: 0,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: TextField(
                                    controller: emailInput,
                                    decoration: InputDecoration(
                                      // icon:
                                      //     const Icon(Icons.verified_user_sharp),
                                      hintText: 'Email or username',
                                      contentPadding: EdgeInsets.only(
                                        left: pixelNumberfromFigma(13.5),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color(
                                                0xFFF5F6F8)), //<-- SEE HERE
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color(
                                                0xFFF5F6F8)), //<-- SEE HERE
                                      ),
                                    ),
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: fontSizeNumber(1)),
                                  )

                                  // GradientTextspace(
                                  //   gradient: const LinearGradient(
                                  //       begin: Alignment.bottomCenter,
                                  //       end: Alignment.topCenter,
                                  //       colors: [
                                  //         Color.fromARGB(255, 2, 6, 8),
                                  //         Color.fromARGB(255, 2, 14, 31),
                                  //       ]),
                                  //   textspace: ,
                                  // ),
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: pixelNumberfromFigma(30),
                          ),
                          SizedBox(
                            height: pixelNumberfromFigma(39),
                            child: Material(
                              color: Colors.white,
                              elevation: 0,
                              child: Container(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: passwordInput,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    // icon: const Icon(Icons.password_sharp),
                                    hintText: 'Password',

                                    contentPadding: EdgeInsets.only(
                                      left: pixelNumberfromFigma(13.5),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFF5F6F8)), //<-- SEE HERE
                                    ),
                                    // border: OutlineInputBorder(
                                    //     borderSide: BorderSide(
                                    //         color: ,
                                    //         width: 1)),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFF5F6F8)), //<-- SEE HERE
                                    ),
                                  ),
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: fontSizeNumber(1)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: pixelNumberfromFigma(99),
                            child: Container(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: pixelNumberfromFigma(30),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 0.5,
                                  child: InkWell(
                                    onTap: () {
                                      handleUserEmailVerification(
                                          providedSaveModel, providedRequestor);
                                    },
                                    child: GradientTextspace(
                                      gradient: const LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Color.fromARGB(255, 2, 6, 8),
                                            Color.fromARGB(255, 2, 14, 31),
                                          ]),
                                      textspace: Textspace(
                                        text: "Log in",
                                        alignment: Alignment.center,
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizeNumber(1)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: pixelNumberfromFigma(30),
                            child: Material(
                              color: Colors.white,
                              elevation: 0.5,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/welcome_signup');
                                },
                                child: GradientTextspace(
                                  gradient: const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Color.fromARGB(255, 2, 6, 8),
                                        Color.fromARGB(255, 2, 14, 31),
                                      ]),
                                  textspace: Textspace(
                                    text: "Sign up free",
                                    alignment: Alignment.center,
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizeNumber(1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                )),
            Positioned.fill(
              child: IgnorePointer(
                  child: Container(
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
                        const Color.fromARGB(255, 150, 0, 255)
                            .withOpacity(0.005),
                        const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.005),
                        const Color.fromRGBO(255, 255, 255, 1)
                            .withOpacity(0.005),
                        const Color.fromARGB(255, 150, 0, 255)
                            .withOpacity(0.005),
                      ]),
                ),
              )),
            )
          ],
        ));
  }
}
