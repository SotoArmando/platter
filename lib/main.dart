import 'package:flutter/material.dart';
import 'package:p_l_atter/Components/CookingAssistance.dart';
import 'package:p_l_atter/Components/CookingDetails.dart';
import 'package:p_l_atter/Routes/animatedcontainertest.dart';
import 'package:p_l_atter/Routes/ratiotest.dart';
import 'package:p_l_atter/Routes/session.dart';
import 'package:p_l_atter/Routes/welcome.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Plater Kitchen Learning Enterprise',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => Animatedcontainertest(),
      },
    ),
  );
}
