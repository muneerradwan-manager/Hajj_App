import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/card_entry_animation.dart';
import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/gradient_elevated_button.dart';
import '../../../../shared/widgets/hero_background.dart';
import '../widgets/complaints_card.dart';
import '../widgets/complaints_hero_section.dart';

class ComplaintsView extends StatefulWidget {
  const ComplaintsView({super.key});

  @override
  State<ComplaintsView> createState() => _ComplaintsViewState();
}

class _ComplaintsViewState extends State<ComplaintsView> {
  int complaintId = 1;
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
              child: ConstrainedBox(
                // This is the fix: It forces the Stack to be at least the screen height
                constraints: BoxConstraints(minHeight: viewportHeight),
                child: Stack(
                  children: [
                    // These layers now have a height to anchor to
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: Column(
                              // Using spacing instead of SizedBox for cleaner layout
                              spacing: 30,
                              children: [
                                const ComplaintsCard(),

                                // --- New Complaint Button ---
                                GradientElevatedButton(
                                  onPressed: () => context.push(
                                    AppRoutes.createComplaintPath,
                                  ),
                                  gradientColor: GradientColors.red,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 10,
                                    children: [
                                      Icon(LucideIcons.plus),
                                      CustomText(
                                        'complaints.new_complaint',
                                        color: CustomTextColor.white,
                                      ),
                                    ],
                                  ),
                                ),

                                // --- Sample Complaint Status Card 1 ---
                                CustomContainer(
                                  borderSide: CustomBorderSide.borderRight,
                                  borderColor: CustomBorderColor.lightRed,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    spacing: 15,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            spacing: 10,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: cs.brandRedAlt,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: const Icon(
                                                  LucideIcons.hotel,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                spacing: 5,
                                                children: [
                                                  CustomText(
                                                    'complaints.sample.ac_issue',
                                                  ),
                                                  CustomText(
                                                    'complaints.category.hotel',
                                                    type: CustomTextType
                                                        .labelMedium,
                                                    color: CustomTextColor.gold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: cs.brandRed,
                                              ),
                                              color: cs.brandRedAlt.withValues(
                                                alpha: .2,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: const CustomText(
                                              'complaints.status.in_review',
                                              color: CustomTextColor.lightRed,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        spacing: 20,
                                        children: [
                                          Expanded(
                                            child: GradientElevatedButton(
                                              onPressed: () => context.push(
                                                '${AppRoutes.complaintDetailsPath}?id=$complaintId',
                                              ),
                                              gradientColor:
                                                  GradientColors.green,
                                              child: const Row(
                                                spacing: 10,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    'complaints.action.view_details',
                                                    color:
                                                        CustomTextColor.white,
                                                  ),
                                                  Icon(LucideIcons.eye),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            spacing: 5,
                                            children: [
                                              Icon(LucideIcons.calendar),
                                              CustomText(
                                                '2026-03-01',
                                                translate: false,
                                                color: CustomTextColor.hint,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // --- Sample Complaint Status Card 2 ---
                                CustomContainer(
                                  borderSide: CustomBorderSide.borderRight,
                                  borderColor: CustomBorderColor.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    spacing: 15,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            spacing: 10,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: cs.brandGreen,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: const Icon(
                                                  LucideIcons.hotel,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                spacing: 5,
                                                children: [
                                                  CustomText(
                                                    'complaints.sample.jamarat_crowd',
                                                  ),
                                                  CustomText(
                                                    'complaints.category.rituals',
                                                    type: CustomTextType
                                                        .labelMedium,
                                                    color: CustomTextColor.gold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: cs.brandGreen,
                                              ),
                                              color: cs.brandGreen.withValues(
                                                alpha: .2,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: const CustomText(
                                              'complaints.status.resolved',
                                              color: CustomTextColor.lightGreen,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        spacing: 20,
                                        children: [
                                          Expanded(
                                            child: GradientElevatedButton(
                                              onPressed: () => context.push(
                                                '${AppRoutes.complaintDetailsPath}?id=$complaintId',
                                              ),
                                              gradientColor:
                                                  GradientColors.green,
                                              child: const Row(
                                                spacing: 10,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    'complaints.action.view_details',
                                                    color:
                                                        CustomTextColor.white,
                                                  ),
                                                  Icon(LucideIcons.eye),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            spacing: 5,
                                            children: [
                                              Icon(LucideIcons.calendar),
                                              CustomText(
                                                '2026-03-01',
                                                translate: false,
                                                color: CustomTextColor.hint,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // --- Sample Complaint Status Card 3 ---
                                CustomContainer(
                                  borderSide: CustomBorderSide.borderRight,
                                  borderColor: CustomBorderColor.gold,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    spacing: 15,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            spacing: 10,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: cs.brandGold,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: const Icon(
                                                  LucideIcons.hotel,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                spacing: 5,
                                                children: [
                                                  CustomText(
                                                    'complaints.sample.meal_quality',
                                                  ),
                                                  CustomText(
                                                    'complaints.category.rituals',
                                                    type: CustomTextType
                                                        .labelMedium,
                                                    color: CustomTextColor.gold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: cs.brandGold,
                                              ),
                                              color: cs.brandGold.withValues(
                                                alpha: .2,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: const CustomText(
                                              'complaints.status.pending',
                                              color: CustomTextColor.gold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        spacing: 20,
                                        children: [
                                          Expanded(
                                            child: GradientElevatedButton(
                                              onPressed: () => context.push(
                                                '${AppRoutes.complaintDetailsPath}?id=$complaintId',
                                              ),
                                              gradientColor:
                                                  GradientColors.green,
                                              child: const Row(
                                                spacing: 10,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    'complaints.action.view_details',
                                                    color:
                                                        CustomTextColor.white,
                                                  ),
                                                  Icon(LucideIcons.eye),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            spacing: 5,
                                            children: [
                                              Icon(LucideIcons.calendar),
                                              CustomText(
                                                '2026-03-01',
                                                translate: false,
                                                color: CustomTextColor.hint,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
