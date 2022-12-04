import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Rivetest extends StatefulWidget {
  const Rivetest({Key? key}) : super(key: key);

  @override
  _RivetestState createState() => _RivetestState();
}

class _RivetestState extends State<Rivetest> {
  /// Controller for playback
  late RiveAnimationController _controller;

  /// Is the animation currently playing?
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'Like',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );
    _controller.isActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('One-Shot Example'),
      ),
      body: const Center(
        child: RiveAnimation.asset(
          'assets/platter/like.riv',
          stateMachines: ['State Machine 1'],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // disable the button while playing the animation
        onPressed: () => _isPlaying ? null : _controller.isActive = true,
        tooltip: 'Like',
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
