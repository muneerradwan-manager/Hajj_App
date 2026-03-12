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
Future<bool?> showClosedActionDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => const _ClosedActionDialog(),
  );
}

class _ClosedActionDialog extends StatefulWidget {
  const _ClosedActionDialog();

  @override
  State<_ClosedActionDialog> createState() => _ClosedActionDialogState();
}

class _ClosedActionDialogState extends State<_ClosedActionDialog> {
  bool _isSending = false;

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
                  'للحصول على شهادة إكمال الحج، يجب عليك إكمال استبيان رضا الحاج أولاً',
                  textAlign: TextAlign.center,
                  type: CustomTextType.titleSmall,
                  color: CustomTextColor.hint,
                ),
                const SizedBox(height: 20),
                const CustomContainer(
                  containerColor: Color(0xffF9F8F6),
                  borderRadius: 16,
                  borderWidth: 0,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  hasShadow: false,
                  child: _InfoTile(
                    index: 1,
                    titleKey: 'أكمل استبيان رضا الحاج',
                    subtitleKey: 'قيّم تجربتك في رحلة الحج',
                  ),
                ),
                const SizedBox(height: 10),
                const CustomContainer(
                  containerColor: Color(0xffF9F8F6),
                  borderRadius: 16,
                  borderWidth: 0,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  hasShadow: false,
                  child: _InfoTile(
                    index: 2,
                    titleKey: 'احصل على شهادتك',
                    subtitleKey: 'شهادة رسمية من المديرية',
                    isOff: true,
                  ),
                ),
                const SizedBox(height: 20),
                // Send location button
                _buildSendButton(cs),
                const SizedBox(height: 10),
                // Cancel button
                GradientElevatedButton(
                  onPressed: _isSending
                      ? null
                      : () => Navigator.of(context).pop(),
                  gradientColor: GradientColors.outline,
                  child: const CustomText(
                    'home.help_dialog_cancel',
                    type: CustomTextType.bodyLarge,
                    color: CustomTextColor.green,
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
          gradientColors: [cs.surfaceDim, cs.brandGold],
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
                        LucideIcons.lock,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      'الشهادة مقفلة',
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
      onPressed: _isSending ? null : null,
      child: _isSending
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.white,
              ),
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(LucideIcons.arrowRight, color: AppColors.white, size: 18),
                CustomText(
                  'انتقل للاستبيان',
                  type: CustomTextType.titleSmall,
                  color: CustomTextColor.white,
                ),
              ],
            ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.titleKey,
    required this.subtitleKey,
    required this.index,
    this.isOff = false,
  });

  final String titleKey;
  final String subtitleKey;
  final int index;
  final bool isOff;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        spacing: 10,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isOff ? cs.outline : cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomText(
                index.toString(),
                textAlign: TextAlign.center,
                color: CustomTextColor.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  titleKey,
                  type: CustomTextType.titleSmall,
                  color: isOff ? CustomTextColor.hint : CustomTextColor.green,
                ),
                const SizedBox(height: 2),
                CustomText(
                  subtitleKey,
                  type: CustomTextType.labelSmall,
                  color: isOff ? CustomTextColor.hint : CustomTextColor.gold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
