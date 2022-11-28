import 'dart:async';
import 'dart:convert';

import 'package:cancellation_token_http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';

class Requestor extends ChangeNotifier {
  Map<String, List<Future<Response> Function()>> requests = {};
  Map<String, Map<num, Future<Response>>> loadingrequests = {};
  Map<String, List<CancellationToken>> cancelTokens = {};
  Map<String, Map<num, Response>> requestResponses = {};
  List<List<dynamic>> todo = [];

  Requestor() {
    Timer.periodic(
        const Duration(milliseconds: 2000),
        (Timer) => {
              if (todo.length > 0) {request()}
            });
  }

  num addRequest(
      String key, Future<Response> Function(CancellationToken token) Request,
      {bool now = false}) {
    var index = 0;
    if (!(requests[key]?.isNotEmpty ?? false)) {
      cancelTokens[key] = [new CancellationToken()];
      requests[key] = [() => Request(cancelTokens[key]!.last)];

      todo.add([key, index]);
    } else {
      if (requests[key]!.isNotEmpty) {
        return requests[key]!.length - 1;
      }

      index = cancelTokens[key]!.length;
      cancelTokens[key]!.add(new CancellationToken());
      requests[key] = [() => Request(cancelTokens[key]!.last)];
      todo.add([key, index]);

      // cancelTokens[key]!.last.cancel();
      // cancelTokens.remove(key);
      // requests.remove(key);
    }
    if (now == true) {
      request();
    }
    return index;
  }

  void request() async {
    if (todo.length > 0) {
      var out = todo.removeLast();
      var key = out[0];
      var index = out[1];
      if (loadingrequests[key] == null) {
        loadingrequests[key] = {};
      }
      loadingrequests[key]?[index] =
          requests[key]![index]().then((Response response) {
        onCompleteRequest(response, key, index);
        return response;
      });
    }
  }

  void onCompleteRequest(Response response, String key, num index) {
    if (requestResponses[key] == null) {
      requestResponses[key] = {};
    }
    if ((jsonDecode(response.body))["error"] != null) {
      print("there was error on $key $index");
      print(response.body);
      todo.add([key, index]);

      return;
    }
    requestResponses[key]![index] = response;

    notifyListeners();
  }

  Future<Response> waitRequest(String key, {num? index = null}) async {
    index ??= requests[key]!.length - 1;

    if (loadingrequests[key]![index] == null) {
      print("delaying");
      print(requests);
      print(key);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return waitRequest(key, index: index);
    }

    if (requestResponses[key]![index] is Response) {
      notifyListeners();
      return requestResponses[key]![index]!;
    }

    return loadingrequests[key]![index]!;
  }
}
