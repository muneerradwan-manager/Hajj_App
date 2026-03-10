import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/constants/app_images.dart';
import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/user_profile.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_state.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/custom_network_image.dart';
import '../../../../shared/widgets/custom_snackbar.dart';

part 'profile_card_sections.dart';
part 'profile_card_shared_widgets.dart';

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
  bool _isSaudiNumberSaving = false;
  final _saudiNumberController = TextEditingController();

  @override
  void dispose() {
    _saudiNumberController.dispose();
    super.dispose();
  }

  final Map<String, bool> _expandedSections = {
    'basic': true,
    'group': false,
    'masterGroup': false,
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

  Future<void> _saveSaudiNumber() async {
    final num = _saudiNumberController.text.trim();
    if (num.isEmpty) return;
    setState(() => _isSaudiNumberSaving = true);
    final result = await context.read<MeCubit>().updateSaudiNumber(num);
    if (!mounted) return;
    result.fold(
      (f) => showMessage(context, f.userMessage, SnackBarType.failuer, translate: false),
      (_) {
        setState(() {
          _saudiNumber = num;
          _isSaudiNumberEditing = false;
        });
        showMessage(context, 'profile.saudi_number_saved', SnackBarType.success, translate: true);
      },
    );
    if (mounted) setState(() => _isSaudiNumberSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final meState = context.watch<MeCubit>().state;
    final profile = meState.profile ?? _emptyProfile;
    final resolvedSaudiNumber =
        _saudiNumber ??
        _extractSaudiNumber(profile.group.applicants, profile.fullName);
    final isResidenceAvailable = _hasResidenceData(profile.group);
    final isFlightAvailable =
        profile.departureFlight != null || profile.returnFlight != null;
    final isRitualsAvailable = _hasRitualsData(profile.group);

    return CustomContainer(
      padding: EdgeInsets.zero,
      borderWidth: 0,
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
            saudiNumber: resolvedSaudiNumber.isEmpty ? null : resolvedSaudiNumber,
            onToggleSaudiNumberEditing: _toggleSaudiNumberEditing,
            saudiNumberController: _saudiNumberController,
            onSaveSaudiNumber: _saveSaudiNumber,
            isSaudiNumberSaving: _isSaudiNumberSaving,
          ),
          _CampaignGroupSection(
            isExpanded: _expandedSections['group'] ?? false,
            onToggle: () => _toggleSection('group'),
            profile: profile,
          ),
          _CampaignMasterGroupSection(
            isExpanded: _expandedSections['masterGroup'] ?? false,
            onToggle: () => _toggleSection('masterGroup'),
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
