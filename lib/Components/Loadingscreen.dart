import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Loaduntil.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({Key? key}) : super(key: key);

  @override
  _LoadingscreenState createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {
  final mywidget = Container(
    color: Colors.white,
    alignment: Alignment.center,
    child: SizedBox(
      width: pixelNumberfromFigma(54),
      child: const RiveAnimation.asset("assets/platter/69-98-loading.riv"),
    ),
  );

  final ignore = const SizedBox();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providedLoader = Provider.of<Loaduntil>(context, listen: true);
    return FutureBuilder(
        future: providedLoader.loading,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            return ignore;
          } else {
            return mywidget;
          }
        });
  }
}
