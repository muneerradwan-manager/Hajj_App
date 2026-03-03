import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/constants/app_images.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../shared/widgets/custom_snackbar.dart';

/// Shows the "Send Help" confirmation dialog.
///
/// Returns `true` if the location was sent successfully, `false` otherwise,
/// or `null` if the dialog was dismissed.
Future<bool?> showSendHelpDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => const _SendHelpDialog(),
  );
}

class _SendHelpDialog extends StatefulWidget {
  const _SendHelpDialog();

  @override
  State<_SendHelpDialog> createState() => _SendHelpDialogState();
}

class _SendHelpDialogState extends State<_SendHelpDialog> {
  bool _isSending = false;

  Future<void> _sendLocation() async {
    setState(() => _isSending = true);

    try {
      // 1. Check if device location service (GPS) is enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() => _isSending = false);
          // Prompt the user to open settings and turn on device location
          await _promptEnableLocationService();
        }
        return;
      }

      // 2. Check / request app permission
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            showMessage(
              context,
              'home.help_dialog_permission_error',
              SnackBarType.failuer,
              translate: true,
            );
          }
          return;
        }
      }

      // If permissions are permanently denied, direct to App Settings
      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() => _isSending = false);
          await _promptOpenAppSettings();
        }
        return;
      }

      // 3. Get current position
      await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (_) {
      if (mounted) {
        showMessage(
          context,
          'home.help_dialog_location_error',
          SnackBarType.failuer,
          translate: true,
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _promptEnableLocationService() {
    return _showSettingsDialog(
      titleKey: 'home.help_dialog_gps_title',
      contentKey: 'home.help_dialog_location_error',
      actionKey: 'home.help_dialog_settings',
      onOpenSettings: Geolocator.openLocationSettings,
    );
  }

  Future<void> _promptOpenAppSettings() {
    return _showSettingsDialog(
      titleKey: 'home.help_dialog_permission_title',
      contentKey: 'home.help_dialog_permission_error',
      actionKey: 'home.help_dialog_app_settings',
      onOpenSettings: Geolocator.openAppSettings,
    );
  }

  Future<void> _showSettingsDialog({
    required String titleKey,
    required String contentKey,
    required String actionKey,
    required Future<bool> Function() onOpenSettings,
  }) async {
    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: CustomText(
          titleKey,
          type: CustomTextType.titleMedium,
          color: CustomTextColor.black,
        ),
        content: CustomText(
          contentKey,
          type: CustomTextType.bodyMedium,
          color: CustomTextColor.black,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const CustomText(
              'home.help_dialog_cancel',
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.black,
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await onOpenSettings();
            },
            child: CustomText(
              actionKey,
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.green,
            ),
          ),
        ],
      ),
    );
  }

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
          // ── Hero header ──
          _buildHeader(cs),
          // ── Info items ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF9F8F6),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  const _InfoTile(
                    titleKey: 'home.help_dialog_gps_title',
                    subtitleKey: 'home.help_dialog_gps_subtitle',
                  ),
                  Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: cs.outlineVariant,
                  ),
                  const _InfoTile(
                    titleKey: 'home.help_dialog_send_title',
                    subtitleKey: 'home.help_dialog_send_subtitle',
                  ),
                  Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: cs.outlineVariant,
                  ),
                  const _InfoTile(
                    titleKey: 'home.help_dialog_map_title',
                    subtitleKey: 'home.help_dialog_map_subtitle',
                  ),
                ],
              ),
            ),
          ),
          // ── Buttons ──
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                // Send location button
                _buildSendButton(cs),
                // Cancel button
                OutlinedButton(
                  onPressed: _isSending
                      ? null
                      : () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: cs.surfaceDim,
                    side: BorderSide(color: cs.brandGold.withValues(alpha: .3)),
                  ),
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
        Container(
          width: double.infinity,

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff7A2631), Color(0xff672146)],
            ),
          ),
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
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 30),
                child: Column(
                  children: [
                    // Location icon badge
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
                        LucideIcons.mapPin,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const CustomText(
                      'home.help_title',
                      type: CustomTextType.titleLarge,
                      color: CustomTextColor.white,
                    ),
                    const SizedBox(height: 6),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(
                        'home.help_dialog_subtitle',
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
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff7A2631), Color(0xff672146)],
        ),
      ),
      child: ElevatedButton(
        onPressed: _isSending ? null : _sendLocation,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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
                  Icon(LucideIcons.mapPin, color: AppColors.white, size: 18),
                  CustomText(
                    'home.help_dialog_send_button',
                    type: CustomTextType.titleSmall,
                    color: CustomTextColor.white,
                  ),
                ],
              ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.titleKey, required this.subtitleKey});

  final String titleKey;
  final String subtitleKey;

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
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.check,
              color: AppColors.white,
              size: 16,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  titleKey,
                  type: CustomTextType.bodyLarge,
                  color: CustomTextColor.green,
                ),
                const SizedBox(height: 2),
                CustomText(
                  subtitleKey,
                  type: CustomTextType.bodySmall,
                  color: CustomTextColor.gold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
