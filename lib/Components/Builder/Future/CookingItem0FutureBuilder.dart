import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_l_atter/Components/Builder/CookingItem0.dart';
import 'package:p_l_atter/Components/Textspace.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/GraphQl/tell.dart';
import 'package:p_l_atter/Payload/data.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:cancellation_token_http/http.dart' as http;

Future<http.Response> ass() async {
  return RestClient().recipesSearch("query");
}

class CookingItem0FutureBuilder extends StatefulWidget {
  final Function readJson;

  const CookingItem0FutureBuilder({Key? key, this.readJson = ass})
      : super(key: key);

  @override
  _CookingItem0FutureBuilderState createState() =>
      _CookingItem0FutureBuilderState();
}

class _CookingItem0FutureBuilderState extends State<CookingItem0FutureBuilder> {
  Future<http.Response>? loadFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFuture = widget.readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<http.Response>(
          future: loadFuture,
          builder: (context, responseSnapshot) {
            List<Widget> children;
            if (responseSnapshot.connectionState == ConnectionState.done ||
                (responseSnapshot.hasData &&
                    "${jsonDecode(responseSnapshot.data!.body)["error"]}" ==
                        "null")) {
              dynamic data = [];
              try {
                data =
                    jsonDecode(responseSnapshot.data!.body ?? "{}")["recipes"]
                        ["recipe"];
              } catch (e) {
                //
              }

              children = [
                Container(
                  // color: Colors.red[300],
                  height: fontSizeNumber(0) * 13.6148382,
                  alignment: Alignment.bottomLeft,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: fontSizeNumber(0) * 1.183898974,
                      // top: fontSizeNumber(0) * 1.63851618,
                      // bottom: fontSizeNumber(0) * 1.63851618
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: data?.length,
                    itemBuilder: (context, index) => Cookingitem0(
                      data: data?[index],
                    ),
                  ),
                )
              ];
            } else {
              children = [
                Column(
                  children: const [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ],
                )
              ];
            }

            try {
              return (responseSnapshot.connectionState ==
                          ConnectionState.done ||
                      (responseSnapshot.hasData &&
                          "${jsonDecode(responseSnapshot.data!.body)["error"]}" ==
                              "null"))
                  ? Column(
                      children: children,
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: CircularProgressIndicator(),
                    );
            } catch (e) {
              return const Padding(
                padding: EdgeInsets.only(top: 15),
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Positioned.fill(
            child: IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [
                    0,
                    .10,
                    .90,
                    1
                  ],
                  colors: [
                    const Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.000),
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.000),
                    const Color.fromARGB(255, 255, 0, 150).withOpacity(0.005),
                    // Color.fromARGB(255, 162, 0, 255).withOpacity(0.005),
                    // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                    // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                    // Color.fromARGB(255, 140, 0, 255).withOpacity(0.005),
                  ]),
            ),
          ),
        ))
      ],
    );
  }
}
