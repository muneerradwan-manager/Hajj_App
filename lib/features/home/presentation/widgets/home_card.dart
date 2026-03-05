import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/custom_network_image.dart';
import '../../../../shared/widgets/gradient_elevated_button.dart';
import '../../../auth/presentation/cubits/me/me_state.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final profile = context.select((MeCubit cubit) => cubit.state.profile);
    final profileImage = profile?.imgPath ?? '';
    final fullName = _fallback(profile?.fullName);
    final pilgrimId = _formatPilgrimId(
      pilgrimId: profile?.pilgrimId,
      barcode: profile?.barcode,
    );
    final masterGroupName = _fallback(profile?.masterGroup.masterGroupName);
    final groupName = _fallback(profile?.group.groupName);
    final meState = context.watch<MeCubit>().state;

    return CustomContainer(
      padding: EdgeInsets.zero,
      borderWidth: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GradientStripe(cs: cs),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              spacing: 10,
              children: [
                CustomContainer(
                  width: 100,
                  height: 100,
                  borderWidth: 3.0,
                  borderSide: CustomBorderSide.allBorder,
                  borderColor: CustomBorderColor.gold,
                  padding: EdgeInsets.zero,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      CustomText(
                        fullName,
                        translate: false,
                        textAlign: TextAlign.center,
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                      ),
                      CustomContainer(
                        containerColor: cs.primary,
                        hasOpacity: .1,
                        borderRadius: 12,
                        borderColor: CustomBorderColor.lightGreen,
                        borderWidth: 1,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: CustomText(
                          pilgrimId,
                          translate: false,
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
          if (meState.status == MeStatus.loading) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: LinearProgressIndicator(minHeight: 3),
            ),
          ],
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
                    value: masterGroupName,
                  ),
                ),
                Expanded(
                  child: _InfoChip(
                    icon: LucideIcons.grid3x3,
                    iconBgColor: cs.primary,
                    labelKey: 'home.group_label',
                    value: groupName,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
            child: GradientElevatedButton(
              onPressed: () => context.push(AppRoutes.profilePath),
              gradientColor: GradientColors.green,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Icon(LucideIcons.chevronLeft, size: 18),
                  CustomText(
                    'home.view_full_card',
                    color: CustomTextColor.white,
                  ),
                  Icon(LucideIcons.eye, size: 18),
                ],
              ),
            ),
          ),
          _GradientStripe(cs: cs),
        ],
      ),
    );
  }

  String _fallback(String? value) {
    final normalized = value?.trim() ?? '';
    return normalized.isEmpty ? '-' : normalized;
  }

  String _formatPilgrimId({int? pilgrimId, int? barcode}) {
    final code = barcode ?? 0;
    if (code > 0) return code.toString();
    final id = pilgrimId ?? 0;
    if (id > 0) return id.toString();
    return '-';
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
    required this.value,
  });

  final IconData icon;
  final Color iconBgColor;
  final String labelKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CustomContainer(
      borderRadius: 12,
      hasOpacity: 0.1,
      hasShadow: false,
      containerColor: cs.brandGold,
      padding: const EdgeInsets.all(10),
      borderSide: CustomBorderSide.allBorder,
      borderWidth: 1,
      borderColor: CustomBorderColor.lightGold,
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
            value,
            type: CustomTextType.bodyMedium,
            color: CustomTextColor.lightGreen,
            translate: false,
          ),
        ],
      ),
    );
  }
}
