import 'package:flutter/material.dart';
import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/constants/app_images.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/widgets/custom_network_image.dart';
import '../../../../shared/widgets/custom_snackbar.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final String _profileImage = '';
  final String _passportImage = '';
  String? _saudiNumber;
  bool _isSaudiNumberEditing = false;
  final bool _isResidenceAvailable = false;
  final bool _isFlightAvailable = false;
  final bool _isRitualsAvailable = false;

  final Map<String, bool> _expandedSections = {
    'basic': true,
    'team': false,
    'residence': false,
    'flights': false,
    'rituals': false,
    'leadership': false,
    'passport': false,
  };

  void _toggleSection(String key) {
    setState(() {
      _expandedSections[key] = !(_expandedSections[key] ?? false);
    });
  }

  void _initializeSaudiNumber() {
    _saudiNumber = '0954565464';
  }

  void _toggleSaudiNumberEditing() =>
      setState(() => _isSaudiNumberEditing = !_isSaudiNumberEditing);

  @override
  void initState() {
    super.initState();
    _initializeSaudiNumber();
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
          const _GradientStripe(),
          _ProfileHeader(profileImage: _profileImage),
          const _ProfileDivider(),
          _BasicInfoSection(
            isExpanded: _expandedSections['basic'] ?? false,
            onToggle: () => _toggleSection('basic'),
            isSaudiNumberEditing: _isSaudiNumberEditing,
            saudiNumber: _saudiNumber,
            onToggleSaudiNumberEditing: _toggleSaudiNumberEditing,
          ),
          _CampaignStaffSection(
            isExpanded: _expandedSections['team'] ?? false,
            onToggle: () => _toggleSection('team'),
          ),
          _ResidenceSection(
            isExpanded: _expandedSections['residence'] ?? false,
            onToggle: () => _toggleSection('residence'),
            isAvailable: _isResidenceAvailable,
          ),
          _FlightsSection(
            isExpanded: _expandedSections['flights'] ?? false,
            onToggle: () => _toggleSection('flights'),
            isAvailable: _isFlightAvailable,
          ),
          _RitualsSection(
            isExpanded: _expandedSections['rituals'] ?? false,
            onToggle: () => _toggleSection('rituals'),
            isAvailable: _isRitualsAvailable,
          ),
          _LeadershipSection(
            isExpanded: _expandedSections['leadership'] ?? false,
            onToggle: () => _toggleSection('leadership'),
          ),
          _PassportSection(
            isExpanded: _expandedSections['passport'] ?? false,
            onToggle: () => _toggleSection('passport'),
            passportImage: _passportImage,
          ),
          const SizedBox(height: 10),
          const _GradientStripe(),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profileImage});

  final String profileImage;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20),
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
            child: profileImage.isNotEmpty
                ? CustomCachedImage(
                    imageUrl: profileImage,
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
                    border: Border.all(color: cs.primary.withValues(alpha: .3)),
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
}

class _ProfileDivider extends StatelessWidget {
  const _ProfileDivider();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
}

class _BasicInfoSection extends StatelessWidget {
  const _BasicInfoSection({
    required this.isExpanded,
    required this.onToggle,
    required this.isSaudiNumberEditing,
    required this.saudiNumber,
    required this.onToggleSaudiNumberEditing,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isSaudiNumberEditing;
  final String? saudiNumber;
  final VoidCallback onToggleSaudiNumberEditing;

  @override
  Widget build(BuildContext context) {
    return _ProfileInfoSection(
      titleKey: 'profile.section_basic_info',
      icon: LucideIcons.user,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: Theme.of(context).colorScheme.primary,
      children: [
        const _InfoRow(
          labelKey: 'profile.full_name',
          value: 'محمد أحمد الشامي',
        ),
        const SizedBox(height: 10),
        const _InfoRow(labelKey: 'profile.group_name', value: 'التوفيق'),
        const SizedBox(height: 10),
        const _InfoRow(labelKey: 'profile.cluster_name', value: 'ارتقاء'),
        const SizedBox(height: 10),
        const _InfoRow(labelKey: 'profile.office_name', value: 'دمشق'),
        const SizedBox(height: 10),
        const _InfoRow(
          labelKey: 'profile.mutawwif_name',
          value: 'عبدالرحمن بن خالد المطوف',
        ),
        const SizedBox(height: 10),
        _SaudiNumberCard(
          isEditing: isSaudiNumberEditing,
          saudiNumber: saudiNumber,
          onToggleEditing: onToggleSaudiNumberEditing,
        ),
      ],
    );
  }
}

class _SaudiNumberCard extends StatelessWidget {
  const _SaudiNumberCard({
    required this.isEditing,
    required this.saudiNumber,
    required this.onToggleEditing,
  });

  final bool isEditing;
  final String? saudiNumber;
  final VoidCallback onToggleEditing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasSaudiNumber = (saudiNumber ?? '').isNotEmpty;

    if (isEditing) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.primary.withValues(alpha: 0.5)),
          color: cs.primary.withValues(alpha: 0.05),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            const CustomText(
              'profile.saudi_number_edit_label',
              color: CustomTextColor.green,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hint: CustomText(
                  'profile.saudi_number_hint',
                  color: CustomTextColor.hint,
                ),
              ),
            ),
            const CustomText(
              'profile.saudi_number_example',
              color: CustomTextColor.gold,
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.outline.withValues(alpha: .7),
                    ),
                    onPressed: onToggleEditing,
                    label: const CustomText(
                      'app.cancel',
                      color: CustomTextColor.green,
                    ),
                    icon: Icon(LucideIcons.x, color: cs.primary),
                  ),
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Save edited saudi number when API is ready.
                    },
                    label: const CustomText(
                      'profile.save',
                      color: CustomTextColor.white,
                    ),
                    icon: const Icon(LucideIcons.check),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.brandGold.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Expanded(
            child: CustomText(
              'profile.saudi_number',
              color: CustomTextColor.gold,
            ),
          ),
          hasSaudiNumber
              ? Expanded(
                  child: Row(
                    spacing: 10,
                    children: [
                      CustomText(
                        saudiNumber ?? '',
                        color: CustomTextColor.green,
                        translate: false,
                      ),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: cs.brandGold,
                        ),
                        onPressed: onToggleEditing,
                        icon: const Icon(LucideIcons.pen, color: Colors.white),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.brandRed,
                    ),
                    onPressed: onToggleEditing,
                    label: const CustomText(
                      'profile.add_saudi_number',
                      color: CustomTextColor.white,
                      type: CustomTextType.labelSmall,
                    ),
                    icon: const Icon(LucideIcons.pen),
                  ),
                ),
        ],
      ),
    );
  }
}

class _CampaignStaffSection extends StatelessWidget {
  const _CampaignStaffSection({
    required this.isExpanded,
    required this.onToggle,
  });

  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _ProfileInfoSection(
      titleKey: 'profile.section_campaign_staff',
      icon: LucideIcons.user,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: cs.brandGold,
      children: const [
        _InfoRow(
          labelKey: 'profile.campaign_leader',
          value: 'د. أحمد محمود الحلبي',
        ),
        SizedBox(height: 10),
        _InfoRow(
          labelKey: 'profile.campaign_assistant_leader',
          value: 'محمد خالد الشامي',
        ),
        SizedBox(height: 10),
        _InfoRow(labelKey: 'profile.religious_guide', value: 'عمر يوسف الحموي'),
        SizedBox(height: 10),
        _InfoRow(
          labelKey: 'profile.religious_guide_female',
          value: 'فاطمة علي الدمشقية',
        ),
      ],
    );
  }
}

class _ResidenceSection extends StatelessWidget {
  const _ResidenceSection({
    required this.isExpanded,
    required this.onToggle,
    required this.isAvailable,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _ProfileInfoSection(
      titleKey: 'profile.section_residence',
      icon: LucideIcons.hotel,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: cs.brandRed,
      children: [
        if (isAvailable) ...[
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
              const _MapButton(),
            ],
          ),
        ] else ...[
          const _UnavailableInfoCard(
            titleKey: 'profile.residence_unavailable_title',
            subtitleKey: 'profile.residence_unavailable_subtitle',
          ),
        ],
      ],
    );
  }
}

class _FlightsSection extends StatelessWidget {
  const _FlightsSection({
    required this.isExpanded,
    required this.onToggle,
    required this.isAvailable,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _ProfileInfoSection(
      titleKey: 'profile.section_flights',
      icon: LucideIcons.plane,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: cs.brandGold,
      children: [
        if (isAvailable) ...[
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
        ] else ...[
          const _UnavailableInfoCard(
            titleKey: 'profile.flights_unavailable_title',
            subtitleKey: 'profile.flights_unavailable_subtitle',
          ),
        ],
      ],
    );
  }
}

class _RitualsSection extends StatelessWidget {
  const _RitualsSection({
    required this.isExpanded,
    required this.onToggle,
    required this.isAvailable,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _ProfileInfoSection(
      titleKey: 'profile.section_rituals',
      icon: LucideIcons.tent,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: cs.primary,
      children: [
        if (isAvailable) ...[
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
              const _MapButton(),
            ],
          ),
          const SizedBox(height: 20),
          _ColoredSection(
            borderColor: cs.brandGold,
            titleKey: 'profile.mina',
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
        ] else ...[
          const _UnavailableInfoCard(
            titleKey: 'profile.rituals_unavailable_title',
            subtitleKey: 'profile.rituals_unavailable_subtitle',
          ),
        ],
      ],
    );
  }
}

class _LeadershipSection extends StatelessWidget {
  const _LeadershipSection({required this.isExpanded, required this.onToggle});

  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _ProfileInfoSection(
      titleKey: 'profile.section_leadership',
      icon: LucideIcons.phone,
      isExpanded: isExpanded,
      onToggle: onToggle,
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
              isPhoneNumber: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ColoredSection(
          borderColor: cs.brandRed,
          titleKey: 'profile.group_leader',
          titleColor: CustomTextColor.red,
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
              isPhoneNumber: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ColoredSection(
          borderColor: cs.brandGold,
          titleKey: null,
          titleColor: CustomTextColor.gold,
          children: [
            _InfoRow(
              labelKey: 'profile.makkah_office_phone',
              value: '+966 12 556 7890',
              containerColor: Colors.white,
              borderColor: cs.outline,
              isPhoneNumber: true,
            ),
            _InfoRow(
              labelKey: 'profile.mutawwif_phone',
              value: '+963 958006040',
              containerColor: Colors.white,
              borderColor: cs.outline,
              isPhoneNumber: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ColoredSection(
          borderColor: cs.brandRed,
          titleKey: 'profile.emergency_numbers',
          titleColor: CustomTextColor.red,
          children: [
            _InfoRow(
              labelKey: 'profile.civil_defense',
              value: '998',
              containerColor: Colors.white,
              borderColor: cs.outline,
              isPhoneNumber: true,
            ),
            _InfoRow(
              labelKey: 'profile.hajj_office',
              value: '+963 958006040',
              containerColor: Colors.white,
              borderColor: cs.outline,
              isPhoneNumber: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _PassportSection extends StatelessWidget {
  const _PassportSection({
    required this.isExpanded,
    required this.onToggle,
    required this.passportImage,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final String passportImage;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _ProfileInfoSection(
      titleKey: 'profile.section_passport',
      icon: LucideIcons.fileMinus,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: cs.brandGold,
      children: [
        _ColoredSection(
          borderColor: cs.brandGold,
          titleKey: 'profile.passport_image',
          titleColor: CustomTextColor.gold,
          children: [
            CustomCachedImage(
              imageUrl: passportImage,
              height: 184,
              borderRadius: 16,
              enableFullScreen: true,
              emptyWidget: (context) =>
                  Image.asset(fit: BoxFit.cover, AppImages.passportPlaceholder),
            ),
            CustomText(
              passportImage.isNotEmpty
                  ? 'profile.tap_to_preview'
                  : 'profile.no_image',
              color: CustomTextColor.gold,
              type: CustomTextType.labelMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: cs.brandRed),
                onPressed: () {},
                label: const CustomText(
                  'profile.download_pdf',
                  color: CustomTextColor.white,
                  type: CustomTextType.bodySmall,
                ),
                icon: const Icon(LucideIcons.download),
              ),
            ),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                label: const CustomText(
                  'profile.share_pdf',
                  color: CustomTextColor.white,
                  type: CustomTextType.bodySmall,
                ),
                icon: const Icon(LucideIcons.download),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.brandGold),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xffF9F8F6), Color(0xffE3DDD2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
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
    this.titleKey,
    required this.titleColor,
    required this.children,
  });

  final Color borderColor;
  final String? titleKey;
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
    this.isPhoneNumber = false,
  });

  final String labelKey;
  final String value;
  final Color? containerColor;
  final Color? borderColor;
  final bool isPhoneNumber;

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
        spacing: 10,
        children: [
          Expanded(
            flex: 1,
            child: CustomText(
              labelKey,
              color: CustomTextColor.gold,
              type: CustomTextType.labelMedium,
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
                        onPressed: () => _launchPhoneCall(context),
                        icon: const Icon(
                          LucideIcons.phone,
                          color: Colors.white,
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: iconColor,
                    ),
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
