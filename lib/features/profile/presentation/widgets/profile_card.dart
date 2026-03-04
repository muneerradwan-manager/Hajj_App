import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/constants/app_images.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/user_profile.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_state.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/widgets/custom_network_image.dart';
import '../../../../shared/widgets/custom_snackbar.dart';

const UserProfile _emptyProfile = UserProfile(
  userId: '',
  email: '',
  phone: '',
  barcode: 0,
  pilgrimId: 0,
  fullName: '',
  nationalityNumber: '',
  isMale: true,
  imgPath: '',
  passPath: '',
  officeName: '',
  officePhone: '',
  group: UserGroup(
    groupName: '',
    maccaHotel: '',
    maccaHotelLocation: '',
    madinaHotel: '',
    madinaHotelLocation: '',
    mutawwef: '',
    arrafatCampNo: '',
    arrafatCompLocation: '',
    minaCampNo: '',
    minaCampLocation: '',
    applicants: [],
  ),
  masterGroup: UserMasterGroup(masterGroupName: '', applicants: []),
  departureFlight: null,
  returnFlight: null,
);

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String? _saudiNumber;
  bool _isSaudiNumberEditing = false;

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

  void _toggleSaudiNumberEditing() =>
      setState(() => _isSaudiNumberEditing = !_isSaudiNumberEditing);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final meState = context.watch<MeCubit>().state;
    final profile = meState.profile ?? _emptyProfile;
    final resolvedSaudiNumber =
        _saudiNumber ??
        _extractSaudiNumber(profile.group.applicants, profile.fullName);
    final isResidenceAvailable = _hasResidenceData(profile.group);
    final isFlightAvailable =
        profile.departureFlight != null || profile.returnFlight != null;
    final isRitualsAvailable = _hasRitualsData(profile.group);

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
          _ProfileHeader(
            profileImage: profile.imgPath,
            fullName: _fallback(profile.fullName),
            pilgrimId: _pilgrimId(profile),
          ),
          const _ProfileDivider(),
          if (meState.status == MeStatus.loading) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: LinearProgressIndicator(minHeight: 3),
            ),
          ],
          _BasicInfoSection(
            isExpanded: _expandedSections['basic'] ?? false,
            onToggle: () => _toggleSection('basic'),
            profile: profile,
            isSaudiNumberEditing: _isSaudiNumberEditing,
            saudiNumber: resolvedSaudiNumber.isEmpty
                ? null
                : resolvedSaudiNumber,
            onToggleSaudiNumberEditing: _toggleSaudiNumberEditing,
          ),
          _CampaignStaffSection(
            isExpanded: _expandedSections['team'] ?? false,
            onToggle: () => _toggleSection('team'),
            profile: profile,
          ),
          _ResidenceSection(
            isExpanded: _expandedSections['residence'] ?? false,
            onToggle: () => _toggleSection('residence'),
            profile: profile,
            isAvailable: isResidenceAvailable,
          ),
          _FlightsSection(
            isExpanded: _expandedSections['flights'] ?? false,
            onToggle: () => _toggleSection('flights'),
            profile: profile,
            isAvailable: isFlightAvailable,
          ),
          _RitualsSection(
            isExpanded: _expandedSections['rituals'] ?? false,
            onToggle: () => _toggleSection('rituals'),
            profile: profile,
            isAvailable: isRitualsAvailable,
          ),
          _LeadershipSection(
            isExpanded: _expandedSections['leadership'] ?? false,
            onToggle: () => _toggleSection('leadership'),
            profile: profile,
          ),
          _PassportSection(
            isExpanded: _expandedSections['passport'] ?? false,
            onToggle: () => _toggleSection('passport'),
            passportImage: profile.passPath,
          ),
          const SizedBox(height: 10),
          const _GradientStripe(),
        ],
      ),
    );
  }

  String _fallback(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? '-' : normalized;
  }

  String _pilgrimId(UserProfile profile) {
    if (profile.barcode > 0) return profile.barcode.toString();
    if (profile.pilgrimId > 0) return profile.pilgrimId.toString();
    return '-';
  }

  String _extractSaudiNumber(List<UserApplicant> applicants, String fullName) {
    final normalizedName = fullName.trim();
    for (final applicant in applicants) {
      final isCurrentUser = applicant.fullName.trim() == normalizedName;
      final saudiNumber = applicant.saudiNum.trim();
      if (isCurrentUser && saudiNumber.isNotEmpty) {
        return saudiNumber;
      }
    }
    for (final applicant in applicants) {
      final saudiNumber = applicant.saudiNum.trim();
      if (saudiNumber.isNotEmpty) return saudiNumber;
    }
    return '';
  }

  bool _hasResidenceData(UserGroup group) {
    return group.maccaHotel.trim().isNotEmpty ||
        group.maccaHotelLocation.trim().isNotEmpty ||
        group.madinaHotel.trim().isNotEmpty ||
        group.madinaHotelLocation.trim().isNotEmpty;
  }

  bool _hasRitualsData(UserGroup group) {
    return group.arrafatCampNo.trim().isNotEmpty ||
        group.arrafatCompLocation.trim().isNotEmpty ||
        group.minaCampNo.trim().isNotEmpty ||
        group.minaCampLocation.trim().isNotEmpty;
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.profileImage,
    required this.fullName,
    required this.pilgrimId,
  });

  final String profileImage;
  final String fullName;
  final String pilgrimId;

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
                CustomText(
                  fullName,
                  translate: false,
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
    required this.profile,
    required this.isSaudiNumberEditing,
    required this.saudiNumber,
    required this.onToggleSaudiNumberEditing,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final UserProfile profile;
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
        _InfoRow(
          labelKey: 'profile.full_name',
          value: _fallback(profile.fullName),
        ),
        const SizedBox(height: 10),
        _InfoRow(
          labelKey: 'profile.group_name',
          value: _fallback(profile.group.groupName),
        ),
        const SizedBox(height: 10),
        _InfoRow(
          labelKey: 'profile.cluster_name',
          value: _fallback(profile.masterGroup.masterGroupName),
        ),
        const SizedBox(height: 10),
        _InfoRow(
          labelKey: 'profile.office_name',
          value: _fallback(profile.officeName),
        ),
        const SizedBox(height: 10),
        _InfoRow(
          labelKey: 'profile.mutawwif_name',
          value: _fallback(profile.group.mutawwef),
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

  String _fallback(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? '-' : normalized;
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
    required this.profile,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _ProfileInfoSection(
      titleKey: 'profile.section_campaign_staff',
      icon: LucideIcons.user,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: cs.brandGold,
      children: _buildStaffRows(),
    );
  }

  List<Widget> _buildStaffRows() {
    final rows = <Widget>[];
    final applicants = profile.group.applicants;

    if (applicants.isEmpty) {
      rows.add(const _InfoRow(labelKey: 'profile.name', value: '-'));
      return rows;
    }

    for (var index = 0; index < applicants.length; index++) {
      final applicant = applicants[index];
      rows.add(
        _InfoRow(
          labelKey: applicant.applicantType.trim().isEmpty
              ? 'profile.name'
              : applicant.applicantType,
          value: _fallback(applicant.fullName),
          translateLabel: applicant.applicantType.trim().isEmpty,
        ),
      );
      if (index < applicants.length - 1) {
        rows.add(const SizedBox(height: 10));
      }
    }

    return rows;
  }

  String _fallback(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? '-' : normalized;
  }
}

class _ResidenceSection extends StatelessWidget {
  const _ResidenceSection({
    required this.isExpanded,
    required this.onToggle,
    required this.profile,
    required this.isAvailable,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final UserProfile profile;
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
                value: _fallback(profile.group.maccaHotel),
                containerColor: Colors.white,
                borderColor: cs.outline,
              ),
              _InfoRow(
                labelKey: 'profile.location',
                value: _fallback(profile.group.maccaHotelLocation),
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
                value: _fallback(profile.group.madinaHotel),
                containerColor: Colors.white,
                borderColor: cs.outline,
              ),
              _InfoRow(
                labelKey: 'profile.location',
                value: _fallback(profile.group.madinaHotelLocation),
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

  String _fallback(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? '-' : normalized;
  }
}

class _FlightsSection extends StatelessWidget {
  const _FlightsSection({
    required this.isExpanded,
    required this.onToggle,
    required this.profile,
    required this.isAvailable,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final UserProfile profile;
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
          if (profile.departureFlight != null)
            _ColoredSection(
              borderColor: cs.primary,
              titleKey: 'profile.departure_flight',
              titleColor: CustomTextColor.green,
              children: [
                _FlightNumberBadge(
                  flightNumber: _fallback(profile.departureFlight!.flightName),
                  backgroundColor: cs.primary,
                ),
                _InfoRow(
                  labelKey: 'profile.airline',
                  value: _fallback(profile.departureFlight!.airlineCompany),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
                _InfoRow(
                  labelKey: 'profile.departure_time',
                  value: _dateTimeText(
                    profile.departureFlight!.departureDate,
                    profile.departureFlight!.departureTime,
                  ),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
                _InfoRow(
                  labelKey: 'profile.arrival_time',
                  value: _dateTimeText(
                    profile.departureFlight!.arrivalDate,
                    profile.departureFlight!.arrivalTime,
                  ),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
                _InfoRow(
                  labelKey: 'profile.departure_airport',
                  value: _fallback(profile.departureFlight!.departureAirport),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
                _InfoRow(
                  labelKey: 'profile.arrival_airport',
                  value: _fallback(profile.departureFlight!.arrivalAirport),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
              ],
            ),
          if (profile.departureFlight != null && profile.returnFlight != null)
            const SizedBox(height: 20),
          if (profile.returnFlight != null)
            _ColoredSection(
              borderColor: cs.primary,
              titleKey: 'profile.return_flight',
              titleColor: CustomTextColor.gold,
              children: [
                _FlightNumberBadge(
                  flightNumber: _fallback(profile.returnFlight!.flightName),
                  backgroundColor: cs.brandGold,
                ),
                _InfoRow(
                  labelKey: 'profile.airline',
                  value: _fallback(profile.returnFlight!.airlineCompany),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
                _InfoRow(
                  labelKey: 'profile.departure_time',
                  value: _dateTimeText(
                    profile.returnFlight!.departureDate,
                    profile.returnFlight!.departureTime,
                  ),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
                _InfoRow(
                  labelKey: 'profile.arrival_time',
                  value: _dateTimeText(
                    profile.returnFlight!.arrivalDate,
                    profile.returnFlight!.arrivalTime,
                  ),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
                _InfoRow(
                  labelKey: 'profile.departure_airport',
                  value: _fallback(profile.returnFlight!.departureAirport),
                  containerColor: Colors.white,
                  borderColor: cs.outline,
                ),
                _InfoRow(
                  labelKey: 'profile.arrival_airport',
                  value: _fallback(profile.returnFlight!.arrivalAirport),
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

  String _dateTimeText(DateTime? date, String time) {
    final datePart = date != null ? _formatDate(date) : '';
    final timePart = time.trim();
    if (datePart.isEmpty && timePart.isEmpty) return '-';
    if (datePart.isEmpty) return timePart;
    if (timePart.isEmpty) return datePart;
    return '$datePart - $timePart';
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  String _fallback(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? '-' : normalized;
  }
}

class _RitualsSection extends StatelessWidget {
  const _RitualsSection({
    required this.isExpanded,
    required this.onToggle,
    required this.profile,
    required this.isAvailable,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final UserProfile profile;
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
                value: _fallback(profile.group.arrafatCampNo),
                containerColor: Colors.white,
                borderColor: cs.outline,
              ),
              _InfoRow(
                labelKey: 'profile.camp_location',
                value: _fallback(profile.group.arrafatCompLocation),
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
                value: _fallback(profile.group.minaCampNo),
                containerColor: Colors.white,
                borderColor: cs.outline,
              ),
              _InfoRow(
                labelKey: 'profile.camp_location',
                value: _fallback(profile.group.minaCampLocation),
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

  String _fallback(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? '-' : normalized;
  }
}

class _LeadershipSection extends StatelessWidget {
  const _LeadershipSection({
    required this.isExpanded,
    required this.onToggle,
    required this.profile,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final clusterLeader = _pickLeader(profile.masterGroup.applicants);
    final groupLeader = _pickLeader(profile.group.applicants);

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
              value: _fallback(clusterLeader?.fullName ?? ''),
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.phone',
              value: _fallback(clusterLeader?.telNum ?? ''),
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
              value: _fallback(groupLeader?.fullName ?? ''),
              containerColor: Colors.white,
              borderColor: cs.outline,
            ),
            _InfoRow(
              labelKey: 'profile.phone',
              value: _fallback(groupLeader?.telNum ?? ''),
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
              value: _fallback(profile.officePhone),
              containerColor: Colors.white,
              borderColor: cs.outline,
              isPhoneNumber: true,
            ),
            _InfoRow(
              labelKey: 'profile.mutawwif_phone',
              value: _fallback(_pickMutawwefPhone(profile.group.applicants)),
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
              value: _fallback(profile.officePhone),
              containerColor: Colors.white,
              borderColor: cs.outline,
              isPhoneNumber: true,
            ),
          ],
        ),
      ],
    );
  }

  UserApplicant? _pickLeader(List<UserApplicant> applicants) {
    for (final applicant in applicants) {
      final type = applicant.applicantType.toLowerCase();
      if (type.contains('رئيس') || type.contains('leader')) return applicant;
    }
    if (applicants.isEmpty) return null;
    return applicants.first;
  }

  String _pickMutawwefPhone(List<UserApplicant> applicants) {
    for (final applicant in applicants) {
      final type = applicant.applicantType.toLowerCase();
      if (type.contains('مطوف') ||
          type.contains('mutaw') ||
          type.contains('guide')) {
        return applicant.telNum;
      }
    }
    return '';
  }

  String _fallback(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? '-' : normalized;
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

  bool get _hasPassportImage => passportImage.trim().isNotEmpty;

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
                onPressed: _hasPassportImage
                    ? () => _downloadPassportImage(context)
                    : null,
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
                onPressed: _hasPassportImage
                    ? () => _sharePassportImage(context)
                    : null,
                label: const CustomText(
                  'profile.share_pdf',
                  color: CustomTextColor.white,
                  type: CustomTextType.bodySmall,
                ),
                icon: const Icon(LucideIcons.share2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _downloadPassportImage(BuildContext context) async {
    final imageUrl = passportImage.trim();
    if (imageUrl.isEmpty) {
      showMessage(
        context,
        'profile.no_image',
        SnackBarType.failuer,
        translate: true,
      );
      return;
    }

    try {
      final response = await Dio().get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final fileName = _resolveFileNameFromUrl(imageUrl);
      final result = await SaverGallery.saveImage(
        Uint8List.fromList(response.data!),
        fileName: fileName,
        androidRelativePath: 'Pictures/Hajj App',
        skipIfExists: false,
      );

      if (!context.mounted) return;
      if (result.isSuccess) {
        showMessage(
          context,
          'profile.passport_download_success',
          SnackBarType.success,
          translate: true,
        );
      } else {
        showMessage(
          context,
          'profile.passport_download_failed',
          SnackBarType.failuer,
          translate: true,
        );
      }
    } catch (_) {
      if (!context.mounted) return;
      showMessage(
        context,
        'profile.passport_download_failed',
        SnackBarType.failuer,
        translate: true,
      );
    }
  }

  Future<void> _sharePassportImage(BuildContext context) async {
    final imageUrl = passportImage.trim();
    if (imageUrl.isEmpty) {
      showMessage(
        context,
        'profile.no_image',
        SnackBarType.failuer,
        translate: true,
      );
      return;
    }

    try {
      final tempDirectory = await _resolveShareCacheDirectory();
      final file = await _downloadImageToDirectory(
        imageUrl: imageUrl,
        directory: tempDirectory,
      );

      if (!context.mounted) return;
      final lang = Localizations.localeOf(context).languageCode;
      final title = (lang == 'ar') ? 'صورة جواز السفر' : 'Passport Image';
      final resolvedName = _resolveShareNameFromFile(file.path);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: '$resolvedName - $title');
    } catch (_) {
      if (!context.mounted) return;
      showMessage(
        context,
        'profile.passport_share_failed',
        SnackBarType.failuer,
        translate: true,
      );
    }
  }

  Future<Directory> _resolveShareCacheDirectory() async {
    final tempDir = await getTemporaryDirectory();
    return Directory('${tempDir.path}${Platform.pathSeparator}passport_share');
  }

  Future<File> _downloadImageToDirectory({
    required String imageUrl,
    required Directory directory,
  }) async {
    await directory.create(recursive: true);

    final fileName = _resolveFileNameFromUrl(imageUrl);
    final file = File('${directory.path}${Platform.pathSeparator}$fileName');

    await Dio().download(
      imageUrl,
      file.path,
      options: Options(responseType: ResponseType.bytes),
      deleteOnError: true,
    );

    return file;
  }

  String _resolveFileNameFromUrl(String imageUrl) {
    try {
      final uri = Uri.parse(imageUrl);
      if (uri.pathSegments.isNotEmpty) {
        final lastSegment = uri.pathSegments.last.trim();
        if (lastSegment.isNotEmpty) {
          return lastSegment;
        }
      }
    } catch (_) {}

    return 'passport_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  String _resolveShareNameFromFile(String filePath) {
    final fileName = filePath.split(Platform.pathSeparator).last.trim();
    if (fileName.isEmpty) return 'Passport';

    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex <= 0) return fileName;

    final withoutExtension = fileName.substring(0, dotIndex).trim();
    return withoutExtension.isEmpty ? 'Passport' : withoutExtension;
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
