import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:p_l_atter/Components/CookingAssistance.dart';
import 'package:p_l_atter/Components/CookingDetails.dart';
import 'package:p_l_atter/Components/Gradienttextspace.dart';
import 'package:p_l_atter/Components/appdrawer.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Preferencesmodel.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Recipeid.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Savemodel.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/UserIsOn.dart';
import 'package:p_l_atter/GraphQl/Changenotifiers/Requestor.dart';
import 'package:p_l_atter/GraphQl/Restclient.dart';
import 'package:p_l_atter/Resources/ad_helper.dart';
import 'package:p_l_atter/Resources/localconfig/platterfont.dart';
import 'package:p_l_atter/Resources/navigatorextension.dart';
import 'package:p_l_atter/Routes/animatedcontainertest.dart';
import 'package:p_l_atter/Routes/categoryscreen.dart';
import 'package:p_l_atter/Routes/home.dart';
import 'package:p_l_atter/Routes/ratiotest.dart';
import 'package:p_l_atter/Routes/search.dart';
import 'package:p_l_atter/Routes/session.dart';
import 'package:p_l_atter/Routes/welcome.dart';
import 'package:p_l_atter/Routes/welcomesignin.dart';
import 'package:p_l_atter/Routes/welcomesignup.dart';
import 'package:p_l_atter/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:cancellation_token_http/http.dart' as http;
import 'package:workmanager/workmanager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final requestor = Requestor();

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Recipeid()),
    ChangeNotifierProvider(create: (context) => Savemodel()),
    ChangeNotifierProvider(create: (context) => Preferencesmodel()),
    ChangeNotifierProvider(create: (context) => UserIsOn()),
    ChangeNotifierProvider(create: (context) => requestor),
  ], child: App()));
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  num currentPage = 0;
  List<String> _currentRoute = ["/welcome"];

  String get currentRoute => _currentRoute.last;

  bool init = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initRequest(BuildContext context) {
    if (init == false) {
      var providedRequestor = Provider.of<Requestor>(context);

      var requestorRequests = {
        "home0": providedRequestor.addRequest(
            "home0",
            (http.CancellationToken token) => RestClient().recipesSearch("",
                recipe_type: "Breakfast", page_number: 5, canceltoken: token)),
        "home1": providedRequestor.addRequest(
            "home1",
            (http.CancellationToken token) => RestClient().recipesSearch("",
                recipe_type: "Breakfast", page_number: 4, canceltoken: token)),
        "home2": providedRequestor.addRequest(
            "home2",
            (http.CancellationToken token) => RestClient().recipesSearch(
                "Sweet",
                recipe_type: "Breakfast",
                canceltoken: token)),
        "home3": providedRequestor.addRequest(
            "home3",
            (http.CancellationToken token) => RestClient()
                .recipesSearch("", page_number: 4, canceltoken: token)),
      };

      init = true;
    }
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

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

  // int returnCurrentActiveIcon() {
  //   var response = [0, 1, 2];

  //   var myarray = [
  //     _currentRoute.lastIndexOf("/second"),
  //     _currentRoute.lastIndexOf("/search"),
  //     _currentRoute.lastIndexOf("/assistance")
  //   ];

  //   myarray.sort();

  //   return response[[
  //     _currentRoute.lastIndexOf("/second"),
  //     _currentRoute.lastIndexOf("/search"),
  //     _currentRoute.lastIndexOf("/assistance")
  //   ].indexOf(myarray.last)];
  // }

  Future<bool> _onWillPop() async {
    if (currentRoute.contains("second")) {
      return false;
    } else {
      _currentRoute.removeLast();
      return true;
    }
    //<-- SEE HERE
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 150),
        reverseTransitionDuration: Duration(milliseconds: 150),
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
          '/details': CookingDetails(),
          '/assistance': Cookingassistance(),
          '/search': Searchscreen(),
          '/category': Categoryscreen(),
          // '/second': (context) => Home(),
        };
        _currentRoute.add(settings.name!);

        if (currentRoute.contains("welcome")) {
          Provider.of<UserIsOn>(context, listen: false).update(false);
        } else {
          Provider.of<UserIsOn>(context, listen: false).update(true);
        }

        return _createRoute(WillPopScope(
          child: appsettings[settings.name] ?? const FirstScreen(),
          onWillPop: _onWillPop,
        ));
      },
      builder: ((context, child) => Scaffold(
            drawer: Drawer(child: Appdrawer()),
            body: child,
            key: _scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(fontSizeNumber(0) * 3.022099448),
              child: Consumer<UserIsOn>(
                builder: (context, userison, child) =>
                    userison.isON ? child! : SizedBox(),
                child: Mainappbar(
                  scaffoldkey: _scaffoldKey,
                ),
              ),
            ),
            bottomNavigationBar: Consumer<UserIsOn>(
              builder: (context, userison, child) =>
                  userison.isON ? child! : SizedBox(),
              child: mainbottomnav(),
            ),
          )),
    );
  }
}

class mainbottomnav extends StatefulWidget {
  int activeicon;
  mainbottomnav({Key? key, this.activeicon = 0}) : super(key: key);

  @override
  _mainbottomnavState createState() => _mainbottomnavState();
}

class _mainbottomnavState extends State<mainbottomnav> {
  void pushNamed(String named) {
    Navigator.of(navigatorKey.currentContext!).pushNamed(named);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: fontSizeNumber(0) * 3.022099448,
        child: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              key: ValueKey("${widget.activeicon == 0}home"),
              icon: GradientTextspace(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0, 1],
                    colors: widget.activeicon == 0
                        ? [
                            Color.fromARGB(255, 10, 0, 6),
                            Color.fromARGB(255, 15, 0, 9),
                          ]
                        : [
                            Color.fromARGB(255, 194, 186, 191),
                            Color.fromARGB(255, 190, 180, 186),
                          ]),
                textspace: SvgPicture.asset(
                  "assets/platter/house.svg",
                  color: Colors.black,
                  height: fontSizeNumber(0) * 1.617995264,
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.activeicon = 0;
                });
                pushNamed('/second');
              },
            ),
            IconButton(
              key: ValueKey("${widget.activeicon == 1}search"),
              icon: GradientTextspace(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0, 1],
                    colors: widget.activeicon == 1
                        ? [
                            Color.fromARGB(255, 10, 0, 6),
                            Color.fromARGB(255, 15, 0, 9),
                          ]
                        : [
                            Color.fromARGB(255, 194, 186, 191),
                            Color.fromARGB(255, 190, 180, 186),
                          ]),
                textspace: SvgPicture.asset(
                  "assets/platter/search.svg",
                  color: Colors.black,
                  height: fontSizeNumber(0) * 1.617995264,
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.activeicon = 1;
                });
                pushNamed('/search');
              },
            ),
            IconButton(
              key: ValueKey("${widget.activeicon == 2}assistance"),
              icon: GradientTextspace(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0, 1],
                    colors: widget.activeicon == 2
                        ? [
                            Color.fromARGB(255, 10, 0, 6),
                            Color.fromARGB(255, 15, 0, 9),
                          ]
                        : [
                            Color.fromARGB(255, 194, 186, 191),
                            Color.fromARGB(255, 190, 180, 186),
                          ]),
                textspace: SvgPicture.asset(
                  "assets/platter/library.svg",
                  color: Colors.black,
                  height: fontSizeNumber(0) * 1.617995264,
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.activeicon = 2;
                });
                pushNamed('/assistance');
              },
            ),
          ],
        )));
  }
}

class Mainappbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  Mainappbar({Key? key, required this.scaffoldkey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,

      bottom: PreferredSize(
          child: Container(
            color: Color(0xFFF5F6F8),
            height: PixelNumberfromFigma(1),
          ),
          preferredSize: Size.fromHeight(PixelNumberfromFigma(1))),
      leading: Row(children: [
        IconButton(
          icon: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: fontSizeNumber(3.000001)),
              child: SvgPicture.asset(
                "assets/platter/menu.svg",
                color: Color(0xFF3C3C3C),
                height: fontSizeNumber(0) * 1.183898974,
              )),
          onPressed: () {
            scaffoldkey.currentState!.openDrawer();
          },
        ),
      ]),
      // actions: [],
      toolbarHeight: fontSizeNumber(0) * 3.022099448,
      backgroundColor: Colors.white,
    );
  }
}
