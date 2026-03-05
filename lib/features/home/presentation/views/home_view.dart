import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bawabatelhajj/core/di/dependency_injection.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_state.dart';

import 'package:bawabatelhajj/shared/widgets/card_entry_animation.dart';
import 'package:bawabatelhajj/shared/widgets/hero_background.dart';
import 'package:bawabatelhajj/shared/widgets/custom_snackbar.dart';

import '../cubits/prayer_times_cubit.dart';
import '../widgets/send_help_button.dart';
import '../widgets/timer_lift.dart';
import '../widgets/hajj_ayah.dart';
import '../widgets/home_card.dart';
import '../widgets/home_hero_section.dart';
import '../widgets/prayer_times.dart';
import '../widgets/quick_actions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PrayerTimesCubit>(),
      child: BlocListener<MeCubit, MeState>(
        listenWhen: (previous, current) =>
            previous.isNetworkError != current.isNetworkError ||
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (!state.isNetworkError || state.errorMessage.isEmpty) return;
          final isCurrentRoute = ModalRoute.of(context)?.isCurrent ?? true;
          if (!isCurrentRoute) return;
          showMessage(
            context,
            'There is no internet connection',
            SnackBarType.failuer,
          );
        },
        child: _homeContent(),
      ),
    );
  }

  Scaffold _homeContent() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final viewportHeight = constraints.maxHeight;
            final viewportWidth = constraints.maxWidth;
            final topPadding = MediaQuery.of(context).padding.top;

            final isDesktopLayout = viewportWidth >= 1040;
            final heroHeight = isDesktopLayout
                ? (viewportHeight * 0.20).clamp(300.0, 420.0)
                : (viewportHeight * 0.30).clamp(260.0, 380.0) + topPadding;

            final overlap = (viewportHeight * 0.08).clamp(50.0, 80.0);
            const horizontalPadding = 20.0;

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<MeCubit>().loadMe(forceRefresh: true);
              },
              child: SingleChildScrollView(
                // Ensure physics are always scrollable for the RefreshIndicator to trigger
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    // Forces the Stack to be at least as tall as the screen height
                    minHeight: viewportHeight,
                  ),
                  child: Stack(
                    children: [
                      // Background layers now stretch to fill the viewport
                      ...HeroBackground.layers(context, heroHeight),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: heroHeight,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: const HomeHeroSection(),
                          ),
                          CardEntryAnimation(
                            overlap: overlap,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                              ),
                              child: Column(
                                spacing: 30,
                                children: [
                                  HomeCard(),
                                  SendHelpButton(),
                                  TimerLift(),
                                  PrayerTimesWidget(),
                                  QuickActions(),
                                  HajjAyah(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
