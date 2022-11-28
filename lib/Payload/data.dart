import 'dart:convert';

import 'package:flutter/services.dart';

Future<dynamic> readJson() async {
  final String response = await rootBundle.loadString('assets/sample.json');
  final data = await json.decode(response);
  return data["results"];
}
