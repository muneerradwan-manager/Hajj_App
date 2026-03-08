import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/card_entry_animation.dart';
import '../../../../shared/widgets/hero_background.dart';
import 'profile_hero_section.dart';
import 'profile_content_section.dart';

class ProfileLayout extends StatelessWidget {
  const ProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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

          return RefreshIndicator(
            onRefresh: () => context.read<MeCubit>().loadMe(forceRefresh: true),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: viewportHeight),
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
                          child: const ProfileContentSection(),
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
    );
  }
}
