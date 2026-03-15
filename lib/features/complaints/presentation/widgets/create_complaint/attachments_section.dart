import 'dart:io';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/custom_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_snackbar.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import '../../cubits/create_complaint/create_complaint_cubit.dart';

class AttachmentsSection extends StatefulWidget {
  const AttachmentsSection({super.key});

  @override
  State<AttachmentsSection> createState() => _AttachmentsSectionState();
}

class _AttachmentsSectionState extends State<AttachmentsSection> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];
  bool _isPicking = false;

  Future<void> _onAttachmentTap() async {
    if (_isPicking) return;

    final cubit = context.read<CreateComplaintCubit>();
    if (_selectedImages.length >= 2) {
      showMessage(
        context,
        'complaints.create.attachments_max_two',
        SnackBarType.failuer,
        translate: true,
      );
      return;
    }

    final source = await _showPickSourceSheet();
    if (!mounted || source == null) return;

    await _pickImage(source, cubit);
  }

  Future<ImageSource?> _showPickSourceSheet() {
    final cs = Theme.of(context).colorScheme;

    return showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              CustomContainer(
                gradientColors: [cs.surfaceDim, cs.brandGold],
                borderWidth: 0,
                padding: const EdgeInsets.all(15),
                borderRadius: 12,
                child: const Icon(LucideIcons.camera, color: Colors.white),
              ),
              const Column(
                children: [
                  CustomText(
                    'complaints.create.attachments_pick_source_title',
                    type: CustomTextType.titleMedium,
                  ),
                  SizedBox(height: 5),
                  CustomText(
                    'complaints.create.attachments_pick_source_subtitle',
                    type: CustomTextType.labelMedium,
                    color: CustomTextColor.hint,
                  ),
                ],
              ),
              Column(
                spacing: 10,
                children: [
                  GradientElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(ImageSource.camera),
                    gradientColor: GradientColors.green,
                    icon: const Icon(LucideIcons.camera),
                    child: const CustomText(
                      'complaints.create.attachments_pick_camera',
                      type: CustomTextType.bodyLarge,
                      color: CustomTextColor.white,
                    ),
                  ),
                  GradientElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(ImageSource.gallery),
                    gradientColor: GradientColors.gold,
                    icon: const Icon(LucideIcons.image),
                    child: const CustomText(
                      'complaints.create.attachments_pick_gallery',
                      type: CustomTextType.bodyLarge,
                      color: CustomTextColor.white,
                    ),
                  ),
                  GradientElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(ImageSource.gallery),
                    gradientColor: GradientColors.outline,
                    child: const CustomText(
                      'app.cancel',
                      type: CustomTextType.bodyLarge,
                      color: CustomTextColor.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(
    ImageSource source,
    CreateComplaintCubit cubit,
  ) async {
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

      setState(() => _selectedImages.add(image));
      cubit.updateAttachments(
        _selectedImages.map((e) => File(e.path)).toList(),
      );
    } catch (_) {
      if (!mounted) return;
      showMessage(
        context,
        'complaints.create.attachments_pick_failed',
        SnackBarType.failuer,
        translate: true,
      );
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  void _removeImage(int index) {
    final cubit = context.read<CreateComplaintCubit>();
    setState(() => _selectedImages.removeAt(index));
    cubit.updateAttachments(_selectedImages.map((e) => File(e.path)).toList());
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
    if (Platform.isIOS) return Permission.photos.request();
    if (Platform.isAndroid) {
      final photosStatus = await Permission.photos.request();
      if (_isGranted(photosStatus)) return photosStatus;

      final storageStatus = await Permission.storage.request();
      if (_isGranted(storageStatus)) return storageStatus;

      return storageStatus;
    }
    return PermissionStatus.granted;
  }

  bool _isGranted(PermissionStatus status) =>
      status.isGranted || status.isLimited;

  Future<void> _showSettingsDialog(String messageKey) async {
    final shouldOpenSettings = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
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
      ),
    );

    if (shouldOpenSettings == true) await openAppSettings();
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
              CustomContainer(
                borderRadius: 15,
                gradientColors: [cs.primaryContainer, cs.primary],
                padding: const EdgeInsets.all(10),
                borderWidth: 0,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: _selectedImages.isEmpty
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
                        const CustomText(
                          'complaints.create.attachments_formats_hint',
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
                      children: List.generate(_selectedImages.length, (index) {
                        final image = _selectedImages[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(image.path),
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    image.name,
                                    translate: false,
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
                                  onPressed: () => _removeImage(index),
                                  icon: Icon(
                                    LucideIcons.trash2,
                                    color: cs.error,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          CustomContainer(
            borderWidth: 1,
            borderColor: CustomBorderColor.lightGold,
            containerColor: cs.surfaceDim,
            hasOpacity: .2,
            hasShadow: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                CustomContainer(
                  containerColor: cs.brandGold,
                  hasShadow: false,
                  borderRadius: 12,
                  padding: EdgeInsets.zero,
                  child: const Icon(LucideIcons.info, color: Colors.white),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'complaints.create.attachments_important_note_title',
                        type: CustomTextType.bodyMedium,
                      ),
                      CustomText(
                        'complaints.create.attachments_important_note_body',
                        type: CustomTextType.labelMedium,
                        color: CustomTextColor.hint,
                      ),
                    ],
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
