import 'package:flutter/material.dart';

class SplashPulseIndicator extends StatelessWidget {
  const SplashPulseIndicator({
    super.key,
    required this.animation,
    required this.dotSize,
    required this.dotSpacing,
    required this.inactiveColor,
    required this.activeColor,
  });

  final Animation<double> animation;
  final double dotSize;
  final double dotSpacing;
  final Color inactiveColor;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = animation.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: dotSpacing,
          children: [
            _pulseDot(index: 0, progress: progress),
            _pulseDot(index: 1, progress: progress),
            _pulseDot(index: 2, progress: progress),
          ],
        );
      },
    );
  }

  Widget _pulseDot({required int index, required double progress}) {
    final scale = _dotScale(index, progress);
    final emphasis = ((scale - 1) / 0.45).clamp(0.0, 1.0);
    final color = Color.lerp(inactiveColor, activeColor, emphasis)!;

    return Transform.scale(
      scale: scale,
      child: Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }

  double _dotScale(int index, double progress) {
    final phase = (progress * 3) % 3;
    var distance = (phase - index).abs();
    if (distance > 1.5) {
      distance = 3 - distance;
    }

    final activation = (1 - distance).clamp(0.0, 1.0);
    return 1 + (0.45 * Curves.easeOut.transform(activation));
  }
}
