import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_images.dart';
import 'package:hajj_app/features/auth/presentation/widgets/login_card.dart';
import 'package:hajj_app/features/auth/presentation/widgets/login_hero_section.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            final isTabletLayout = viewportWidth >= 700;

            final heroHeight = (viewportHeight * 0.45).clamp(320.0, 420.0);
            final overlap = (viewportHeight * 0.10).clamp(60.0, 90.0);

            final horizontalPadding = viewportWidth < 390
                ? 24.0
                : isTabletLayout
                ? 28.0
                : 18.0;
            final logoSize = (viewportWidth * 0.30).clamp(90.0, 120.0);

            return DecoratedBox(
              decoration: BoxDecoration(color: cs.surfaceDim),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
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
                          decoration: BoxDecoration(color: cs.primary),
                          height: heroHeight,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: LoginHeroSection(logoSize: logoSize),
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
                            child: const Align(
                              alignment: Alignment.topCenter,
                              child: LoginCard(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
