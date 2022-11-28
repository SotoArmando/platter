// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:math';

import 'package:cancellation_token_http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';

class Fatsecret {
  final secret = "d89d1f9f18c6481e9170c88d680a2ae7";
  final consumerkey = "d2878762c850489a8afef972b092a974";
  var oauth_timestamp;
  var oauth_signature_method = "HMAC-SHA1";
  var oauth_signature;
  var oauth_nonce;
  var method;
  bool Signed = false;

  get uri {
    return "https://platform.fatsecret.com/rest/server.api?food_id=33691&method=food.get.v2&oauth_consumer_key=$consumerkey&oauth_nonce=$oauth_nonce&oauth_signature=$oauth_signature&oauth_signature_method=$oauth_signature_method&oauth_timestamp=$oauth_timestamp&oauth_version=1.0 ";
  }

  // TODO: SIGN AND COLLECT ALL SIGNED DATA FOR NEXT REQUEST
  Future<bool> Sign() async {
    DateTime time = DateTime.now();
    oauth_timestamp = time.millisecondsSinceEpoch;
    oauth_nonce = "asdasd";

    String queryString = {
      "oauth_consumer_key": consumerkey,
      "oauth_signature_method": oauth_signature_method,
      "oauth_timestamp": oauth_timestamp,
      "oauth_nonce": oauth_nonce,
      "oauth_version": "1.0",
    }.entries.fold(
        "",
        (previousValue, element) =>
            previousValue + "${element.key}=${element.value}&");
    queryString = queryString.substring(0, queryString.length - 1);

    var parsedData =
        "${"GET"}&${Uri.encodeComponent("https://platform.fatsecret.com/rest/server.api")}&${Uri.encodeComponent(queryString)}";

    var Signature =
        utf8.encode(json.encode({"key": "${secret}&", "value": parsedData}));

    final algorithm = Sha1();

    final Signatureresult = await algorithm.hash(Signature);

    final digestHex = Signatureresult.bytes
        .map((b) => b.toRadixString(2).padLeft(8, '0'))
        .join(" ");

    oauth_signature = Uri.encodeComponent(base64.encode(Signatureresult.bytes));

    Signed = true;
    return Signed;
  }

  // TODO: CLEAR SIGNED DATA; MEAN TO BE CALLED AFTER EACH REQUEST
  void clearSignData() {
    oauth_nonce = "";
    oauth_signature = "";
    this.Signed = false;
  }

  // TODO: SEND SIGNED REQUEST TO SEARCH RECIPES RETURN IF SIGNED DATA IS NOT AVAILABLE.
  Future<http.Response> recipes(
    String keywords,
    String cuisine,
  ) {
    if (!Signed) {
      return Future(() => http.Response("Not signed; Client Error;", 0));
    }
    var data = http.get(
      Uri.parse(uri),
      // body: fetchBody,
      // cancellationToken: token,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    return data;
  }
}
