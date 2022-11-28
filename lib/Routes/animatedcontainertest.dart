import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p_l_atter/Components/%5Bdeleted%5DCookingAssistantItem1.dart';
import 'package:p_l_atter/Components/CookingAssistantItem.dart';
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
        CookingAssistantItem1(),
        CookingAssistantItem(),
        CookingAssistantItem(),
        CookingAssistantItem(),
        CookingAssistantItem(),
      ],
    ));
  }
}
