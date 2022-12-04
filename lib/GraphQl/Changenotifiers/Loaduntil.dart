import 'package:flutter/material.dart';

class Loaduntil extends ChangeNotifier {
  /// Internal, private state of the cart.
  bool loaded = false;
  Future? loading;
  Future<bool> loaduntil(Future Function() item) async {
    // This call tells the widgets that are listening to this model to rebuild.
    loaded = false;
    loading = item();
    notifyListeners();
    await loading!;

    return true;
  }
}
