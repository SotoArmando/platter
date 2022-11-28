import 'package:flutter/material.dart';

class Recipeid extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<String> _recipeid = ["91"];

  String get recipeId => _recipeid.last;

  void update(String item) {
    _recipeid.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
