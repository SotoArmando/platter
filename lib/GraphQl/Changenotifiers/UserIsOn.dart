import 'package:flutter/material.dart';

class UserIsOn extends ChangeNotifier {
  /// Internal, private state of the cart.
  bool _ON = false;

  bool get isON => _ON;

  void update(bool item) {
    _ON = item;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
