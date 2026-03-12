import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'custom_container.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.icon,
    required this.titleKey,
    required this.borderColor,
    this.onTap,
    this.isClosed = false,
  });

  final IconData icon;
  final String titleKey;
  final CustomBorderColor borderColor;
  final VoidCallback? onTap;
  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final card = CustomContainer(
      borderRadius: 10,
      padding: const EdgeInsets.all(15),
      borderSide: CustomBorderSide.borderTop,
      borderColor: borderColor,
      child: Column(
        spacing: 10,
        children: [
          CustomContainer(
            borderRadius: 10,
            gradientColors: borderColor == CustomBorderColor.green
                ? [cs.primaryContainer, cs.primary]
                : borderColor == CustomBorderColor.red
                ? [cs.brandRedAlt, cs.brandRed]
                : [cs.surfaceDim, cs.brandGold],
            padding: const EdgeInsets.all(10),
            borderWidth: 1,
            child: Icon(
              icon,
              size: 30,
              color: isClosed ? const Color(0xff62748E) : Colors.white,
            ),
          ),
          CustomText(
            titleKey,
            type: CustomTextType.bodyLarge,
            color: isClosed ? CustomTextColor.hint : CustomTextColor.green,
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          card,
          if (isClosed)
            const Positioned.fill(
              child: CustomContainer(
                borderRadius: 10,
                containerColor: Colors.white,
                borderWidth: 0,
                hasOpacity: .7,
                padding: EdgeInsets.zero,
                hasShadow: false,
                child: Center(
                  child: CustomContainer(
                    width: 50,
                    height: 50,
                    borderRadius: 100,
                    containerColor: Colors.white,
                    borderWidth: 0,
                    padding: EdgeInsets.zero,
                    hasShadow: false,
                    child: Icon(LucideIcons.lock, color: Color(0xff62748E)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
