import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  static const double _dotSize = 12;
  static const double _dotSpacing = 5;

  late final AnimationController _controller;
  late final AnimationController _dotsController;
  Timer? _navigationTimer;
  bool _isDotsAnimationStarted = false;

  late final Animation<double> _imageScale;
  late final Animation<double> _imageFade;

  late final Animation<Offset> _titleSlide;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<Offset> _dotsSlide;
  late final Animation<Offset> _basmalaSlide;

  late final Animation<double> _titleFade;
  late final Animation<double> _subtitleFade;
  late final Animation<double> _dotsFade;
  late final Animation<double> _basmalaFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    );
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _imageScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.00, 0.20, curve: Curves.easeOutBack),
      ),
    );
    _imageFade = _fade(0.00, 0.20);

    _titleSlide = _slide(0.22, 0.36);
    _titleFade = _fade(0.22, 0.36);

    _subtitleSlide = _slide(0.40, 0.54);
    _subtitleFade = _fade(0.40, 0.54);

    _dotsSlide = _slide(0.58, 0.70);
    _dotsFade = _fade(0.58, 0.70);

    _basmalaSlide = _slide(0.88, 1.00);
    _basmalaFade = _fade(0.88, 1.00);

    _controller.addListener(() {
      if (!_isDotsAnimationStarted && _controller.value >= 0.58) {
        _isDotsAnimationStarted = true;
        _dotsController.repeat();
      }
    });

    _controller.forward();
    _navigationTimer = Timer(const Duration(milliseconds: 5200), _goToLogin);
  }

  void _goToLogin() {
    if (!mounted) return;
    context.go(AppRoutes.loginPath);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _dotsController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget _slideFade({
    required Animation<Offset> slide,
    required Animation<double> fade,
    required Widget child,
  }) {
    return SlideTransition(
      position: slide,
      child: FadeTransition(opacity: fade, child: child),
    );
  }

  Widget _scaleFade({
    required Animation<double> scale,
    required Animation<double> fade,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: fade,
      child: ScaleTransition(scale: scale, child: child),
    );
  }

  Animation<Offset> _slide(double begin, double end) {
    return Tween<Offset>(
      begin: const Offset(0, 0.45),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: Curves.easeOutCubic),
      ),
    );
  }

  Animation<double> _fade(double begin, double end) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeOut),
    );
  }

  Widget _buildPulseIndicator() {
    return AnimatedBuilder(
      animation: _dotsController,
      builder: (context, child) {
        final progress = _dotsController.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: _dotSpacing,
          children: [
            _pulseDot(0, progress),
            _pulseDot(1, progress),
            _pulseDot(2, progress),
          ],
        );
      },
    );
  }

  Widget _pulseDot(int index, double progress) {
    final scale = _dotScale(index, progress);
    final emphasis = ((scale - 1) / 0.45).clamp(0.0, 1.0);
    final color = Color.lerp(
      const Color(0x99E3DDD2),
      const Color(0xffE3DDD2),
      emphasis,
    )!;

    return Transform.scale(
      scale: scale,
      child: Container(
        width: _dotSize,
        height: _dotSize,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff00594F)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _scaleFade(
                  scale: _imageScale,
                  fade: _imageFade,
                  child: SizedBox(
                    height: 248,
                    width: 302,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                _slideFade(
                  slide: _titleSlide,
                  fade: _titleFade,
                  child: Text(
                    'بوابة الحاج',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                _slideFade(
                  slide: _subtitleSlide,
                  fade: _subtitleFade,
                  child: Text(
                    'إدارة الحج والعمرة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffE3DDD2),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                _slideFade(
                  slide: _dotsSlide,
                  fade: _dotsFade,
                  child: _buildPulseIndicator(),
                ),
                const SizedBox(height: 36),
                _slideFade(
                  slide: _basmalaSlide,
                  fade: _basmalaFade,
                  child: Text(
                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffE3DDD2),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
