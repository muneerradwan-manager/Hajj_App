import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bawabatelhajj/core/di/dependency_injection.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/widgets/login/login_card.dart';
import 'package:bawabatelhajj/features/auth/presentation/widgets/login/login_hero_section.dart';
import 'package:bawabatelhajj/shared/widgets/card_entry_animation.dart';
import 'package:bawabatelhajj/shared/widgets/hero_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: _loginContent(),
    );
  }

  Scaffold _loginContent() {
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
              physics: const AlwaysScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                // Forces the Stack to be at least as tall as the screen
                constraints: BoxConstraints(minHeight: viewportHeight),
                child: Stack(
                  children: [
                    // Background layers now stretch to fill the ConstrainedBox
                    ...HeroBackground.layers(context, heroHeight),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: heroHeight,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: LoginHeroSection(logoSize: logoSize),
                        ),
                        CardEntryAnimation(
                          overlap: overlap,
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
