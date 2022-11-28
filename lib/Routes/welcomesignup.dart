import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';

class Welcomesignup extends StatefulWidget {
  Welcomesignup({Key? key}) : super(key: key);

  @override
  _WelcomesignupState createState() => _WelcomesignupState();
}

class _WelcomesignupState extends State<Welcomesignup> {
  PageController c = new PageController();

  final PasswordInput = TextEditingController();
  final ConfirmPasswordInput = TextEditingController();
  final VerificationInput = TextEditingController();
  final EmailInput = TextEditingController();

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
    var cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: EmailInput.text, password: PasswordInput.text);
    if (cred.user?.emailVerified ?? false) {
      // VerificationInput.text = "GOOD TO GO";
      _askedToLead();

      print("User Verified: He is good");
      providedSaveModel.addSignedUser(cred);
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
        body: Column(
      children: [
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: PixelNumberfromFigma(15), right: PixelNumberfromFigma(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, '/welcome_signin');
                  c.jumpTo(0.0);
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
        Expanded(
          child: PageView(
            controller: c,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: PixelNumberfromFigma(15),
                    right: PixelNumberfromFigma(15)),
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
                              fontSize: fontSizeNumber(1)),
                        ),
                        Textspace(
                            text: "What's your email?",
                            alignment: Alignment.centerLeft,
                            style: GoogleFonts.inter(
                              fontSize: fontSizeNumber(1),
                              fontWeight: FontWeight.w400,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = PixelNumberfromFigma(0.525)
                                ..color = Color(0xff000000),
                            )),
                      ],
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
                              hintText: 'Email',
                              contentPadding: EdgeInsets.only(
                                left: PixelNumberfromFigma(13.5),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF5F6F8)), //<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF5F6F8)), //<-- SEE HERE
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
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: PixelNumberfromFigma(43),
                        width: PixelNumberfromFigma(142),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                PixelNumberfromFigma(10.98))),
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
                              text: "Next",
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
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: PixelNumberfromFigma(15),
                    right: PixelNumberfromFigma(15)),
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
                              fontSize: fontSizeNumber(1)),
                        ),
                        Textspace(
                            text: "What's your new password?",
                            alignment: Alignment.centerLeft,
                            style: GoogleFonts.inter(
                              fontSize: fontSizeNumber(1),
                              fontWeight: FontWeight.w400,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = PixelNumberfromFigma(0.525)
                                ..color = Color(0xff000000),
                            )),
                      ],
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
                            decoration: InputDecoration(
                              hintText: 'Password',
                              contentPadding: EdgeInsets.only(
                                left: PixelNumberfromFigma(13.5),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF5F6F8)), //<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF5F6F8)), //<-- SEE HERE
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
                      height: PixelNumberfromFigma(39),
                      child: Material(
                        color: Colors.white,
                        elevation: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: TextField(
                            controller: ConfirmPasswordInput,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              contentPadding: EdgeInsets.only(
                                left: PixelNumberfromFigma(13.5),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF5F6F8)), //<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF5F6F8)), //<-- SEE HERE
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
                      height: 24,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: PixelNumberfromFigma(43),
                        width: PixelNumberfromFigma(142),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                PixelNumberfromFigma(10.98))),
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              haveNewUser(providedSaveModel);
                              c.animateTo(MediaQuery.of(context).size.width * 2,
                                  duration: new Duration(milliseconds: 150),
                                  curve: Curves.easeOut);
                            },
                            child: Textspace(
                              text: "Next",
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
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: PixelNumberfromFigma(15),
                    right: PixelNumberfromFigma(15)),
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Flexible(
                            child: Textspace(
                              textAlign: TextAlign.justify,
                              text: "Verify your email",
                              alignment: Alignment.centerLeft,
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSizeNumber(1)),
                            ),
                          ),
                          Flexible(
                            child: Textspace(
                              textAlign: TextAlign.justify,
                              text: "Verify your email",
                              alignment: Alignment.centerLeft,
                              style: GoogleFonts.inter(
                                fontSize: fontSizeNumber(1),
                                fontWeight: FontWeight.w400,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = PixelNumberfromFigma(0.525)
                                  ..color = Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Textspace(
                      text:
                          "Plase check the validation email sent to armando29@live.com.",
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
                      text: "Check your Inbox",
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
                        height: PixelNumberfromFigma(43),
                        width: PixelNumberfromFigma(142),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                PixelNumberfromFigma(10.98))),
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
                              text: "Resend Code",
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
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: PixelNumberfromFigma(43),
                        width: PixelNumberfromFigma(142),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                PixelNumberfromFigma(10.98))),
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Textspace(
                              text: "Complete",
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
