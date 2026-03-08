import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/hero_background.dart';
import '../widgets/complaint_details/complaint_details_hero_section.dart';
import '../widgets/complaint_details/complaint_details_status_card.dart';

class ComplaintDetails extends StatefulWidget {
  final int id;
  const ComplaintDetails({super.key, required this.id});

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final viewportHeight = constraints.maxHeight;
          final viewportWidth = constraints.maxWidth;
          final viewport = MediaQuery.sizeOf(context);
          final topPadding = MediaQuery.of(context).padding.top;

          final isDesktopLayout = viewportWidth >= 1040;

          final heroHeight = isDesktopLayout
              ? (viewport.height * 0.20).clamp(300.0, 420.0)
              : (viewport.height * 0.30).clamp(260.0, 380.0) + topPadding;

          final overlap = (heroHeight * 0.22).clamp(40.0, 70.0);

          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewportHeight),
              child: Stack(
                children: [
                  ...HeroBackground.layers(context, heroHeight),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // HERO
                      Container(
                        height: heroHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: const ComplaintDetailsHeroSection(),
                      ),
                      // CONTENT
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          overlap + 20,
                          20,
                          MediaQuery.of(context).padding.bottom + 20,
                        ),
                        child: Transform.translate(
                          offset: Offset(0, -overlap),
                          child: Column(
                            spacing: 20,
                            children: [
                              const ComplaintDetailsStatusCard(
                                status: ComplaintStatus.pending,
                                sendDate: '2026-03-03',
                                receiveDate: '2026-03-08',
                              ),
                              CustomContainer(
                                borderSide: CustomBorderSide.borderTop,
                                borderColor: CustomBorderColor.gold,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                          borderRadius: 15,
                                          containerColor: cs.brandGold,
                                          padding: const EdgeInsets.all(10),
                                          borderWidth: 1,
                                          child: const Icon(
                                            LucideIcons.fileText,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Column(
                                          spacing: 5,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              'complaints.details.subject_label',
                                              type: CustomTextType.labelLarge,
                                              color: CustomTextColor.hint,
                                            ),
                                            CustomText(
                                              'complaints.details.subject_value_jamarat_crowd',
                                              type: CustomTextType.bodyLarge,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              CustomContainer(
                                borderSide: CustomBorderSide.borderTop,
                                borderColor: CustomBorderColor.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                          borderRadius: 15,
                                          containerColor: cs.brandRed,
                                          padding: const EdgeInsets.all(10),
                                          borderWidth: 1,
                                          child: const Icon(
                                            LucideIcons.messageSquare,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const CustomText(
                                          'complaints.details.full_details_title',
                                          type: CustomTextType.labelLarge,
                                          color: CustomTextColor.hint,
                                        ),
                                      ],
                                    ),
                                    const CustomContainer(
                                      borderSide: CustomBorderSide.allBorder,
                                      borderWidth: 1,
                                      borderColor: CustomBorderColor.hint,
                                      borderHasOpacity: .2,
                                      padding: EdgeInsets.all(15),
                                      gradientColors: [
                                        Color(0xffF9F8F6),
                                        Colors.white,
                                      ],
                                      child: CustomText(
                                        'complaints.details.full_details_body',
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              CustomContainer(
                                borderSide: CustomBorderSide.borderTop,
                                borderColor: CustomBorderColor.green,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                          borderRadius: 15,
                                          containerColor: cs.primary,
                                          padding: const EdgeInsets.all(10),
                                          borderWidth: 1,
                                          child: const Icon(
                                            LucideIcons.messageSquare,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Column(
                                          spacing: 5,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              'complaints.details.management_reply_title',
                                              type: CustomTextType.labelLarge,
                                              color: CustomTextColor.green,
                                            ),
                                            CustomText(
                                              'complaints.details.management_reply_subtitle',
                                              type: CustomTextType.labelSmall,
                                              color: CustomTextColor.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const CustomContainer(
                                      borderSide: CustomBorderSide.allBorder,
                                      borderWidth: 1,
                                      borderColor: CustomBorderColor.green,
                                      borderHasOpacity: .2,
                                      padding: EdgeInsets.all(15),
                                      gradientColors: [
                                        Color(0xffF9F8F6),
                                        Colors.white,
                                      ],
                                      child: CustomText(
                                        'complaints.details.management_reply_body',
                                      ),
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
    );
  }
}
