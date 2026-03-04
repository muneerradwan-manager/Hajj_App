import 'package:flutter/material.dart';

import '../../../../shared/widgets/card_entry_animation.dart';
import '../../../../shared/widgets/hero_background.dart';
import '../widgets/complaints_card.dart';
import '../widgets/complaints_hero_section.dart';

class ComplaintsView extends StatefulWidget {
  const ComplaintsView({super.key});

  @override
  State<ComplaintsView> createState() => _ComplaintsViewState();
}

class _ComplaintsViewState extends State<ComplaintsView> {
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
            final topPadding = MediaQuery.of(context).padding.top;
            final isDesktopLayout = viewportWidth >= 1040;
            final heroHeight = isDesktopLayout
                ? (viewportHeight * 0.20).clamp(300.0, 420.0)
                : (viewportHeight * 0.30).clamp(260.0, 380.0) + topPadding;
            final overlap = (viewportHeight * 0.08).clamp(50.0, 80.0);
            const horizontalPadding = 20.0;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                        child: const ComplaintsHeroSection(),
                      ),
                      CardEntryAnimation(
                        overlap: overlap,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Column(
                            spacing: 30,
                            children: [ComplaintsCard()],
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
