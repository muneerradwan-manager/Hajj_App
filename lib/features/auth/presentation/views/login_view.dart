import 'package:bawabatelhajj/shared/widgets/custom_container.dart'
    show CustomContainer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bawabatelhajj/core/di/dependency_injection.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/widgets/login/login_card.dart';
import 'package:bawabatelhajj/features/auth/presentation/widgets/login/login_hero_section.dart';
import 'package:bawabatelhajj/shared/widgets/card_entry_animation.dart';
import 'package:bawabatelhajj/shared/widgets/exit_app_dialog.dart';
import 'package:bawabatelhajj/shared/widgets/hero_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _handleExitRequest() async {
    final shouldExit = await showExitAppDialog(context);
    if (!mounted || shouldExit != true) return;
    await SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          _handleExitRequest();
        },
        child: _loginContent(),
      ),
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
            final heroHeight = (viewportHeight * 0.45).clamp(320.0, 420.0);
            final overlap = (viewportHeight * 0.10).clamp(60.0, 90.0);
            final horizontalPadding = viewportWidth < 390
                ? 24.0
                : isTabletLayout
                ? 28.0
                : 18.0;

            final logoSize = (viewportWidth * 0.30).clamp(90.0, 120.0);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewportHeight),
                child: Stack(
                  children: [
                    ...HeroBackground.layers(context, heroHeight),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomContainer(
                          borderWidth: 0,
                          containerColor: Colors.transparent,
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
                            child: const Align(
                              alignment: Alignment.topCenter,
                              child: LoginCard(),
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
