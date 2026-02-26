import 'package:flutter/material.dart';
import 'package:hajj_app/core/constants/app_images.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

import '../../../../shared/widgets/custom_network_image.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final String _profileImage = '';
  final String _passportImage = '';

  final Map<String, bool> _expandedSections = {
    'basic': true,
    'rezident': false,
    'flight': false,
    'manasik': false,
    'lead': false,
    'passport': false,
  };

  void _toggleSection(String key) {
    setState(() {
      _expandedSections[key] = !(_expandedSections[key] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
          _buildHeader(cs),
          _buildDivider(cs),
          _buildBasicInfoSection(cs),
          _buildResidenceSection(cs),
          _buildFlightsSection(cs),
          _buildRitualsSection(cs),
          _buildLeadershipSection(cs),
          _buildPassportSection(cs),
          const SizedBox(height: 10),
          _GradientStripe(cs: cs),
        ],
      ),
    );
  }

  // ── Header ──

  Widget _buildHeader(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: cs.primary,
              border: Border.all(color: cs.brandGold, width: 3),
            ),
            child: _profileImage.isNotEmpty
                ? CustomCachedImage(
                    imageUrl: _profileImage,
                    borderRadius: 16,
                    enableFullScreen: true,
                  )
                : Icon(LucideIcons.user, size: 48, color: cs.onPrimary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'home.pilgrim_name',
                  type: CustomTextType.bodyLarge,
                  color: CustomTextColor.green,
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: cs.primary.withValues(alpha: .3),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: const CustomText(
                    'home.pilgrim_id',
                    type: CustomTextType.bodyMedium,
                    color: CustomTextColor.lightGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Divider(color: cs.outline, thickness: 1, height: 30),
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
    );
  }

  // ── Basic Info Section ──

  Widget _buildBasicInfoSection(ColorScheme cs) {
    return _ProfileInfoSection(
      titleKey: 'profile.section_basic_info',
      icon: LucideIcons.user,
      isExpanded: _expandedSections['basic'] ?? false,
      onToggle: () => _toggleSection('basic'),
      iconColor: cs.primary,
      children: [
        _InfoRow(labelKey: 'profile.full_name', value: 'محمد أحمد الشامي'),
        const SizedBox(height: 10),
        _InfoRow(labelKey: 'profile.group_name', value: 'التوفيق'),
        const SizedBox(height: 10),
        _InfoRow(labelKey: 'profile.cluster_name', value: 'ارتقاء'),
        const SizedBox(height: 10),
        _InfoRow(labelKey: 'profile.office_name', value: 'دمشق'),
        const SizedBox(height: 10),
        _InfoRow(labelKey: 'profile.office_phone', value: '+963 11 234 5678'),
        const SizedBox(height: 10),
        _InfoRow(
          labelKey: 'profile.mutawwif_name',
          value: 'عبدالرحمن بن خالد المطوف',
        ),
        const SizedBox(height: 10),
        _InfoRow(
          labelKey: 'profile.emergency_phone',
          value: '+963 944 123 456',
        ),
      ],
    );
  }

  // ── Residence Section ──

  Widget _buildResidenceSection(ColorScheme cs) {
    return _ProfileInfoSection(
      titleKey: 'profile.section_residence',
      icon: LucideIcons.hotel,
      isExpanded: _expandedSections['rezident'] ?? false,
      onToggle: () => _toggleSection('rezident'),
      iconColor: cs.brandRed,
      children: [
        _ColoredSection(
          borderColor: cs.brandRed,
          titleKey: 'profile.makkah',
          titleColor: CustomTextColor.red,
          children: [
            _InfoRow(
              labelKey: 'profile.hotel_name',
              value: 'فندق مكة هيلتون',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.location',
              value: 'شارع إبراهيم الخليل',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _MapButton(backgroundColor: cs.brandRed),
          ],
        ),
        const SizedBox(height: 20),
        _ColoredSection(
          borderColor: cs.primary,
          titleKey: 'profile.madinah',
          titleColor: CustomTextColor.red,
          children: [
            _InfoRow(
              labelKey: 'profile.hotel_name',
              value: 'فندق المدينة موفنبيك',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.location',
              value: 'طريق الملك فهد',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _MapButton(),
          ],
        ),
      ],
    );
  }

  // ── Flights Section ──

  Widget _buildFlightsSection(ColorScheme cs) {
    return _ProfileInfoSection(
      titleKey: 'profile.section_flights',
      icon: LucideIcons.plane,
      isExpanded: _expandedSections['flight'] ?? false,
      onToggle: () => _toggleSection('flight'),
      iconColor: cs.brandGold,
      children: [
        _ColoredSection(
          borderColor: cs.primary,
          titleKey: 'profile.departure_flight',
          titleColor: CustomTextColor.green,
          children: [
            _FlightNumberBadge(
              flightNumber: 'SYR-1234',
              backgroundColor: cs.primary,
            ),
            _InfoRow(
              labelKey: 'profile.airline',
              value: 'الخطوط الجوية السورية',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.departure_time',
              value: '10 يونيو 2026 - 14:30',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.arrival_time',
              value: '10 يونيو 2026 - 18:45',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.departure_airport',
              value: 'مطار دمشق الدولي',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.arrival_airport',
              value: 'مطار الملك عبدالعزيز - جدة',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ColoredSection(
          borderColor: cs.primary,
          titleKey: 'profile.return_flight',
          titleColor: CustomTextColor.gold,
          children: [
            _FlightNumberBadge(
              flightNumber: 'SYR-5678',
              backgroundColor: cs.brandGold,
            ),
            _InfoRow(
              labelKey: 'profile.airline',
              value: 'الخطوط الجوية السورية',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.departure_time',
              value: '10 يونيو 2026 - 14:30',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.arrival_time',
              value: '10 يونيو 2026 - 18:45',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.departure_airport',
              value: 'مطار الملك عبدالعزيز - جدة',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.arrival_airport',
              value: 'مطار دمشق الدولي',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
          ],
        ),
      ],
    );
  }

  // ── Rituals Section ──

  Widget _buildRitualsSection(ColorScheme cs) {
    return _ProfileInfoSection(
      titleKey: 'profile.section_rituals',
      icon: LucideIcons.tent,
      isExpanded: _expandedSections['manasik'] ?? false,
      onToggle: () => _toggleSection('manasik'),
      iconColor: cs.primary,
      children: [
        _ColoredSection(
          borderColor: cs.primary,
          titleKey: 'profile.arafat',
          titleColor: CustomTextColor.green,
          children: [
            _InfoRow(
              labelKey: 'profile.camp_number',
              value: 'A-245',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.camp_location',
              value: 'منطقة نمرة، عرفات',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _MapButton(),
          ],
        ),
        const SizedBox(height: 20),
        _ColoredSection(
          borderColor: cs.brandGold,
          titleKey: 'profile.madinah',
          titleColor: CustomTextColor.gold,
          children: [
            _InfoRow(
              labelKey: 'profile.camp_number',
              value: 'M-189',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.camp_location',
              value: 'الجمرات الوسطى، منى',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _MapButton(backgroundColor: cs.brandGold),
          ],
        ),
      ],
    );
  }

  // ── Leadership Section ──

  Widget _buildLeadershipSection(ColorScheme cs) {
    return _ProfileInfoSection(
      titleKey: 'profile.section_leadership',
      icon: LucideIcons.phone,
      isExpanded: _expandedSections['lead'] ?? false,
      onToggle: () => _toggleSection('lead'),
      iconColor: cs.brandRed,
      children: [
        _ColoredSection(
          borderColor: cs.primary,
          titleKey: 'profile.cluster_leader',
          titleColor: CustomTextColor.green,
          children: [
            _InfoRow(
              labelKey: 'profile.name',
              value: 'عامر عمر مصطفى',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.phone',
              value: '+20 1158032715',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ColoredSection(
          borderColor: cs.brandGold,
          titleKey: 'profile.group_leader',
          titleColor: CustomTextColor.gold,
          children: [
            _InfoRow(
              labelKey: 'profile.name',
              value: 'توفيق يوسف العبيد',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.phone',
              value: '+20 1158032715',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ColoredSection(
          borderColor: cs.brandRed,
          titleKey: 'profile.emergency_numbers',
          titleColor: CustomTextColor.gold,
          children: [
            _InfoRow(
              labelKey: 'profile.civil_defense',
              value: '998',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.hajj_office',
              value: '+963 958006040',
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
          ],
        ),
      ],
    );
  }

  // ── Passport Section ──

  Widget _buildPassportSection(ColorScheme cs) {
    return _ProfileInfoSection(
      titleKey: 'profile.section_passport',
      icon: LucideIcons.fileMinus,
      isExpanded: _expandedSections['passport'] ?? false,
      onToggle: () => _toggleSection('passport'),
      iconColor: cs.brandGold,
      children: [
        _ColoredSection(
          borderColor: cs.brandGold,
          titleKey: 'profile.passport_image',
          titleColor: CustomTextColor.gold,
          children: [
            CustomCachedImage(
              imageUrl: _passportImage,
              height: 184,
              borderRadius: 16,
              enableFullScreen: true,
              emptyWidget: (context) => Image.asset(
                fit: BoxFit.cover,
                AppImages.passportPlaceholder,
              ),
            ),
            CustomText(
              _passportImage.isNotEmpty
                  ? 'profile.tap_to_preview'
                  : 'profile.no_image',
              color: CustomTextColor.gold,
              type: CustomTextType.labelMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}

// ── Reusable Private Widgets ──

class _ColoredSection extends StatelessWidget {
  const _ColoredSection({
    required this.borderColor,
    required this.titleKey,
    required this.titleColor,
    required this.children,
  });

  final Color borderColor;
  final String titleKey;
  final CustomTextColor titleColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        color: borderColor.withValues(alpha: .1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          CustomText(
            titleKey,
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

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: backgroundColor != null
          ? ElevatedButton.styleFrom(backgroundColor: backgroundColor)
          : null,
      label: const CustomText(
        'profile.open_google_maps',
        color: CustomTextColor.white,
      ),
      icon: const Icon(LucideIcons.arrowUpRight),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.labelKey,
    required this.value,
    this.containerColor,
    this.borderColor,
  });

  final String labelKey;
  final String value;
  final Color? containerColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ?? cs.brandGold.withValues(alpha: 0.5),
        ),
        color: containerColor,
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(
            child: CustomText(labelKey, color: CustomTextColor.gold),
          ),
          Expanded(
            child: CustomText(
              value,
              color: CustomTextColor.green,
              translate: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoSection extends StatelessWidget {
  final String titleKey;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<Widget> children;
  final Color iconColor;

  const _ProfileInfoSection({
    required this.titleKey,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.children,
    required this.iconColor,
  });

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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: iconColor.withValues(alpha: 0.1),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomText(
                      titleKey,
                      color: CustomTextColor.green,
                    ),
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
  const _GradientStripe({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
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
