import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../widgets/arafat_time_lift.dart';
import '../widgets/daily_ayah.dart';
import '../widgets/home_card.dart';
import '../widgets/home_hero_section.dart';
import '../widgets/prayer_times.dart';
import '../widgets/quick_actions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final viewportHeight = constraints.maxHeight;
            final viewportWidth = constraints.maxWidth;

            final isDesktopLayout = viewportWidth >= 1040;

            final heroHeight = isDesktopLayout
                ? (viewportHeight * 0.20).clamp(300.0, 420.0)
                : (viewportHeight * 0.35).clamp(300.0, 420.0);
            final overlap = (viewportHeight * 0.10).clamp(60.0, 90.0);

            final horizontalPadding = 24.0;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: heroHeight,
                      decoration: BoxDecoration(color: cs.primary),
                    ),
                  ),
                  Positioned(
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
                  Positioned.fromRelativeRect(
                    rect: RelativeRect.fromLTRB(0, heroHeight, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE5E0D6).withValues(alpha: .23),
                      ),
                    ),
                  ),
                  Positioned.fromRelativeRect(
                    rect: RelativeRect.fromLTRB(0, heroHeight, 0, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.background),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: heroHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: const HomeHeroSection(),
                      ),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: 0.0),
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeOutQuart,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, -overlap + (value * 120)),
                            child: Opacity(
                              opacity: (1.0 - value).clamp(0.0, 1.0),
                              child: child,
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: const Column(
                            spacing: 30,
                            children: [
                              HomeCard(),
                              ArafatTimeLift(),
                              PrayerTimes(),
                              QuickActions(),
                              DailyAyah(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
