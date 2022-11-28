import 'package:flutter/material.dart';
import 'package:p_l_atter/Components/Textspace.dart';

class GradientTextspace extends StatelessWidget {
  const GradientTextspace({
    required this.gradient,
    required this.textspace,
    this.style,
  });

  final TextStyle? style;
  final Widget textspace;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: textspace,
    );
  }
}
