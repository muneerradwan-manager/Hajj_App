import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/directional_back_arrow.dart';

class ComplaintDetailsHeroSection extends StatelessWidget {
  const ComplaintDetailsHeroSection({
    super.key,
    required this.categoryKey,
    required this.createdAt,
    required this.updatedAt,
  });

  final String categoryKey;
  final String createdAt;
  final String updatedAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 20),
        Row(
          children: [
            DirectionalBackArrow(
              color: Colors.white,
              onPressed: () {
                context.pop();
              },
            ),
            const CustomText(
              'profile.back',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyLarge,
              color: CustomTextColor.white,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: .3),
            border: Border.all(color: Colors.white.withValues(alpha: .5)),
          ),
          child: IconButton(
            icon: const Icon(LucideIcons.hotel, color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 10),
        CustomText(
          categoryKey,
          color: CustomTextColor.white,
          type: CustomTextType.headlineSmall,
        ),
        const SizedBox(height: 10),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: _ComplaintMetaTile(
                labelKey: 'complaints.details.created_at',
                value: createdAt,
                dotColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: _ComplaintMetaTile(
                labelKey: 'complaints.details.updated_at',
                value: updatedAt,
                dotColor: Theme.of(context).colorScheme.brandGold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ComplaintMetaTile extends StatelessWidget {
  const _ComplaintMetaTile({
    required this.labelKey,
    required this.value,
    required this.dotColor,
  });

  final String labelKey;
  final String value;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderWidth: 1,
      borderSide: CustomBorderSide.allBorder,
      borderColor: CustomBorderColor.white,
      hasOpacity: 0.2,
      hasShadow: false,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      borderHasOpacity: 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 5,
        children: [
          Row(
            spacing: 10,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor,
                ),
              ),
              CustomText(
                labelKey,
                color: CustomTextColor.white,
                type: CustomTextType.labelMedium,
              ),
            ],
          ),
          CustomText(
            value,
            color: CustomTextColor.white,
            translate: false,
          ),
        ],
      ),
    );
  }
}
