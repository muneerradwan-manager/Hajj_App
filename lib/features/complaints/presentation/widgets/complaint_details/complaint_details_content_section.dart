import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import 'complaint_details_status_card.dart';

class ComplaintDetailsContentSection extends StatelessWidget {
  const ComplaintDetailsContentSection({
    super.key,
    required this.status,
    required this.sendDate,
    required this.receiveDate,
    required this.subjectValueKey,
    required this.fullDetailsBodyKey,
    required this.managementReplyBodyKey,
    required this.overlap,
  });

  final ComplaintStatus status;
  final String sendDate;
  final String receiveDate;
  final String subjectValueKey;
  final String fullDetailsBodyKey;
  final String managementReplyBodyKey;
  final double overlap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        overlap + 20,
        20,
        MediaQuery.paddingOf(context).bottom + 20,
      ),
      child: Transform.translate(
        offset: Offset(0, -overlap),
        child: Column(
          spacing: 20,
          children: [
            ComplaintDetailsStatusCard(
              status: status,
              sendDate: sendDate,
              receiveDate: receiveDate,
            ),
            _ComplaintSubjectCard(subjectValueKey: subjectValueKey),
            _ComplaintMessageCard(
              borderColor: CustomBorderColor.red,
              iconBackgroundColor: cs.brandRed,
              titleKey: 'complaints.details.full_details_title',
              titleColor: CustomTextColor.hint,
              bodyKey: fullDetailsBodyKey,
              bodyBorderColor: CustomBorderColor.hint,
              bodyBorderOpacity: .2,
            ),
            _ComplaintMessageCard(
              borderColor: CustomBorderColor.green,
              iconBackgroundColor: cs.primary,
              titleKey: 'complaints.details.management_reply_title',
              titleColor: CustomTextColor.green,
              subtitleKey: 'complaints.details.management_reply_subtitle',
              bodyKey: managementReplyBodyKey,
              bodyBorderColor: CustomBorderColor.green,
              bodyBorderOpacity: .2,
            ),
          ],
        ),
      ),
    );
  }
}

class _ComplaintSubjectCard extends StatelessWidget {
  const _ComplaintSubjectCard({required this.subjectValueKey});

  final String subjectValueKey;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      borderSide: CustomBorderSide.borderTop,
      borderColor: CustomBorderColor.gold,
      child: Row(
        children: [
          CustomContainer(
            borderRadius: 15,
            containerColor: cs.brandGold,
            padding: const EdgeInsets.all(10),
            borderWidth: 1,
            child: const Icon(LucideIcons.fileText, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'complaints.details.subject_label',
                  type: CustomTextType.labelLarge,
                  color: CustomTextColor.hint,
                ),
                CustomText(subjectValueKey, type: CustomTextType.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComplaintMessageCard extends StatelessWidget {
  const _ComplaintMessageCard({
    required this.borderColor,
    required this.iconBackgroundColor,
    required this.titleKey,
    required this.titleColor,
    required this.bodyKey,
    required this.bodyBorderColor,
    required this.bodyBorderOpacity,
    this.subtitleKey,
  });

  final CustomBorderColor borderColor;
  final Color iconBackgroundColor;
  final String titleKey;
  final CustomTextColor titleColor;
  final String bodyKey;
  final CustomBorderColor bodyBorderColor;
  final double bodyBorderOpacity;
  final String? subtitleKey;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderSide: CustomBorderSide.borderTop,
      borderColor: borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            children: [
              CustomContainer(
                borderRadius: 15,
                containerColor: iconBackgroundColor,
                padding: const EdgeInsets.all(10),
                borderWidth: 1,
                child: const Icon(
                  LucideIcons.messageSquare,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      titleKey,
                      type: CustomTextType.labelLarge,
                      color: titleColor,
                    ),
                    if (subtitleKey != null)
                      CustomText(
                        subtitleKey!,
                        type: CustomTextType.labelSmall,
                        color: CustomTextColor.green,
                      ),
                  ],
                ),
              ),
            ],
          ),
          CustomContainer(
            borderSide: CustomBorderSide.allBorder,
            borderWidth: 1,
            borderColor: bodyBorderColor,
            borderHasOpacity: bodyBorderOpacity,
            padding: const EdgeInsets.all(15),
            gradientColors: const [Color(0xffF9F8F6), Colors.white],
            child: CustomText(bodyKey),
          ),
        ],
      ),
    );
  }
}
