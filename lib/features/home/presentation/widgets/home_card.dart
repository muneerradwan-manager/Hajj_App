import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_network_image.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final String profileImage = '';
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: cs.primaryContainer),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GradientStripe(cs: cs),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              spacing: 10,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cs.primary,
                    border: Border.all(color: cs.brandGold, width: 3),
                  ),
                  child: profileImage.isNotEmpty
                      ? CustomCachedImage(
                          imageUrl: profileImage,
                          borderRadius: 16,
                          enableFullScreen: true,
                        )
                      : Icon(LucideIcons.user, size: 48, color: cs.onPrimary),
                ),
                Expanded(
                  child: Column(
                    spacing: 12,
                    children: [
                      const CustomText(
                        'home.pilgrim_name',
                        textAlign: TextAlign.center,
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: cs.primary.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: cs.primary.withValues(alpha: .3),
                          ),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: const CustomText(
                          'home.pilgrim_id',
                          textAlign: TextAlign.center,
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Divider(color: cs.outline, thickness: 1, height: 0),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: _InfoChip(
                    icon: LucideIcons.layers,
                    iconBgColor: cs.brandRed,
                    labelKey: 'home.cluster_label',
                    valueKey: 'home.cluster_value',
                    bgColor: cs.brandGold.withValues(alpha: .1),
                  ),
                ),
                Expanded(
                  child: _InfoChip(
                    icon: LucideIcons.grid3x3,
                    iconBgColor: cs.primary,
                    labelKey: 'home.group_label',
                    valueKey: 'home.group_value',
                    bgColor: cs.brandGold.withValues(alpha: .1),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
            child: ElevatedButton.icon(
              onPressed: () {
                context.push(AppRoutes.profilePath);
              },
              icon: const Icon(LucideIcons.squareArrowRight, size: 18),
              label: const CustomText(
                'home.view_full_card',
                color: CustomTextColor.white,
              ),
            ),
          ),
          _GradientStripe(cs: cs),
        ],
      ),
    );
  }
}

class _GradientStripe extends StatelessWidget {
  const _GradientStripe({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [cs.brandRed, cs.primary, cs.brandGold],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.iconBgColor,
    required this.labelKey,
    required this.valueKey,
    required this.bgColor,
  });

  final IconData icon;
  final Color iconBgColor;
  final String labelKey;
  final String valueKey;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child: Icon(icon, size: 18, color: Colors.white),
              ),
              CustomText(
                labelKey,
                type: CustomTextType.bodyMedium,
                color: CustomTextColor.gold,
              ),
            ],
          ),
          CustomText(
            valueKey,
            type: CustomTextType.bodyMedium,
            color: CustomTextColor.lightGreen,
          ),
        ],
      ),
    );
  }
}
