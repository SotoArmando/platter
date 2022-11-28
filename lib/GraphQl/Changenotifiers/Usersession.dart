import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Usersession extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<UserCredential> _userCredential = [];

  UserCredential get userCredential => _userCredential.last;

  bool isSessionIn() => _userCredential.length > 0;

  void signOut() {
    // userCredential.user?.email;
    _userCredential.clear();
  }

  void signIn(String EmailInput, String PasswordInput) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: EmailInput, password: PasswordInput);
      _update(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void _update(UserCredential item) {
    _userCredential.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
