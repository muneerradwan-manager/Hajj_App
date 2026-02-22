import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_images.dart';
import 'package:hajj_app/features/auth/presentation/widgets/login/login_card.dart';
import 'package:hajj_app/features/auth/presentation/widgets/login/login_hero_section.dart';

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
            final isDesktopLayout = viewportWidth >= 1024;

            final heroHeight = isDesktopLayout
                ? (viewportHeight * 0.50).clamp(360.0, 500.0)
                : (viewportHeight * 0.45).clamp(320.0, 420.0);
            final overlap = isDesktopLayout
                ? (viewportHeight * 0.04).clamp(0.0, 28.0)
                : (viewportHeight * 0.10).clamp(60.0, 90.0);

            final horizontalPadding = viewportWidth < 390
                ? 24.0
                : isTabletLayout
                ? 28.0
                : 18.0;
            final logoSize = (viewportWidth * 0.30).clamp(90.0, 120.0);
            final cardMaxWidth = isDesktopLayout ? 560.0 : 720.0;

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
                        decoration: BoxDecoration(
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
                        height: heroHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: LoginHeroSection(logoSize: logoSize),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        child: TweenAnimationBuilder<double>(
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
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: cardMaxWidth,
                                ),
                                child: const LoginCard(),
                              ),
                            ),
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
