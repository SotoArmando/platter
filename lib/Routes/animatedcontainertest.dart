import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_l_atter/Components/CookingAssistantItem1.dart';
import 'package:p_l_atter/Components/CookingAssistantItem2.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

class Animatedcontainertest extends StatefulWidget {
  Animatedcontainertest({Key? key}) : super(key: key);

  @override
  _AnimatedcontainertestState createState() => _AnimatedcontainertestState();
}

class _AnimatedcontainertestState extends State<Animatedcontainertest> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextButton(
            onPressed: () {
              setState(() {
                open = !open;
              });
            },
            child: Text("Click me")),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(0.5, 1.0),
                  ),
                ),
                child: child);
          },
          child: Container(
              key: ValueKey<bool>(open),
              child: open
                  ? const CookingAssistantItem1()
                  : const CookingAssistantItem2()),
        ),
        CookingAssistantItem1(),
        CookingAssistantItem2(),
      ],
    ));
  }
}
