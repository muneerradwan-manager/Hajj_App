import 'package:flutter/material.dart';

import '../../../../shared/widgets/card_entry_animation.dart';
import '../../../../shared/widgets/hero_background.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_hero_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
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
            const horizontalPadding = 20.0;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Stack(
                children: [
                  ...HeroBackground.layers(context, heroHeight),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: heroHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: const ProfileHeroSection(),
                      ),
                      CardEntryAnimation(
                        overlap: overlap,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: ProfileCard(),
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
