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
  Map<String, num> retries = {};
  List<List<dynamic>> todo = [];
  List<bool Function()> delayed = [];
  Future? doRequest;

  num addRequest(
      String key, Future<Response> Function(CancellationToken token) Request,
      {bool now = false, override = false}) {
    var index = 0;

    if (!(requests[key]?.isNotEmpty ?? false) || override) {
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
    }

    if (now == true) {
      requestanyRequest(now: true);
    } else {
      requestanyRequest();
    }
    return index;
  }

  void cancel(String key) {
    cancelTokens[key]?.last.cancel();
    if (cancelTokens[key] == null) {
      print("this cancelled nothing");
    }
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
    retries[key] ??= 1;
    final notok = response.body.contains("error");
    if (notok &&
        retries[key]! <= 10 &&
        jsonDecode(response.body)["error"]["code"] != 106) {
      // print("there was error on $key $index");
      // print(response.body);
      retries[key] = retries[key]! + 1;
      todo.add([key, index]);
      requestanyRequest();
    } else {
      requestResponses[key]![index] = response;
      notifyListeners();
    }
  }

  void requestanyRequest({bool now = false}) {
    doRequest = null;
    doRequest = Future.doWhile(() async {
      if (todo.isNotEmpty) {
        request();
        if (now == false) {
          await Future.delayed(const Duration(seconds: 1));
        }
      }

      return todo.isNotEmpty;
    });
  }

  Future<dynamic> awaitanyDelayed() async {
    var doWhile = await Future.doWhile(() async {
      if (!(delayed.every((element) => element()) == true) == false) {
        return false;
      }
      await Future.delayed(const Duration(seconds: 1));
      print(delayed);
      return !(delayed.every((element) => element()) == true);
    });

    return doWhile;
  }

  Future<Response> waitRequest(String key,
      {num? index, num retry = 0, bool wasAdded = false}) async {
    requests[key] ??= [];
    index ??= requests[key]!.isNotEmpty ? requests[key]!.length - 1 : 0;

    var response = requestResponses[key]?[index];

    final ok = !(response?.body.contains("error") ?? true);
    if (response is Response && ok) {
      // print("stopped waiting $key $index REASON: OK FLAG");
      // print(response.body);
      return response;
    }

    if (wasAdded == false) {
      if (!key.contains("addhistory")) {
        delayed.add(() {
          if (cancelTokens[key]!.last.isCancelled == true) {
            return true;
          }
          if (requestResponses[key]?[index] is Response) {
            return requestResponses[key]?[index]!.statusCode == 200;
          }

          return false;
        });
      }
    }
    print("done awaitanyDelayed");
    await awaitanyDelayed();

    delayed.removeWhere((element) => element() == true);

    if (response is Response && ok) {
      // print("stopped waiting $key $index REASON: OK FLAG");
      // print(response.body);
      return response;
    }

    if (key.contains("addhistory")) {
      if (loadingrequests[key]?[index]! == null) {
        return Response("", 400);
      } else {
        return loadingrequests[key]![index]!;
      }
    }

    if (cancelTokens[key]!.last.isCancelled == true) {
      return Response("", 400);
    }

    var nextresponse =
        await waitRequest(key, index: index, retry: retry + 1, wasAdded: true);

    return nextresponse;
  }
}
