import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hajj_app/features/splash/presentation/widgets/splash_pulse_indicator.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

import '../../../../core/constants/app_images.dart';
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
      duration: const Duration(
        milliseconds: 6500,
      ), // Slightly longer total time
    );

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // --- IMAGE ANIMATION: WIDER FADE WINDOW ---
    _imageScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.00, 0.50, curve: Curves.easeOutCubic),
      ),
    );

    // Image Fade now takes 50% of the entire duration to feel "breathable"
    _imageFade = _fade(0.00, 0.50);

    // --- CONTENT: STAGGERED TO START AFTER IMAGE IS VISIBLE ---
    _titleSlide = _slide(0.40, 0.60);
    _titleFade = _fade(0.40, 0.60);

    _subtitleSlide = _slide(0.50, 0.70);
    _subtitleFade = _fade(0.50, 0.70);

    _dotsSlide = _slide(0.60, 0.80);
    _dotsFade = _fade(0.60, 0.80);

    _basmalaSlide = _slide(0.80, 0.98);
    _basmalaFade = _fade(0.80, 0.98);

    _controller.addListener(() {
      if (!_isDotsAnimationStarted && _controller.value >= 0.60) {
        if (!mounted) return;
        _isDotsAnimationStarted = true;
        _dotsController.repeat();
      }
    });

    _controller.forward();

    // Navigation starts after the sequence finishes
    _navigationTimer = Timer(const Duration(milliseconds: 7000), _goToLogin);
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

  Animation<Offset> _slide(double begin, double end) {
    return Tween<Offset>(
      begin: const Offset(0, 0.20),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: Curves.easeOutQuart),
      ),
    );
  }

  Animation<double> _fade(double begin, double end) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeInCubic),
    );
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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(decoration: BoxDecoration(color: cs.primary)),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: .1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.background),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Center(
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
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(AppImages.logo, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  _slideFade(
                    slide: _titleSlide,
                    fade: _titleFade,
                    child: const CustomText(
                      'app.title',
                      textAlign: TextAlign.center,
                      type: CustomTextType.headlineLarge,
                      color: CustomTextColor.white,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _slideFade(
                    slide: _subtitleSlide,
                    fade: _subtitleFade,
                    child: const CustomText(
                      'app.subtitle',
                      textAlign: TextAlign.center,
                      type: CustomTextType.bodyLarge,
                      color: CustomTextColor.lightGold,
                    ),
                  ),
                  const SizedBox(height: 36),
                  _slideFade(
                    slide: _dotsSlide,
                    fade: _dotsFade,
                    child: SplashPulseIndicator(
                      animation: _dotsController,
                      dotSize: _dotSize,
                      dotSpacing: _dotSpacing,
                      inactiveColor: const Color(0x99E3DDD2),
                      activeColor: cs.surfaceDim,
                    ),
                  ),
                  const SizedBox(height: 36),
                  _slideFade(
                    slide: _basmalaSlide,
                    fade: _basmalaFade,
                    child: const CustomText(
                      'app.basmala',
                      textAlign: TextAlign.center,
                      type: CustomTextType.bodyLarge,
                      color: CustomTextColor.lightGold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
