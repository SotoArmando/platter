import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class Loadingscreen extends StatefulWidget {
  final num seconds;
  bool white;
  Loadingscreen({Key? key, this.seconds = 1, this.white = true})
      : super(key: key);

  @override
  _LoadingscreenState createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {
  bool white = true;
  @override
  void initState() {
    super.initState();
    white = widget.white;
    Timer(
        Duration(seconds: widget.seconds.toInt()),
        () => setState(() {
              white = false;
            }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return white
        ? Container(
            color: Colors.white,
          )
        : SizedBox();
  }
}
