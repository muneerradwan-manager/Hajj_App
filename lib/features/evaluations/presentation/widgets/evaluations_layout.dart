import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/custom_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../shared/widgets/hero_background.dart';
import '../../../../shared/widgets/card_entry_animation.dart';
import '../cubits/phases/phases_cubit.dart';
import '../cubits/phases/phases_state.dart';
import 'evaluations_hero_section.dart';

class EvaluationsLayout extends StatelessWidget {
  const EvaluationsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
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

          return SingleChildScrollView(
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
                        child: const EvaluationsHeroSection(),
                      ),

                      BlocBuilder<PhasesCubit, PhasesState>(
                        builder: (context, state) {
                          return CardEntryAnimation(
                            overlap: overlap,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  const CustomContainer(
                                    borderSide: CustomBorderSide.borderTop,
                                    borderColor: CustomBorderColor.gold,
                                    containerColor: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          spacing: 10,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                CustomText(
                                                  '0',
                                                  type: CustomTextType
                                                      .headlineMedium,
                                                  color: CustomTextColor.green,
                                                ),
                                                CustomText(
                                                  'evaluations.progress_of_total',
                                                  color: CustomTextColor.green,
                                                ),
                                              ],
                                            ),
                                            CustomText(
                                              'evaluations.completed_label',
                                              color: CustomTextColor.green,
                                            ),
                                          ],
                                        ),
                                        CustomContainer(
                                          borderRadius: 100,
                                          borderColor: CustomBorderColor.hint,
                                          borderWidth: 3,
                                          borderHasOpacity: .3,
                                          child: CustomText(
                                            '0%',
                                            type: CustomTextType.headlineSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomContainer(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 20,
                                      children: [
                                        Row(
                                          spacing: 5,
                                          children: [
                                            CustomContainer(
                                              borderRadius: 100,
                                              width: 20,
                                              height: 20,
                                              containerColor: cs.primary,
                                            ),
                                            const CustomText('evaluations.legend_completed'),
                                          ],
                                        ),
                                        Row(
                                          spacing: 5,
                                          children: [
                                            CustomContainer(
                                              borderRadius: 100,
                                              width: 20,
                                              height: 20,
                                              containerColor: cs.brandGold,
                                            ),
                                            const CustomText('evaluations.legend_available'),
                                          ],
                                        ),
                                        Row(
                                          spacing: 5,
                                          children: [
                                            CustomContainer(
                                              borderRadius: 100,
                                              width: 20,
                                              height: 20,
                                              containerColor: cs.outline,
                                            ),
                                            const CustomText('evaluations.legend_locked'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomContainer(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            spacing: 10,
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  CustomContainer(
                                                    gradientColors: [
                                                      cs.surfaceDim,
                                                      cs.brandGold,
                                                    ],
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: const Icon(
                                                      LucideIcons.plane,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const Positioned(
                                                    top: -10,
                                                    right: -10,
                                                    child: CustomContainer(
                                                      containerColor:
                                                          Colors.white,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10,
                                                          ),
                                                      borderRadius: 100,
                                                      borderWidth: 1,
                                                      borderSide:
                                                          CustomBorderSide
                                                              .allBorder,
                                                      borderColor:
                                                          CustomBorderColor
                                                              .hint,
                                                      borderHasOpacity: .3,
                                                      child: CustomText(
                                                        '1',
                                                        type: CustomTextType
                                                            .labelSmall,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Expanded(
                                                child: Column(
                                                  spacing: 5,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText('evaluations.phase_airport'),
                                                    CustomText(
                                                      'evaluations.phase_airport_desc',
                                                      color:
                                                          CustomTextColor.hint,
                                                      type: CustomTextType
                                                          .labelMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: GradientElevatedButton(
                                            gradientColor: GradientColors.gold,
                                            onPressed: () {},
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 5,
                                            ),
                                            borderRadius: 100,
                                            child: const CustomText(
                                              'evaluations.rate_now',
                                              color: CustomTextColor.white,
                                              type: CustomTextType.labelMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomContainer(
                                    containerColor: Colors.white,
                                    hasOpacity: .5,
                                    // hasShadow: false,
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            spacing: 10,
                                            children: [
                                              Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  CustomContainer(
                                                    containerColor: cs.outline
                                                        .withValues(alpha: .3),
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: const Icon(
                                                      LucideIcons.lock,
                                                      color: Color(0xff90A1B9),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: -10,
                                                    right: -10,
                                                    child: CustomContainer(
                                                      containerColor:
                                                          cs.outline,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10,
                                                          ),
                                                      borderRadius: 100,
                                                      borderWidth: 0,
                                                      child: const CustomText(
                                                        '2',
                                                        type: CustomTextType
                                                            .labelSmall,
                                                        color: CustomTextColor
                                                            .hint,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Expanded(
                                                child: Column(
                                                  spacing: 5,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      'evaluations.phase_hotel',
                                                      color:
                                                          CustomTextColor.hint,
                                                    ),
                                                    CustomText(
                                                      'evaluations.phase_hotel_desc',
                                                      color:
                                                          CustomTextColor.hint,
                                                      type: CustomTextType
                                                          .labelMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CustomContainer(
                                          containerColor: cs.outline.withValues(
                                            alpha: .3,
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: const CustomText(
                                            'evaluations.legend_view_only',
                                            color: CustomTextColor.hint,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomContainer(
                                    gradientColors: [
                                      cs.inversePrimary.withValues(alpha: .20),
                                      cs.primary.withValues(alpha: .20),
                                    ],
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 20,
                                          children: [
                                            CustomContainer(
                                              gradientColors: [
                                                cs.inversePrimary,
                                                cs.primary,
                                              ],
                                              padding: const EdgeInsets.all(5),
                                              child: const Icon(
                                                LucideIcons.lock,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText('evaluations.upcoming_title'),
                                                  SizedBox(height: 10),
                                                  CustomText(
                                                    'evaluations.upcoming_desc',
                                                    color: CustomTextColor.hint,
                                                    type: CustomTextType
                                                        .labelMedium,
                                                    height: 1.3,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        const Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          alignment: WrapAlignment.start,
                                          runAlignment: WrapAlignment.start,
                                          children: [
                                            CustomContainer(
                                              borderWidth: 0,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 20,
                                              ),
                                              borderRadius: 100,
                                              containerColor: Colors.white,
                                              hasOpacity: .7,
                                              hasShadow: false,
                                              child: CustomText(
                                                'evaluations.phase_hotel',
                                                type:
                                                    CustomTextType.labelMedium,
                                                color: CustomTextColor.hint,
                                              ),
                                            ),
                                            CustomContainer(
                                              borderWidth: 0,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 20,
                                              ),
                                              containerColor: Colors.white,
                                              hasOpacity: .7,
                                              hasShadow: false,
                                              borderRadius: 100,
                                              child: CustomText(
                                                'evaluations.phase_ihram',
                                                type:
                                                    CustomTextType.labelMedium,
                                                color: CustomTextColor.hint,
                                              ),
                                            ),
                                            CustomContainer(
                                              borderWidth: 0,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 20,
                                              ),
                                              containerColor: Colors.white,
                                              hasOpacity: .7,
                                              hasShadow: false,
                                              borderRadius: 100,
                                              child: CustomText(
                                                'evaluations.phase_saee',
                                                type:
                                                    CustomTextType.labelMedium,
                                                color: CustomTextColor.hint,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
