import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/constants/app_images.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/gradient_elevated_button.dart';

/// Shows the "Send Help" confirmation dialog.
///
/// Returns `true` if the location was sent successfully, `false` otherwise,
/// or `null` if the dialog was dismissed.
Future<bool?> showExitAppDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => const _ExitAppDialog(),
  );
}

class _ExitAppDialog extends StatefulWidget {
  const _ExitAppDialog();

  @override
  State<_ExitAppDialog> createState() => _ExitAppDialogState();
}

class _ExitAppDialogState extends State<_ExitAppDialog> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Hero header ──
          _buildHeader(cs),
          // ── Info items ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                const CustomText(
                  'هل تريد حقاً الخروج من التطبيق؟',
                  textAlign: TextAlign.center,
                  type: CustomTextType.titleMedium,
                ),
                const SizedBox(height: 10),
                const CustomText(
                  'ستفقد أي بيانات غير محفوظة',
                  textAlign: TextAlign.center,
                  type: CustomTextType.titleSmall,
                  color: CustomTextColor.hint,
                ),
                const SizedBox(height: 20),
                // Send location button
                _buildSendButton(cs),
                const SizedBox(height: 10),
                // Cancel button
                GradientElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  gradientColor: GradientColors.outline,
                  icon: Icon(LucideIcons.logOut, color: cs.brandRed),
                  borderColor: cs.brandRed,
                  child: const CustomText(
                    'تأكيد الخروج',
                    type: CustomTextType.bodyLarge,
                    color: CustomTextColor.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Gradient + pattern background
        CustomContainer(
          width: double.infinity,
          gradientColors: [cs.brandRedAlt, cs.brandRed],
          borderWidth: 0,
          padding: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background pattern
              Positioned.fill(
                child: Opacity(
                  opacity: 0.08,
                  child: Image.asset(AppImages.background, fit: BoxFit.cover),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 30),
                child: Column(
                  children: [
                    // Location icon badge
                    CustomContainer(
                      width: 60,
                      height: 60,
                      borderRadius: 100,
                      borderWidth: 2,
                      borderColor: CustomBorderColor.white,
                      borderHasOpacity: .3,
                      containerColor: Colors.white,
                      hasOpacity: 0.3,
                      padding: EdgeInsets.zero,
                      child: Icon(
                        LucideIcons.triangleAlert,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      'تأكيد الخروج',
                      type: CustomTextType.titleLarge,
                      color: CustomTextColor.white,
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(height: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Close button
        Positioned(
          top: 8,
          left: 8,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.white.withValues(alpha: 0.2),
            ),
            icon: const Icon(LucideIcons.x, color: AppColors.white, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton(ColorScheme cs) {
    return GradientElevatedButton(
      gradientColor: GradientColors.green,
      onPressed: () {
        Navigator.of(context).pop(true);
        exit(0);
      },
      child: const CustomText(
        'البقاء في التطبيق',
        type: CustomTextType.titleSmall,
        color: CustomTextColor.white,
      ),
    );
  }
}
