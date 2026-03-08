import 'dart:io';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/custom_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_snackbar.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';

class AttachmentsSection extends StatefulWidget {
  const AttachmentsSection({super.key});

  @override
  State<AttachmentsSection> createState() => _AttachmentsSectionState();
}

class _AttachmentsSectionState extends State<AttachmentsSection> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool _isPicking = false;

  Future<void> _onAttachmentTap() async {
    if (_isPicking) return;

    final source = await _showPickSourceSheet();
    if (!mounted || source == null) return;

    await _pickImage(source);
  }

  Future<ImageSource?> _showPickSourceSheet() {
    final cs = Theme.of(context).colorScheme;

    return showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                const CustomText(
                  'complaints.create.attachments_pick_source_title',
                  type: CustomTextType.titleMedium,
                  color: CustomTextColor.green,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cs.brandGold.withValues(alpha: 0.18),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(LucideIcons.image, color: cs.brandGold),
                  ),
                  title: const CustomText(
                    'complaints.create.attachments_pick_gallery',
                    type: CustomTextType.bodyLarge,
                  ),
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cs.primary.withValues(alpha: 0.18),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(LucideIcons.camera, color: cs.primary),
                  ),
                  title: const CustomText(
                    'complaints.create.attachments_pick_camera',
                    type: CustomTextType.bodyLarge,
                  ),
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final hasPermission = await _ensurePermission(source);
    if (!hasPermission || !mounted) return;

    setState(() => _isPicking = true);

    try {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (!mounted || image == null) return;

      setState(() {
        // Single-image mode: a new pick always replaces the old one.
        _selectedImage = image;
      });
    } catch (_) {
      if (!mounted) return;
      showMessage(
        context,
        'complaints.create.attachments_pick_failed',
        SnackBarType.failuer,
        translate: true,
      );
    } finally {
      if (mounted) {
        setState(() => _isPicking = false);
      }
    }
  }

  Future<bool> _ensurePermission(ImageSource source) async {
    final status = source == ImageSource.camera
        ? await Permission.camera.request()
        : await _requestGalleryPermission();

    if (_isGranted(status)) return true;

    if (status.isPermanentlyDenied || status.isRestricted) {
      if (!mounted) return false;
      await _showSettingsDialog(
        source == ImageSource.camera
            ? 'complaints.create.attachments_camera_permission_settings'
            : 'complaints.create.attachments_gallery_permission_settings',
      );
      return false;
    }

    if (!mounted) return false;
    showMessage(
      context,
      source == ImageSource.camera
          ? 'complaints.create.attachments_camera_permission_denied'
          : 'complaints.create.attachments_gallery_permission_denied',
      SnackBarType.failuer,
      translate: true,
    );
    return false;
  }

  Future<PermissionStatus> _requestGalleryPermission() async {
    if (Platform.isIOS) {
      return Permission.photos.request();
    }

    if (Platform.isAndroid) {
      final photosStatus = await Permission.photos.request();
      if (_isGranted(photosStatus)) return photosStatus;

      final storageStatus = await Permission.storage.request();
      if (_isGranted(storageStatus)) return storageStatus;

      if (photosStatus.isPermanentlyDenied || photosStatus.isRestricted) {
        return photosStatus;
      }

      return storageStatus;
    }

    return PermissionStatus.granted;
  }

  bool _isGranted(PermissionStatus status) {
    return status.isGranted || status.isLimited;
  }

  Future<void> _showSettingsDialog(String messageKey) async {
    final shouldOpenSettings = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const CustomText(
            'complaints.create.attachments_permission_title',
            type: CustomTextType.titleMedium,
            color: CustomTextColor.green,
          ),
          content: CustomText(messageKey, color: CustomTextColor.hint),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const CustomText('app.cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const CustomText(
                'complaints.create.attachments_open_settings',
              ),
            ),
          ],
        );
      },
    );

    if (shouldOpenSettings == true) {
      await openAppSettings();
    }
  }

  void _removeImage() {
    setState(() => _selectedImage = null);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: cs.primaryContainer,
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(LucideIcons.camera, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const CustomText(
                'complaints.create.attachments_label',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: _onAttachmentTap,
            child: CustomContainer(
              borderSide: CustomBorderSide.allBorder,
              borderColor: CustomBorderColor.gold,
              borderWidth: 1.15,
              borderRadius: 14,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: _selectedImage == null
                  ? Column(
                      children: [
                        CustomContainer(
                          width: 60,
                          height: 60,
                          containerColor: cs.brandGold,
                          hasOpacity: 0.2,
                          hasShadow: false,
                          padding: EdgeInsets.zero,
                          child: Icon(
                            LucideIcons.upload,
                            color: cs.brandGold,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const CustomText(
                          'complaints.create.attachments_select_images',
                        ),
                        const SizedBox(height: 8),
                        const CustomText(
                          'complaints.create.attachments_single_image_notice',
                          color: CustomTextColor.hint,
                          textAlign: TextAlign.center,
                          type: CustomTextType.bodySmall,
                        ),
                        if (_isPicking) ...[
                          const SizedBox(height: 12),
                          const LinearProgressIndicator(minHeight: 3),
                        ],
                      ],
                    )
                  : Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_selectedImage!.path),
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: CustomText(
                                _selectedImage!.name,
                                translate: false,
                                color: CustomTextColor.green,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: cs.error.withValues(
                                  alpha: 0.12,
                                ),
                              ),
                              onPressed: _removeImage,
                              icon: Icon(LucideIcons.trash2, color: cs.error),
                            ),
                          ],
                        ),
                        OutlinedButton.icon(
                          onPressed: _onAttachmentTap,
                          icon: const Icon(LucideIcons.refreshCw, size: 18),
                          label: const CustomText(
                            'complaints.create.attachments_change_image',
                            type: CustomTextType.labelLarge,
                            color: CustomTextColor.green,
                          ),
                        ),
                        const CustomText(
                          'complaints.create.attachments_single_image_notice',
                          color: CustomTextColor.hint,
                          textAlign: TextAlign.center,
                          type: CustomTextType.bodySmall,
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            spacing: 8,
            children: [
              Icon(LucideIcons.info, size: 16, color: cs.brandGold),
              const Expanded(
                child: CustomText(
                  'complaints.create.attachments_single_image_limit',
                  type: CustomTextType.bodySmall,
                  color: CustomTextColor.hint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
