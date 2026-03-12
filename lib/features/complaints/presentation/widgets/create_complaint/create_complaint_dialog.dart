import 'package:bawabatelhajj/shared/widgets/custom_container.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/constants/app_images.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

Future<bool?> showCreateComplaintDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => const _CreateComplaintDialog(),
  );
}

class _CreateComplaintDialog extends StatelessWidget {
  const _CreateComplaintDialog();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(cs, context),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: GradientElevatedButton(
                    gradientColor: GradientColors.outline,
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const CustomText(
                      'app.cancel',
                      color: CustomTextColor.green,
                    ),
                  ),
                ),
                Expanded(
                  child: GradientElevatedButton(
                    gradientColor: GradientColors.green,
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const CustomText(
                      'complaints.create.confirm_dialog_confirm',
                      type: CustomTextType.titleSmall,
                      color: CustomTextColor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomContainer(
          gradientColors: [cs.primaryContainer, cs.primary],
          borderWidth: 0,
          width: double.infinity,
          padding: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.08,
                  child: Image.asset(AppImages.background, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 30),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: cs.shadow.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        LucideIcons.send,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const CustomText(
                      'complaints.create.confirm_dialog_title',
                      type: CustomTextType.titleLarge,
                      color: CustomTextColor.white,
                    ),
                    const SizedBox(height: 6),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(
                        'complaints.create.confirm_dialog_message',
                        type: CustomTextType.bodyMedium,
                        color: CustomTextColor.lightGold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.white.withValues(alpha: 0.2),
            ),
            icon: const Icon(LucideIcons.x, color: AppColors.white, size: 18),
          ),
        ),
      ],
    );
  }
}
