import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';
import 'package:cancellation_token_http/http.dart' as http;
import 'package:flutter_password_strength/flutter_password_strength.dart';

class Welcomesignup extends StatefulWidget {
  Welcomesignup({Key? key}) : super(key: key);

  @override
  _WelcomesignupState createState() => _WelcomesignupState();
}

class _WelcomesignupState extends State<Welcomesignup> {
  PageController c = new PageController();
  late Savemodel providedSaveModel =
      Provider.of<Savemodel>(context, listen: false);
  late Requestor providedRequestor =
      Provider.of<Requestor>(context, listen: false);
  final PasswordInput = TextEditingController();
  final ConfirmPasswordInput = TextEditingController();
  final VerificationInput = TextEditingController();
  final EmailInput = TextEditingController();

  late String _password = "";
  double _strength = 0;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String _displayText = 'Please enter a password';
  String _displayPass = '';
  String _displayEmail = '';
  final isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  void _checkPassword() {
    // _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText = 'Please enter you password';
      });
    } else if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;
        _displayText = 'Your password is too short';
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 2 / 4;
        _displayText = 'Your password is acceptable but not strong';
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
          _strength = 3 / 4;
          _displayText = 'Your password is strong';
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {
          _strength = 1;
          _displayText = 'Your password is great';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<int>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Verified!'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: pixelNumberfromFigma(15)),
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
                      height: pixelNumberfromFigma(43),
                      width: pixelNumberfromFigma(142),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                              pixelNumberfromFigma(10.98))),
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
    var cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: EmailInput.text, password: PasswordInput.text);
    if (cred.user?.emailVerified ?? false) {
      // VerificationInput.text = "GOOD TO GO";
      _askedToLead();

      print("User Verified: He is good");
      await providedSaveModel.addSignedUser(cred);
      providedRequestor.addRequest(
          "favorite",
          (http.CancellationToken token) => RestClient().getUserFavorites(
              providedSaveModel.authToken[0], providedSaveModel.authSecret[0]));
      providedRequestor.addRequest(
          "history",
          (http.CancellationToken token) => RestClient().getUserFavorites(
              providedSaveModel.history["auth_token"]!,
              providedSaveModel.history["auth_secret"]!));
      // Navigate the user into the app
    } else {
      print("User Verification: He is not good");
      // Tell the user to go verify their mail
      await Future<void>.delayed(const Duration(seconds: 1));
      handleUserEmailVerification(providedSaveModel);
    }
  }

  void haveNewUser(Savemodel providedSaveModel) async {
    //     await createUserWithEmailAndPassword (
//   email: //wherever you set their email,
//   password: //wherever you set their password,
// ).then((FirebaseUser user) {
//   //If a user is successfully created with an appropriate email
// if (user != null){
//   user.sendEmailVerification();
// }
// })
// .catchError();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: EmailInput.text,
        password: ConfirmPasswordInput.text,
      )
          .then((cred) {
        //If a user is successfully created with an appropriate email

        if (cred != null) {
          var actionCodeSettings = ActionCodeSettings(
            url:
                'https://www.platter-51816.firebaseapp.com/?email=${cred.user?.email}',
            dynamicLinkDomain: 'platter.page.link',
            androidPackageName: 'com.example.p_l_atter',
            androidInstallApp: true,
            androidMinimumVersion: '12',
            iOSBundleId: 'com.example.p_l_atter',
            handleCodeInApp: true,
          );
          cred.user?.sendEmailVerification().whenComplete(
              () => handleUserEmailVerification(providedSaveModel));
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var providedSaveModel = Provider.of<Savemodel>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: pixelNumberfromFigma(15),
                right: pixelNumberfromFigma(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, '/welcome_signin');

                    c.animateToPage(0,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOut);
                  },
                  child: Textspace(
                    text: "Cancel",
                    alignment: Alignment.center,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: fontSizeNumber(0)),
                  ),
                ),
                Textspace(
                  text: "Create account",
                  alignment: Alignment.center,
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: fontSizeNumber(0)),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/welcome_signin');
                  },
                  child: Textspace(
                    text: "Cancel",
                    alignment: Alignment.center,
                    style: GoogleFonts.inter(
                        color: Colors.transparent,
                        fontWeight: FontWeight.w400,
                        fontSize: fontSizeNumber(0)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: PageView(
              controller: c,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: pixelNumberfromFigma(15),
                      right: pixelNumberfromFigma(15)),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Textspace(
                            text: "What's your email?",
                            alignment: Alignment.centerLeft,
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: fontSizeNumber(2)),
                          ),
                          Textspace(
                              text: "What's your email?",
                              alignment: Alignment.centerLeft,
                              style: GoogleFonts.inter(
                                fontSize: fontSizeNumber(2),
                                fontWeight: FontWeight.w400,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = pixelNumberfromFigma(0.525)
                                  ..color = const Color(0xff000000),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: pixelNumberfromFigma(39),
                        child: Material(
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                            alignment: Alignment.center,
                            child: TextField(
                              onChanged: (v) {
                                if (isEmail.hasMatch(EmailInput.text)) {
                                  setState(() {
                                    _displayEmail = "Your email is valid...";
                                  });
                                } else {
                                  setState(() {
                                    _displayEmail =
                                        "Your email input is not valid.";
                                  });
                                }
                              },
                              controller: EmailInput,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                contentPadding: EdgeInsets.only(
                                  left: pixelNumberfromFigma(13.5),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFFF5F6F8)), //<-- SEE HERE
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFFF5F6F8)), //<-- SEE HERE
                                ),
                              ),
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: fontSizeNumber(1)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6.5,
                      ),
                      Textspace(
                        text: "You'll need confirm this email later.",
                        alignment: Alignment.centerLeft,
                        headsize: 0.00001,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: fontSizeNumber(0)),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Textspace(
                        text: _displayEmail,
                        alignment: Alignment.center,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: fontSizeNumber(0)),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          height: pixelNumberfromFigma(43),
                          width: pixelNumberfromFigma(142),
                          decoration: BoxDecoration(
                              color: (isEmail.hasMatch(EmailInput.text))
                                  ? Colors.white
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(
                                  pixelNumberfromFigma(10.98))),
                          alignment: Alignment.center,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (isEmail.hasMatch(EmailInput.text)) {
                                  c.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 150),
                                      curve: Curves.easeOut);
                                } else {
                                  setState(() {
                                    _displayEmail =
                                        "Your email input is not Valid. Try again.";
                                  });
                                }
                              },
                              child: Textspace(
                                text: "Next",
                                size: 1,
                                alignment: Alignment.center,
                                headsize: 0.00001,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: (isEmail.hasMatch(EmailInput.text))
                                        ? Colors.black
                                        : Colors.grey[300]),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: pixelNumberfromFigma(15),
                      right: pixelNumberfromFigma(15)),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Textspace(
                            text: "What's your new password?",
                            alignment: Alignment.centerLeft,
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: fontSizeNumber(2)),
                          ),
                          Textspace(
                              text: "What's your new password?",
                              alignment: Alignment.centerLeft,
                              style: GoogleFonts.inter(
                                fontSize: fontSizeNumber(2),
                                fontWeight: FontWeight.w400,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = pixelNumberfromFigma(0.525)
                                  ..color = const Color(0xff000000),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: pixelNumberfromFigma(39),
                        child: Material(
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                            alignment: Alignment.center,
                            child: TextField(
                              onChanged: (v) {
                                setState(() {
                                  _password = v;
                                  _checkPassword();
                                });
                              },
                              controller: PasswordInput,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                contentPadding: EdgeInsets.only(
                                  left: pixelNumberfromFigma(13.5),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFFF5F6F8)), //<-- SEE HERE
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFFF5F6F8)), //<-- SEE HERE
                                ),
                              ),
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: fontSizeNumber(1)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6.5,
                      ),
                      Textspace(
                        text:
                            "Please confirm password by retintroducing it below.",
                        alignment: Alignment.centerLeft,
                        headsize: 0.00001,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: fontSizeNumber(0)),
                      ),
                      SizedBox(
                        height: pixelNumberfromFigma(39),
                        child: Material(
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                            alignment: Alignment.center,
                            child: TextField(
                              controller: ConfirmPasswordInput,
                              obscureText: true,
                              onChanged: (v) {
                                setState(() {
                                  if ((PasswordInput.value !=
                                      ConfirmPasswordInput.value)) {
                                    _displayPass =
                                        'Your inputs dont match. please try again.';
                                  } else {
                                    _displayPass = 'They matched.';
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                contentPadding: EdgeInsets.only(
                                  left: pixelNumberfromFigma(13.5),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFFF5F6F8)), //<-- SEE HERE
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color(0xFFF5F6F8)), //<-- SEE HERE
                                ),
                              ),
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: fontSizeNumber(1)),
                            ),
                          ),
                        ),
                      ),
                      Textspace(
                        text: _displayPass,
                        alignment: Alignment.center,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: fontSizeNumber(0)),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      LinearProgressIndicator(
                        value: _strength,
                        backgroundColor: Colors.grey[300],
                        color: _strength <= 1 / 4
                            ? Colors.red[600]
                            : _strength == 2 / 4
                                ? Colors.yellow[600]
                                : _strength == 3 / 4
                                    ? Colors.blue[600]
                                    : Colors.green[600],
                        minHeight: pixelNumberfromFigma(5),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // The message about the strength of the entered password
                      Textspace(
                        text: _displayText,
                        alignment: Alignment.center,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: fontSizeNumber(0)),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          height: pixelNumberfromFigma(43),
                          width: pixelNumberfromFigma(142),
                          decoration: BoxDecoration(
                              color: _strength == 1
                                  ? Colors.white
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(
                                  pixelNumberfromFigma(10.98))),
                          alignment: Alignment.center,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (_strength == 1 &&
                                    (PasswordInput.value ==
                                        ConfirmPasswordInput.value)) {
                                  haveNewUser(providedSaveModel);
                                  c.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 150),
                                      curve: Curves.easeOut);
                                }
                              },
                              child: Textspace(
                                text: "Next",
                                size: 1,
                                alignment: Alignment.center,
                                headsize: 0.00001,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: (_strength == 1 &&
                                            (PasswordInput.value ==
                                                ConfirmPasswordInput.value))
                                        ? Colors.black
                                        : Colors.grey[300]),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: pixelNumberfromFigma(15),
                      right: pixelNumberfromFigma(15)),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Textspace(
                            text: "Verify your email",
                            alignment: Alignment.centerLeft,
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: fontSizeNumber(2)),
                          ),
                          Textspace(
                              text: "Verify your email",
                              alignment: Alignment.centerLeft,
                              style: GoogleFonts.inter(
                                fontSize: fontSizeNumber(2),
                                fontWeight: FontWeight.w400,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = pixelNumberfromFigma(0.525)
                                  ..color = const Color(0xff000000),
                              )),
                        ],
                      ),
                      Textspace(
                        text:
                            "Plase check the validation email sent to ${EmailInput.text}.",
                        alignment: Alignment.centerLeft,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: fontSizeNumber(0)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 6.5,
                      ),
                      Textspace(
                        text:
                            "Verify your email using the provided link via your email. here then should appear a succesfull verification window.",
                        alignment: Alignment.centerLeft,
                        headsize: 0.00001,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: fontSizeNumber(0)),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Textspace(
                        text: "The mail may be in your junk/spam section.",
                        alignment: Alignment.centerLeft,
                        headsize: 0.00001,
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: fontSizeNumber(0)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          height: pixelNumberfromFigma(43),
                          width: pixelNumberfromFigma(142),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  pixelNumberfromFigma(10.98))),
                          alignment: Alignment.center,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                c.animateTo(MediaQuery.of(context).size.width,
                                    duration: new Duration(milliseconds: 150),
                                    curve: Curves.easeOut);
                              },
                              child: Textspace(
                                text: "Resend mail",
                                size: 1,
                                alignment: Alignment.center,
                                headsize: 0.00001,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   child: Container(
                      //     height: pixelNumberfromFigma(43),
                      //     width: pixelNumberfromFigma(142),
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(
                      //             pixelNumberfromFigma(10.98))),
                      //     alignment: Alignment.center,
                      //     child: Material(
                      //       color: Colors.transparent,
                      //       child: InkWell(
                      //         onTap: () {},
                      //         child: Textspace(
                      //           text: "Complete",
                      //           size: 1,
                      //           alignment: Alignment.center,
                      //           headsize: 0.00001,
                      //           style: GoogleFonts.inter(
                      //               fontWeight: FontWeight.w500,
                      //               color: Colors.black),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
