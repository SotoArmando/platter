import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';

class Welcomesignin extends StatefulWidget {
  Welcomesignin({Key? key}) : super(key: key);

  @override
  _WelcomesigninState createState() => _WelcomesigninState();
}

class _WelcomesigninState extends State<Welcomesignin> {
  var EmailInput = TextEditingController();
  var PasswordInput = TextEditingController();

  Future<void> _askedToLead() async {
    switch (await showDialog<int>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Verified!'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: PixelNumberfromFigma(15)),
                child: Textspace(
                    text: "Voila! You have successfully verified the account."),
              ),
              Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 0);
                      Navigator.pushNamed(context, '/second');
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
                          borderRadius: BorderRadius.circular(
                              PixelNumberfromFigma(10.98))),
                      alignment: Alignment.center,
                      child: Textspace(
                        text: "Go to main",
                        size: 1,
                        alignment: Alignment.center,
                        headsize: 0.00001,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ),
                  ))
            ],
          );
        })) {
      case 0:
        // Let's go.
        // ...
        break;
      case 1:
        // ...
        break;
      case null:
        // dialog dismissed
        break;
    }
  }

  Future<void> handleUserEmailVerification(Savemodel providedSaveModel) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: EmailInput.text, password: PasswordInput.text);
      providedSaveModel.addPath(EmailInput.text);
      Navigator.pushNamed(context, '/second');
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
    var providedSaveModel = Provider.of<Savemodel>(context);
    return Scaffold(
        backgroundColor: Color(0xFF02A1FC),
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Positioned(
              top: PixelNumberfromFigma(61),
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: Textspace(
                  text: "Platter",
                  alignment: Alignment.topCenter,
                  headsize: 0.000001,
                  style: GoogleFonts.inter(
                      fontSize: fontSizeNumber(3.0000001) * 1.366829268,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Image.asset("assets/platter/greatload.png"),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: PixelNumberfromFigma(15)),
                        color: Colors.white,
                        height: PixelNumberfromFigma(322),
                        child: Column(children: [
                          SizedBox(
                            height: PixelNumberfromFigma(9.5),
                          ),
                          SizedBox(
                            height: PixelNumberfromFigma(39),
                            child: Material(
                              color: Colors.white,
                              elevation: 0,
                              child: Container(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: EmailInput,
                                  decoration: InputDecoration(
                                    hintText: 'User email',
                                    contentPadding: EdgeInsets.only(
                                      left: PixelNumberfromFigma(13.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFF5F6F8)), //<-- SEE HERE
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFF5F6F8)), //<-- SEE HERE
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: fontSizeNumber(0)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: PixelNumberfromFigma(30),
                          ),
                          SizedBox(
                            height: PixelNumberfromFigma(39),
                            child: Material(
                              color: Colors.white,
                              elevation: 0,
                              child: Container(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: PasswordInput,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',

                                    contentPadding: EdgeInsets.only(
                                      left: PixelNumberfromFigma(13.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFF5F6F8)), //<-- SEE HERE
                                    ),
                                    // border: OutlineInputBorder(
                                    //     borderSide: BorderSide(
                                    //         color: ,
                                    //         width: 1)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Color(0xFFF5F6F8)), //<-- SEE HERE
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: fontSizeNumber(0)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: PixelNumberfromFigma(99),
                            child: Container(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: PixelNumberfromFigma(30),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 0.5,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/welcome_signup');
                                    },
                                    child: Textspace(
                                      text: "Sign up free",
                                      alignment: Alignment.center,
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSizeNumber(0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: PixelNumberfromFigma(30),
                            child: Material(
                              color: Colors.white,
                              elevation: 0.5,
                              child: InkWell(
                                onTap: () {
                                  handleUserEmailVerification(
                                      providedSaveModel);
                                },
                                child: Textspace(
                                  text: "Sign in",
                                  alignment: Alignment.center,
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSizeNumber(0)),
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
                      stops: [
                        0,
                        .10,
                        .90,
                        1
                      ],
                      colors: [
                        Color.fromARGB(255, 150, 0, 255).withOpacity(0.005),
                        Color.fromARGB(255, 255, 255, 255).withOpacity(0.005),
                        Color.fromRGBO(255, 255, 255, 1).withOpacity(0.005),
                        Color.fromARGB(255, 150, 0, 255).withOpacity(0.005),
                      ]),
                ),
              )),
            )
          ],
        ));
  }
}
