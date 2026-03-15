import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/constants/app_images.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/custom_snackbar.dart';
import '../../../../shared/widgets/gradient_elevated_button.dart';

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
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Hero header ──
          _buildHeader(cs),
          // ── Info items ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: CustomContainer(
              containerColor: const Color(0xffF9F8F6),
              borderRadius: 16,
              borderWidth: 0,
              padding: const EdgeInsets.symmetric(vertical: 8),
              hasShadow: false,
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
          gradientColors: [cs.brandRedAlt, cs.brandRed],
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
                      borderWidth: 0,
                      borderHasOpacity: .3,
                      containerColor: Colors.white,
                      hasOpacity: 0.3,
                      padding: EdgeInsets.zero,
                      child: Icon(
                        LucideIcons.mapPin,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      'home.help_title',
                      type: CustomTextType.titleLarge,
                      color: CustomTextColor.white,
                    ),
                    SizedBox(height: 6),
                    Padding(
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
    return GradientElevatedButton(
      gradientColor: GradientColors.red,
      onPressed: _isSending ? null : _sendLocation,
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
