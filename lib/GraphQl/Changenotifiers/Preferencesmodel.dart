import 'package:flutter/material.dart';

class Preferencesmodel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<String> _categoryScreen = ["Breakfast"];

  String get categoryScreen => _categoryScreen.last;

  void update(String item) {
    _categoryScreen.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
