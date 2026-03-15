part of 'profile_card.dart';

class _UnavailableInfoCard extends StatelessWidget {
  const _UnavailableInfoCard({
    required this.titleKey,
    required this.subtitleKey,
  });

  final String titleKey;
  final String subtitleKey;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CustomContainer(
      borderSide: CustomBorderSide.allBorder,
      borderColor: CustomBorderColor.gold,
      gradientColors: [cs.surfaceDim, cs.brandGold],
      borderWidth: 1,
      hasOpacity: .3,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primary,
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(LucideIcons.info, color: Colors.white),
              ),
              Expanded(
                child: CustomText(titleKey, color: CustomTextColor.gold),
              ),
            ],
          ),
          CustomText(
            subtitleKey,
            color: CustomTextColor.green,
            type: CustomTextType.bodySmall,
          ),
        ],
      ),
    );
  }
}

// ── Reusable Private Widgets ──

class _ColoredSection extends StatelessWidget {
  const _ColoredSection({
    required this.borderColor,
    required this.containerColor,
    this.titleKey,
    required this.titleColor,
    required this.children,
  });

  final CustomBorderColor borderColor;
  final Color containerColor;
  final String? titleKey;
  final CustomTextColor titleColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerColor: containerColor,
      hasOpacity: .1,
      borderSide: CustomBorderSide.allBorder,
      borderWidth: 1,
      borderColor: borderColor,
      hasShadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          if (titleKey != null)
            CustomText(
              titleKey!,
              color: titleColor,
              type: CustomTextType.bodyLarge,
            ),
          ...children,
        ],
      ),
    );
  }
}

class _FlightNumberBadge extends StatelessWidget {
  const _FlightNumberBadge({
    required this.flightNumber,
    required this.backgroundColor,
  });

  final String flightNumber;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          const CustomText(
            'profile.flight_number',
            color: CustomTextColor.white,
            type: CustomTextType.labelMedium,
          ),
          CustomText(
            flightNumber,
            color: CustomTextColor.white,
            type: CustomTextType.headlineSmall,
            translate: false,
          ),
        ],
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton({this.backgroundColor});

  final GradientColors? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GradientElevatedButton(
      onPressed: null,
      gradientColor: backgroundColor ?? GradientColors.outline,
      icon: const Icon(LucideIcons.arrowUpRight),
      child: const CustomText(
        'profile.open_google_maps',
        color: CustomTextColor.white,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.labelKey,
    required this.value,
    this.containerColor,
    this.borderColor,
    this.isPhoneNumber = false,
    this.translateLabel = true,
  });

  final String labelKey;
  final String value;
  final Color? containerColor;
  final Color? borderColor;
  final bool isPhoneNumber;
  final bool translateLabel;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: 15,
      borderSide: CustomBorderSide.allBorder,
      borderColor: CustomBorderColor.lightGold,
      borderWidth: 1,
      containerColor: containerColor,
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: isPhoneNumber ? 5 : 14,
      ),
      hasShadow: false,
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            flex: 1,
            child: CustomText(
              labelKey,
              color: CustomTextColor.gold,
              type: CustomTextType.labelMedium,
              translate: translateLabel,
            ),
          ),
          Expanded(
            flex: 2,
            child: isPhoneNumber
                ? Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          value,
                          color: CustomTextColor.green,
                          translate: false,
                          type: CustomTextType.labelMedium,
                        ),
                      ),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: _normalizePhoneNumber(value).isEmpty
                            ? null
                            : () => _launchPhoneCall(context),
                        icon: const Icon(
                          LucideIcons.phone,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                : CustomText(
                    value,
                    color: CustomTextColor.green,
                    translate: false,
                    type: CustomTextType.labelMedium,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchPhoneCall(BuildContext context) async {
    final phoneNumber = _normalizePhoneNumber(value);
    if (phoneNumber.isEmpty) {
      showMessage(
        context,
        'profile.call_invalid_number',
        SnackBarType.failuer,
        translate: true,
      );

      return;
    }

    final uri = Uri.parse('tel:$phoneNumber');
    final isSupported = await canLaunchUrl(uri);
    if (!isSupported) {
      if (context.mounted) {
        showMessage(
          context,
          'profile.call_unavailable',
          SnackBarType.failuer,
          translate: true,
        );
      }
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      showMessage(
        context,
        'profile.call_unavailable',
        SnackBarType.failuer,
        translate: true,
      );
    }
  }

  String _normalizePhoneNumber(String input) {
    final trimmed = input.trim();
    final hasLeadingPlus = trimmed.startsWith('+');
    final digitsOnly = trimmed.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return '';
    }

    return hasLeadingPlus ? '+$digitsOnly' : digitsOnly;
  }
}

class _ProfileInfoSection extends StatelessWidget {
  const _ProfileInfoSection({
    required this.titleKey,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.children,
    required this.iconColor,
  });

  final String titleKey;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<Widget> children;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  CustomContainer(
                    width: 40,
                    height: 40,
                    borderRadius: 12,
                    gradientColors: iconColor == cs.primary
                        ? [cs.primaryContainer, cs.primary]
                        : iconColor == cs.brandRed
                        ? [cs.brandRedAlt, cs.brandRed]
                        : [cs.surfaceDim, cs.brandGold],
                    padding: EdgeInsets.zero,
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomText(titleKey, color: CustomTextColor.green),
                  ),
                  Icon(
                    isExpanded
                        ? LucideIcons.chevronUp
                        : LucideIcons.chevronDown,
                    color: cs.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(children: children),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          Divider(color: cs.outline.withValues(alpha: 0.5)),
        ],
      ),
    );
  }
}

class _GradientStripe extends StatelessWidget {
  const _GradientStripe();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.brandRed, cs.primary, cs.brandGold],
        ),
      ),
    );
  }
}
