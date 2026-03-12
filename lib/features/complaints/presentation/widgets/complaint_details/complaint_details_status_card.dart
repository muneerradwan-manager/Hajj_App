import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../domain/entities/complaint.dart';

class ComplaintDetailsStatusCard extends StatelessWidget {
  final ComplaintStatusType status;
  final String sendDate;
  final String receiveDate;

  const ComplaintDetailsStatusCard({
    super.key,
    required this.status,
    required this.sendDate,
    required this.receiveDate,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final reviewStep = _reviewStepVisual(cs);
    final resultStep = _resultStepVisual(cs);
    final reviewValue = _reviewStageValue;
    final resultValue = _resultStageValue;

    return CustomContainer(
      borderSide: CustomBorderSide.borderTop,
      borderColor: _borderColor,
      child: Column(
        children: [
          Row(
            spacing: 10,
            children: [
              CustomContainer(
                borderColor: CustomBorderColor.gold,
                containerColor: cs.brandGold,
                borderWidth: 1,
                padding: const EdgeInsets.all(15),
                child: const Icon(LucideIcons.clock, color: Colors.white),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  const CustomText(
                    'complaints.details.status_label',
                    color: CustomTextColor.hint,
                    type: CustomTextType.labelMedium,
                  ),
                  CustomText(
                    _statusKey,
                    color: CustomTextColor.black,
                    type: CustomTextType.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Column(
            children: [
              Row(
                spacing: 10,
                children: [
                  CustomContainer(
                    containerColor: cs.primary,
                    borderRadius: 100,
                    borderWidth: 1,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      LucideIcons.circleCheck,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Divider(color: cs.outlineVariant, thickness: 5),
                  ),
                  _StatusStepIcon(
                    backgroundColor: reviewStep.backgroundColor,
                    icon: reviewStep.icon,
                    iconColor: reviewStep.iconColor,
                  ),
                  Expanded(
                    child: Divider(color: cs.outlineVariant, thickness: 5),
                  ),
                  _StatusStepIcon(
                    backgroundColor: resultStep.backgroundColor,
                    icon: resultStep.icon,
                    iconColor: resultStep.iconColor,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatusTimelineItem(
                    labelKey: 'complaints.details.submitted_label',
                    value: sendDate,
                    translateValue: false,
                    valueColor: CustomTextColor.hint,
                  ),
                  _StatusTimelineItem(
                    labelKey: 'complaints.status.in_review',
                    value: reviewValue.text,
                    translateValue: reviewValue.translate,
                    valueStyle: TextStyle(color: cs.outline),
                  ),
                  _StatusTimelineItem(
                    labelKey: 'complaints.details.result_label',
                    value: resultValue.text,
                    translateValue: resultValue.translate,
                    valueStyle: TextStyle(color: cs.outline),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  CustomBorderColor get _borderColor {
    switch (status) {
      case ComplaintStatusType.pending:
        return CustomBorderColor.gold;
      case ComplaintStatusType.inReview:
        return CustomBorderColor.red;
      case ComplaintStatusType.resolved:
        return CustomBorderColor.green;
    }
  }

  String get _statusKey {
    switch (status) {
      case ComplaintStatusType.pending:
        return 'complaints.status.pending';
      case ComplaintStatusType.inReview:
        return 'complaints.status.in_review';
      case ComplaintStatusType.resolved:
        return 'complaints.status.resolved';
    }
  }

  _TimelineValue get _reviewStageValue {
    switch (status) {
      case ComplaintStatusType.pending:
        return const _TimelineValue('complaints.details.review_value_pending');
      case ComplaintStatusType.inReview:
        return const _TimelineValue(
          'complaints.details.review_value_in_review',
        );
      case ComplaintStatusType.resolved:
        return const _TimelineValue(
          'complaints.details.review_value_completed',
        );
    }
  }

  _TimelineValue get _resultStageValue {
    final isEmpty = receiveDate.isEmpty;
    return _TimelineValue(
      isEmpty ? 'complaints.details.date_placeholder' : receiveDate,
      translate: isEmpty,
    );
  }

  _StatusStepVisual _reviewStepVisual(ColorScheme cs) {
    switch (status) {
      case ComplaintStatusType.pending:
        return _StatusStepVisual(
          backgroundColor: cs.outlineVariant,
          icon: LucideIcons.clock,
          iconColor: cs.outline,
        );
      case ComplaintStatusType.inReview:
      case ComplaintStatusType.resolved:
        return _StatusStepVisual(
          backgroundColor: cs.brandRed,
          icon: LucideIcons.info,
          iconColor: Colors.white,
        );
    }
  }

  _StatusStepVisual _resultStepVisual(ColorScheme cs) {
    switch (status) {
      case ComplaintStatusType.resolved:
        return _StatusStepVisual(
          backgroundColor: cs.primary,
          icon: LucideIcons.circleCheck,
          iconColor: Colors.white,
        );
      case ComplaintStatusType.pending:
      case ComplaintStatusType.inReview:
        return _StatusStepVisual(
          backgroundColor: cs.outlineVariant,
          icon: LucideIcons.circleSmall,
          iconColor: cs.outline,
        );
    }
  }
}

class _StatusStepIcon extends StatelessWidget {
  const _StatusStepIcon({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });

  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerColor: backgroundColor,
      borderRadius: 100,
      borderWidth: 1,
      padding: const EdgeInsets.all(10),
      child: Icon(icon, color: iconColor),
    );
  }
}

class _StatusTimelineItem extends StatelessWidget {
  const _StatusTimelineItem({
    required this.labelKey,
    required this.value,
    required this.translateValue,
    this.valueColor,
    this.valueStyle,
  });

  final String labelKey;
  final String value;
  final bool translateValue;
  final CustomTextColor? valueColor;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        CustomText(labelKey, color: CustomTextColor.hint),
        CustomText(
          value,
          translate: translateValue,
          type: CustomTextType.labelMedium,
          color: valueColor,
          style: valueStyle,
        ),
      ],
    );
  }
}

class _StatusStepVisual {
  const _StatusStepVisual({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });

  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
}

class _TimelineValue {
  const _TimelineValue(this.text, {this.translate = true});

  final String text;
  final bool translate;
}
