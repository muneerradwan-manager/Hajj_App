part of 'profile_card.dart';

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
          CustomContainer(
            width: 100,
            height: 100,
            containerColor: cs.primary,
            borderSide: CustomBorderSide.allBorder,
            borderColor: CustomBorderColor.gold,
            borderWidth: 3,
            padding: EdgeInsets.zero,
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
                CustomContainer(
                  containerColor: cs.primary,
                  hasOpacity: 0.1,
                  borderRadius: 12,
                  borderSide: CustomBorderSide.allBorder,
                  borderColor: CustomBorderColor.green,
                  borderWidth: 1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  hasShadow: false,
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
    required this.saudiNumberController,
    required this.onSaveSaudiNumber,
    required this.isSaudiNumberSaving,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final UserProfile profile;
  final bool isSaudiNumberEditing;
  final String? saudiNumber;
  final VoidCallback onToggleSaudiNumberEditing;
  final TextEditingController saudiNumberController;
  final VoidCallback onSaveSaudiNumber;
  final bool isSaudiNumberSaving;

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
          controller: saudiNumberController,
          onSave: onSaveSaudiNumber,
          isSaving: isSaudiNumberSaving,
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
    required this.controller,
    required this.onSave,
    required this.isSaving,
  });

  final bool isEditing;
  final String? saudiNumber;
  final VoidCallback onToggleEditing;
  final TextEditingController controller;
  final VoidCallback onSave;
  final bool isSaving;

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
              controller: controller,
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
                    onPressed: isSaving ? null : onSave,
                    label: const CustomText(
                      'profile.save',
                      color: CustomTextColor.white,
                    ),
                    icon: isSaving
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(LucideIcons.check),
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
                      Expanded(
                        child: CustomText(
                          saudiNumber ?? '',
                          color: CustomTextColor.green,
                          translate: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
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

class _CampaignGroupSection extends StatelessWidget {
  const _CampaignGroupSection({
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
      icon: LucideIcons.usersRound,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: cs.brandGold,
      children: [_StaffList(applicants: profile.group.applicants)],
    );
  }
}

class _CampaignMasterGroupSection extends StatelessWidget {
  const _CampaignMasterGroupSection({
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
      titleKey: 'profile.cluster_staff',
      icon: LucideIcons.usersRound,
      isExpanded: isExpanded,
      onToggle: onToggle,
      iconColor: cs.brandRed,
      children: [_StaffList(applicants: profile.masterGroup.applicants)],
    );
  }
}

class _StaffList extends StatelessWidget {
  const _StaffList({required this.applicants});

  final List<UserApplicant> applicants;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    if (applicants.isEmpty) {
      rows.add(const _InfoRow(labelKey: 'profile.name', value: '-'));
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rows,
      );
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
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
      iconColor: cs.primary,
      children: [
        if (isAvailable) ...[
          _ColoredSection(
            borderColor: CustomBorderColor.red,
            titleKey: 'profile.makkah',
            titleColor: CustomTextColor.red,
            containerColor: cs.brandRed,
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
            borderColor: CustomBorderColor.green,
            containerColor: cs.primary,
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
              borderColor: CustomBorderColor.green,
              containerColor: cs.primary,
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
              borderColor: CustomBorderColor.green,
              containerColor: cs.primary,
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
      iconColor: cs.brandRed,
      children: [
        if (isAvailable) ...[
          _ColoredSection(
            borderColor: CustomBorderColor.green,
            containerColor: cs.primary,
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
            borderColor: CustomBorderColor.gold,
            containerColor: cs.brandGold,
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
      iconColor: cs.primary,
      children: [
        _ColoredSection(
          borderColor: CustomBorderColor.green,
          containerColor: cs.primary,
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
          borderColor: CustomBorderColor.red,
          containerColor: cs.brandRed,
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
          borderColor: CustomBorderColor.gold,
          containerColor: cs.brandGold,
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
          borderColor: CustomBorderColor.red,
          containerColor: cs.brandRed,
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

class _PassportSection extends StatefulWidget {
  const _PassportSection({
    required this.isExpanded,
    required this.onToggle,
    required this.passportImage,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final String passportImage;

  @override
  State<_PassportSection> createState() => _PassportSectionState();
}

class _PassportSectionState extends State<_PassportSection> {
  bool _isDownloading = false;
  bool _isSharing = false;

  bool get _hasPassportImage => widget.passportImage.trim().isNotEmpty;
  bool get _isBusy => _isDownloading || _isSharing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _ProfileInfoSection(
      titleKey: 'profile.section_passport',
      icon: LucideIcons.fileMinus,
      isExpanded: widget.isExpanded,
      onToggle: widget.onToggle,
      iconColor: cs.brandGold,
      children: [
        _ColoredSection(
          borderColor: CustomBorderColor.gold,
          containerColor: cs.brandGold,
          titleKey: 'profile.passport_image',
          titleColor: CustomTextColor.gold,
          children: [
            CustomCachedImage(
              imageUrl: widget.passportImage,
              height: 184,
              borderRadius: 16,
              enableFullScreen: true,
              emptyWidget: (context) =>
                  Image.asset(fit: BoxFit.cover, AppImages.passportPlaceholder),
            ),
            CustomText(
              widget.passportImage.isNotEmpty
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
                onPressed: _hasPassportImage && !_isBusy
                    ? _downloadPassportImage
                    : null,
                label: const CustomText(
                  'profile.download_image',
                  color: CustomTextColor.white,
                  type: CustomTextType.bodySmall,
                ),
                icon: _isDownloading
                    ? SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.onPrimary,
                        ),
                      )
                    : const Icon(LucideIcons.download),
              ),
            ),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _hasPassportImage && !_isBusy
                    ? _sharePassportImage
                    : null,
                label: const CustomText(
                  'profile.share_image',
                  color: CustomTextColor.white,
                  type: CustomTextType.bodySmall,
                ),
                icon: _isSharing
                    ? SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.onPrimary,
                        ),
                      )
                    : const Icon(LucideIcons.share2),
              ),
            ),
          ],
        ),
        if (_isBusy) ...[
          const SizedBox(height: 10),
          const LinearProgressIndicator(minHeight: 3),
        ],
      ],
    );
  }

  Future<void> _downloadPassportImage() async {
    final imageUrl = widget.passportImage.trim();
    if (imageUrl.isEmpty) {
      showMessage(
        context,
        'profile.no_image',
        SnackBarType.failuer,
        translate: true,
      );
      return;
    }

    final hasPermission = await _ensureMediaPermission();
    if (!hasPermission || !mounted) return;

    setState(() => _isDownloading = true);

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

      if (!mounted) return;
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
      if (!mounted) return;
      showMessage(
        context,
        'profile.passport_download_failed',
        SnackBarType.failuer,
        translate: true,
      );
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  Future<void> _sharePassportImage() async {
    final imageUrl = widget.passportImage.trim();
    if (imageUrl.isEmpty) {
      showMessage(
        context,
        'profile.no_image',
        SnackBarType.failuer,
        translate: true,
      );
      return;
    }

    final hasPermission = await _ensureMediaPermission();
    if (!hasPermission || !mounted) return;

    setState(() => _isSharing = true);

    try {
      final tempDirectory = await _resolveShareCacheDirectory();
      final file = await _downloadImageToDirectory(
        imageUrl: imageUrl,
        directory: tempDirectory,
      );

      if (!mounted) return;
      final title = 'profile.passport_image'.tr(context);
      final resolvedName = _resolveShareNameFromFile(file.path);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: '$resolvedName - $title');
    } catch (_) {
      if (!mounted) return;
      showMessage(
        context,
        'profile.passport_share_failed',
        SnackBarType.failuer,
        translate: true,
      );
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  Future<bool> _ensureMediaPermission() async {
    final status = await _requestMediaPermission();

    if (_isPermissionGranted(status)) {
      return true;
    }

    if (!mounted) return false;

    if (status.isPermanentlyDenied || status.isRestricted) {
      await _showSettingsDialog();
      return false;
    }

    showMessage(
      context,
      'profile.storage_permission_denied',
      SnackBarType.failuer,
      translate: true,
    );
    return false;
  }

  Future<PermissionStatus> _requestMediaPermission() async {
    if (Platform.isIOS) {
      return Permission.photos.request();
    }

    if (Platform.isAndroid) {
      final photosStatus = await Permission.photos.request();
      if (_isPermissionGranted(photosStatus)) return photosStatus;

      final storageStatus = await Permission.storage.request();
      if (_isPermissionGranted(storageStatus)) return storageStatus;

      if (photosStatus.isPermanentlyDenied || photosStatus.isRestricted) {
        return photosStatus;
      }
      return storageStatus;
    }

    return PermissionStatus.granted;
  }

  bool _isPermissionGranted(PermissionStatus status) {
    return status.isGranted || status.isLimited;
  }

  Future<void> _showSettingsDialog() async {
    final shouldOpenSettings = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const CustomText(
            'profile.storage_permission_denied',
            type: CustomTextType.titleMedium,
            color: CustomTextColor.green,
          ),
          content: const CustomText(
            'profile.storage_permission_settings',
            color: CustomTextColor.hint,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const CustomText('app.cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const CustomText('profile.open_settings'),
            ),
          ],
        );
      },
    );

    if (shouldOpenSettings == true) {
      await openAppSettings();
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
