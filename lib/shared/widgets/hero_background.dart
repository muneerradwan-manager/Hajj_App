import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/constants/app_images.dart';

/// Provides the four stacked background layers used by all major views
/// (Login, Register, ForgetPassword, Home).
///
/// Returns a list of [Positioned] widgets to spread into a parent [Stack]:
/// ```dart
/// Stack(children: [
///   ...HeroBackground.layers(context, heroHeight),
///   Column(...),
/// ])
/// ```
abstract final class HeroBackground {
  static List<Widget> layers(BuildContext context, double heroHeight) {
    final cs = Theme.of(context).colorScheme;

    return [
      // 1. Solid primary
      Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Container(
          height: heroHeight,
          decoration: BoxDecoration(color: cs.primary),
        ),
      ),
      // 2. Background image over hero (low opacity)
      Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Opacity(
          opacity: .1,
          child: Container(
            height: heroHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      // 3. Tinted overlay below hero
      Positioned.fromRelativeRect(
        rect: RelativeRect.fromLTRB(0, heroHeight, 0, 0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.overlay.withValues(alpha: .23),
          ),
        ),
      ),
      // 4. Background image below hero
      Positioned.fromRelativeRect(
        rect: RelativeRect.fromLTRB(0, heroHeight, 0, 0),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.background),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    ];
  }
}
