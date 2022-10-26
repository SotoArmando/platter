import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  SlidingAppBar({
    required this.child,
    required this.controller,
    required this.visible,
  });

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    const background = Image(
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        image: AssetImage('Platter/pic1.jpg'));

    var welcome = SingleChildScrollView(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: SvgPicture.asset(
                        "Platter/globe.svg",
                        height: 23.06125,
                        color: Color.fromARGB(255, 255, 255, 255),
                        matchTextDirection: true,
                      ),
                    )),
              ),
            )
          ],
        ),
        Center(
          child: ElevatedButton(
            // Within the `FirstScreen` widget
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.pushNamed(context, '/second');
            },
            child: const Text('Launch screen'),
          ),
        ),
      ]),
    );

    var appbar = Container(
      height: 57.65,
      child: SlidingAppBar(
        controller: _controller,
        visible: _visible,
        child: AppBar(title: Text('AppBar')),
      ),
    );

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text(_visible ? 'Hide' : 'Show'),
          onPressed: () => setState(() => _visible = !_visible),
        ),
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [background, welcome, appbar],
        ));
  }
}
