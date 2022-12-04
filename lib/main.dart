import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:p_l_atter/Components/CookingAssistance.dart';
import 'package:p_l_atter/Components/CookingDetails.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/Loadingscreen.dart';
import 'package:p_l_atter/Components/aboutus.dart';
import 'package:p_l_atter/Components/appdrawer.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Loaduntil.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Preferencesmodel.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Recipeid.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/UserIsOn.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/ad_helper.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';

import 'package:p_l_atter/Routes/blog.dart';
import 'package:p_l_atter/Routes/categoryscreen.dart';
import 'package:p_l_atter/Routes/home.dart';
import 'package:p_l_atter/Routes/rivetest.dart';
import 'package:p_l_atter/Routes/search.dart';
import 'package:p_l_atter/Routes/welcome.dart';
import 'package:p_l_atter/Routes/welcomesignin.dart';
import 'package:p_l_atter/Routes/welcomesignup.dart';
import 'package:p_l_atter/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:cancellation_token_http/http.dart' as http;
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var providedRequestor = Requestor();
  var providedSavemodel = Savemodel();
  var loaduntil = Loaduntil();

  providedRequestor.addRequest(
      "home0",
      (http.CancellationToken token) => RestClient().recipesSearch("",
          recipe_type: "Breakfast", page_number: 5, canceltoken: token));
  providedRequestor.addRequest(
      "home1",
      (http.CancellationToken token) => RestClient().recipesSearch("",
          recipe_type: "Breakfast", page_number: 4, canceltoken: token));
  providedRequestor.addRequest(
      "home2",
      (http.CancellationToken token) => RestClient().recipesSearch("Sweet",
          recipe_type: "Breakfast", canceltoken: token));
  providedRequestor.addRequest(
      "home3",
      (http.CancellationToken token) =>
          RestClient().recipesSearch("", page_number: 4, canceltoken: token));

  loaduntil.loaduntil(() => Future.wait([
        providedRequestor.waitRequest("home0"),
        providedRequestor.waitRequest("home1"),
        providedRequestor.waitRequest("home2"),
        providedRequestor.waitRequest("home3"),
      ]));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Recipeid()),
    ChangeNotifierProvider(create: (context) => providedRequestor),
    ChangeNotifierProvider(create: (context) => Preferencesmodel()),
    ChangeNotifierProvider(create: (context) => UserIsOn()),
    ChangeNotifierProvider(create: (context) => providedSavemodel),
    ChangeNotifierProvider(create: (context) => loaduntil),
  ], child: App()));
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  num currentPage = 0;
  String popableroutename = "";
  List<String> _currentRoute = ["/welcome"];

  String get currentRoute => _currentRoute.last;

  bool init = false;

  void initRequest(BuildContext context) {
    if (init == false) {
      init = true;
    }
  }

  void pushNameonApp(String name) {
    setState(() {
      _currentRoute.add(name);
    });
  }

  @override
  void initState() {
    super.initState();

    // _initGoogleMobileAds();
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor:
    //         Colors.white.withOpacity(0.54), // You can use this as well
    //     statusBarIconBrightness:
    //         Brightness.light, // OR Vice Versa for ThemeMode.dark
    //     statusBarBrightness:
    //         Brightness.light, // OR Vice Versa for ThemeMode.dark
    //   ),
    // );
    return;
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    AdHelper.nativeAdUnitId;
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  int returnCurrentActiveIcon() {
    var i = [
      _currentRoute.lastIndexOf("/second"),
      _currentRoute.lastIndexOf("/search"),
      _currentRoute.lastIndexOf("/assistance")
    ];
    i.sort();
    Map<String, int> b = {
      "/second": 0,
      "/search": 1,
      "/assistance": 2,
    };
    var last = i.last == -1 ? 0 : i.last;
    // print("returnCurrentActiveIcon!");
    // print(_currentRoute);
    // print(i);
    // print(last);
    // print(b[_currentRoute[last]]);
    return (b[last == 0 ? "/second" : _currentRoute[last]] ?? 0) + 1;
  }

  Future<bool> _onWillPop() async {
    if (currentRoute.contains("second")) {
      return false;
    } else {
      // print("popping!");
      // print(currentRoute);
      // print(popableroutename);
      _currentRoute.removeLast();
      setState(() {});
      return true;
    }

    //<-- SEE HERE
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeOutCirc;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (init == false) {
      initRequest(context);
    }

    final toggler = Provider.of<UserIsOn>(context, listen: false);
    return MaterialApp(
      title: 'Plater Kitchen Learning Enterprise',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/welcome',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        Map<String, Widget> appsettings = {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/welcome': const FirstScreen(),
          '/welcome_signin': Welcomesignin(),
          '/welcome_signup': Welcomesignup(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/second': Home(),
          '/details': const CookingDetails(),
          '/assistance': Cookingassistance(),
          '/search': Searchscreen(),
          '/category': Categoryscreen(),
          '/blog': Blog(),
          '/about': Aboutus(),
          '/test': const Rivetest(),
          // '/second': (context) => Home(),
        };
        popableroutename = settings.name!;
        if (currentRoute != settings.name!) {
          _currentRoute.add(settings.name!);
        }
        if (currentRoute.contains("welcome")) {
          (() async {
            await Future<void>.delayed(const Duration(seconds: 1));
            toggler.update(false);
          })();
        } else {
          (() async {
            await Future<void>.delayed(const Duration(seconds: 1));
            toggler.update(true);
          })();
        }

        return _createRoute(WillPopScope(
          onWillPop: _onWillPop,
          child: appsettings[settings.name] ?? const FirstScreen(),
        ));
      },
      builder: ((context, child) => Scaffold(
            drawer: Drawer(child: Appdrawer()),
            body: Stack(
              fit: StackFit.expand,
              children: [child!, const Loadingscreen()],
            ),
            key: scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(fontSizeNumber(0) * 3.022099448),
              child: Consumer<UserIsOn>(
                builder: (context, userison, child) =>
                    userison.isON ? child! : const SizedBox(),
                child: Stack(children: [
                  const Mainappbar(),
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
                              const Color.fromARGB(255, 255, 0, 150)
                                  .withOpacity(0.005),
                              const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.000),
                              const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.000),
                              const Color.fromARGB(255, 255, 0, 150)
                                  .withOpacity(0.005),
                              // Color.fromARGB(255, 162, 0, 255).withOpacity(0.005),
                              // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                              // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                              // Color.fromARGB(255, 140, 0, 255).withOpacity(0.005),
                            ]),
                      ),
                    ),
                  ))
                ]),
              ),
            ),
            bottomNavigationBar: Consumer<UserIsOn>(
                builder: (context, userison, child) =>
                    userison.isON ? child! : const SizedBox(),
                child: Stack(
                  children: [
                    Mainbottomnav(
                      key: ValueKey(_currentRoute),
                      pushNameonApp: pushNameonApp,
                      activeicon: returnCurrentActiveIcon(),
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
                                .50,
                                .90,
                                1
                              ],
                              colors: [
                                const Color.fromARGB(255, 255, 0, 150)
                                    .withOpacity(0.005),
                                const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.000),
                                const Color.fromARGB(255, 255, 0, 150)
                                    .withOpacity(0.005),
                                const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.000),
                                const Color.fromARGB(255, 255, 0, 150)
                                    .withOpacity(0.005),
                                // Color.fromARGB(255, 162, 0, 255).withOpacity(0.005),
                                // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                                // Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                                // Color.fromARGB(255, 140, 0, 255).withOpacity(0.005),
                              ]),
                        ),
                      ),
                    ))
                  ],
                )),
          )),
    );
  }
}

class Mainbottomnav extends StatefulWidget {
  final int activeicon;
  final Function(String name) pushNameonApp;
  const Mainbottomnav(
      {Key? key, required this.activeicon, required this.pushNameonApp})
      : super(key: key);

  @override
  _MainbottomnavState createState() => _MainbottomnavState();
}

class _MainbottomnavState extends State<Mainbottomnav> {
  late int activeicon = widget.activeicon - 1;

  @override
  void initState() {
    super.initState();
  }

  void pushNamed(String named) {
    Navigator.of(navigatorKey.currentContext!).pushNamed(named);
  }

  @override
  Widget build(BuildContext context) {
    activeicon = widget.activeicon - 1;
    return SizedBox(
        height: fontSizeNumber(0) * 3.022099448,
        child: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              key: ValueKey("${activeicon == 0}home"),
              icon: GradientTextspace(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0, 1],
                    colors: activeicon == 0
                        ? [
                            const Color.fromARGB(255, 10, 0, 6),
                            const Color.fromARGB(255, 15, 0, 9),
                          ]
                        : [
                            const Color.fromARGB(255, 194, 186, 191),
                            const Color.fromARGB(255, 190, 180, 186),
                          ]),
                textspace: SvgPicture.asset(
                  "assets/platter/house.svg",
                  color: Colors.black,
                  height: fontSizeNumber(0) * 1.617995264,
                ),
              ),
              onPressed: () {
                if (activeicon != 0) {
                  widget.pushNameonApp('/second');
                  pushNamed('/second');
                }
              },
            ),
            IconButton(
              key: ValueKey("${activeicon == 1}search"),
              icon: GradientTextspace(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0, 1],
                    colors: activeicon == 1
                        ? [
                            const Color.fromARGB(255, 10, 0, 6),
                            const Color.fromARGB(255, 15, 0, 9),
                          ]
                        : [
                            const Color.fromARGB(255, 194, 186, 191),
                            const Color.fromARGB(255, 190, 180, 186),
                          ]),
                textspace: SvgPicture.asset(
                  "assets/platter/search.svg",
                  color: Colors.black,
                  height: fontSizeNumber(0) * 1.617995264,
                ),
              ),
              onPressed: () {
                if (activeicon != 1) {
                  widget.pushNameonApp('/search');
                  pushNamed('/search');
                }
              },
            ),
            IconButton(
              key: ValueKey("${activeicon == 2}assistance"),
              icon: GradientTextspace(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0, 1],
                    colors: activeicon == 2
                        ? [
                            const Color.fromARGB(255, 10, 0, 6),
                            const Color.fromARGB(255, 15, 0, 9),
                          ]
                        : [
                            const Color.fromARGB(255, 194, 186, 191),
                            const Color.fromARGB(255, 190, 180, 186),
                          ]),
                textspace: SvgPicture.asset(
                  "assets/platter/library.svg",
                  color: Colors.black,
                  height: fontSizeNumber(0) * 1.617995264,
                ),
              ),
              onPressed: () {
                if (activeicon != 2) {
                  widget.pushNameonApp('/assistance');
                  pushNamed('/assistance');
                }
              },
            ),
          ],
        )));
  }
}

class Mainappbar extends StatelessWidget {
  const Mainappbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(pixelNumberfromFigma(1)),
        child: Container(
          color: const Color(0xFFF5F6F8),
          height: pixelNumberfromFigma(1),
        ),
      ),
      leading: Row(children: [
        IconButton(
          icon: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: fontSizeNumber(3.000001)),
              child: SvgPicture.asset(
                "assets/platter/menu.svg",
                color: const Color(0xFF3C3C3C),
                height: fontSizeNumber(0) * 1.183898974,
              )),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ]),
      // actions: [],
      toolbarHeight: fontSizeNumber(0) * 3.022099448,
      backgroundColor: Colors.white,
    );
  }
}
