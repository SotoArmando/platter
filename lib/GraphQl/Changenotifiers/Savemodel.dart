import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';

class Savemodel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<String> likes = [];
  List<String> focus = [];
  List<String> userHistory = [];
  List<String> savePath = [];
  List<String> authToken = [];
  List<String> authSecret = [];
  Map<String, String> history = {};
  Map<String, Map<String, String>> collections = {};

  CollectionReference _users = FirebaseFirestore.instance.collection('User');

  Future<void> addSignedUser(UserCredential credential) async {
    var response = await RestClient()
        .profileCreate((credential.user?.uid ?? credential.user?.email)!);
    var historyresponse = await RestClient().profileCreate(
        "history${(credential.user?.uid ?? credential.user?.email)!}");
    var body = jsonDecode(response.body);
    var historybody = jsonDecode(historyresponse.body);
    var auth_secret = body["profile"]["auth_secret"];
    var auth_token = body["profile"]["auth_token"];
    history = {
      "auth_secret": historybody["profile"]["auth_secret"],
      "auth_token": historybody["profile"]["auth_token"],
    };
    // Call the user's CollectionReference to add a new user
    await _users.add({
      'uid': credential.user?.uid, // John Does
      'mail': credential.user?.email, // John Doe
      'focus': [],
      'likes': [],
      'history_list': [],
      'has_verified_mail': credential.user?.emailVerified,
      'auth_secret': auth_secret, // Stokes and Sons
      'auth_token': auth_token,
      'history': {
        'auth_secret': historybody["profile"]["auth_secret"],
        'auth_token': historybody["profile"]["auth_token"],
      } // Stokes and Sons
    }).then((value) {
      savePath.add(value.path);
      authToken.add(auth_token);
      authSecret.add(auth_secret);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addPath(String email) async {
    var snap = await _users.limit(1).where('mail', isEqualTo: email).get();
    var data = snap.docs[0].id;
    var doc = snap.docs[0].data() as Map<String, dynamic>;
    print("history");
    print(history);

    history = {
      "auth_token": doc["history"]["auth_token"],
      "auth_secret": doc["history"]["auth_secret"]
    };
    print("history");
    print(history);
    print("userHistory");
    print(userHistory);
    print(List.from(doc["history_list"]));

    authToken.add(doc["auth_token"]);
    authSecret.add(doc["auth_secret"]);
    likes = List.from(doc["likes"]);
    focus = List.from(doc["focus"]);
    userHistory = List.from(doc["history_list"]);
    savePath.add(data);

    return;
  }

  void clearSavePath() {
    savePath.clear();
    history.clear();
    likes.clear();
    focus.clear();
    authSecret.clear();
    authToken.clear();
  }

  void addLike(String item) async {
    if (savePath.length > 0) {
      var user = await _users.doc(savePath.last).get();
      var data = user.data() as Map<String, dynamic>;
      likes = List.from(data["likes"]);
      print("saving ...");
      print(data);
      print(data["likes"]);
      print(item);
      if (likes.contains(item)) {
        data["likes"].remove(item);
        likes.remove(item);
        RestClient().removeFavoriteToProfile(
            data["auth_token"], data["auth_secret"], item);
      } else {
        likes.remove(item);
        likes.add(item);
        RestClient().addFavoriteToProfile(
          data["auth_token"],
          data["auth_secret"],
          item,
        );
      }
      print({...data, "likes": likes}["likes"]);
      notifyListeners();

      _users.doc(savePath.last).update({...data, "likes": likes});
    }
  }

  void addHistory(String item) async {
    if (savePath.length > 0) {
      var user = await _users.doc(savePath.last).get();
      var data = user.data() as Map<String, dynamic>;

      if (userHistory.contains(item)) {
        userHistory.remove(item);
        userHistory.add(item);
      } else {
        userHistory.add(item);
      }

      notifyListeners();
      data["history_list"] = userHistory;
      _users.doc(savePath.last).update({...data, "history_list": userHistory});
    }
  }

  void addFocus(String item) async {
    if (savePath.length > 0) {
      var user = await _users.doc(savePath.last).get();
      var data = user.data() as Map<String, dynamic>;
      focus = List.from(data["focus"]);

      if (focus.contains(item)) {
        removeFocus(item);
      } else {
        focus.add(item);
      }

      notifyListeners();
      data["focus"] = focus;
      _users.doc(savePath.last).update(data);
    }
  }

  void removeLike(String item) async {
    var user = await _users.doc(savePath.last).get();
    var data = user.data() as Map<String, dynamic>;
    likes = List.from(data["likes"]);

    likes.remove(item);

    notifyListeners();
    data["likes"] = focus;
    _users.doc(savePath.last).update(data);
  }

  void removeFocus(String item) async {
    var user = await _users.doc(savePath.last).get();
    var data = user.data() as Map<String, dynamic>;
    focus = List.from(data["focus"]);

    focus.remove(item);

    notifyListeners();
    data["focus"] = focus;
    _users.doc(savePath.last).update(data);
  }
}
