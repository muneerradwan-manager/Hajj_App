import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/entites/attachment.dart';
import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_snackbar.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../../../shared/widgets/gradient_elevated_button.dart';
import '../../../domain/entities/complaint.dart';
import '../../cubits/complaint_details/complaint_details_cubit.dart';
import '../../cubits/complaint_details/complaint_details_state.dart';
import 'complaint_details_status_card.dart';

class ComplaintDetailsContentSection extends StatelessWidget {
  const ComplaintDetailsContentSection({
    super.key,
    required this.statusType,
    required this.sendDate,
    required this.receiveDate,
    required this.subjectValueKey,
    required this.fullDetailsBodyKey,
    required this.hasManagementReply,
    required this.managementReplyBodyKey,
    required this.overlap,
    required this.complaintId,
    required this.attachments,
  });

  final ComplaintStatusType statusType;
  final String sendDate;
  final String receiveDate;
  final String subjectValueKey;
  final String fullDetailsBodyKey;
  final bool hasManagementReply;
  final String managementReplyBodyKey;
  final double overlap;
  final int complaintId;
  final List<Attachment> attachments;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        overlap + 20,
        20,
        MediaQuery.paddingOf(context).bottom + 20,
      ),
      child: Transform.translate(
        offset: Offset(0, -overlap),
        child: Column(
          spacing: 20,
          children: [
            ComplaintDetailsStatusCard(
              status: statusType,
              sendDate: sendDate,
              receiveDate: receiveDate,
            ),

            _ComplaintSubjectCard(subjectValueKey: subjectValueKey),

            _ComplaintMessageCard(
              borderColor: CustomBorderColor.red,
              iconBackgroundColor: cs.brandRed,
              titleKey: 'complaints.details.full_details_title',
              titleColor: CustomTextColor.hint,
              bodyKey: fullDetailsBodyKey,
              bodyBorderColor: CustomBorderColor.hint,
              bodyBorderOpacity: .2,
            ),

            if (attachments.isNotEmpty)
              _ComplaintAttachmentsCard(attachments: attachments),

            if (hasManagementReply)
              _ComplaintMessageCard(
                borderColor: CustomBorderColor.green,
                iconBackgroundColor: cs.primary,
                titleKey: 'complaints.details.management_reply_title',
                titleColor: CustomTextColor.green,
                subtitleKey: 'complaints.details.management_reply_subtitle',
                bodyKey: managementReplyBodyKey,
                bodyBorderColor: CustomBorderColor.green,
                bodyBorderOpacity: .2,
              ),

            _DeleteComplaintButton(complaintId: complaintId),
          ],
        ),
      ),
    );
  }
}

class _DeleteComplaintButton extends StatelessWidget {
  const _DeleteComplaintButton({required this.complaintId});

  final int complaintId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintDetailsCubit, ComplaintDetailsState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: GradientElevatedButton(
            gradientColor: GradientColors.red,
            onPressed: state.isDeleting ? null : () => _confirmDelete(context),
            icon: state.isDeleting
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(LucideIcons.trash2, color: Colors.white),
            child: const CustomText(
              'complaints.action.delete',
              color: CustomTextColor.white,
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const _DeleteComplaintDialog(),
    );

    if (confirmed != true || !context.mounted) return;

    final result = await context.read<ComplaintDetailsCubit>().deleteComplaint(
      complaintId,
    );

    if (!context.mounted) return;

    result.fold(
      (failure) => showMessage(
        context,
        failure.userMessage,
        SnackBarType.failuer,
        translate: false,
      ),
      (_) => context.pop(),
    );
  }
}

class _DeleteComplaintDialog extends StatelessWidget {
  const _DeleteComplaintDialog();

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
          _buildHeader(cs, context),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: GradientElevatedButton(
                    gradientColor: GradientColors.outline,
                    
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const CustomText(
                      'app.cancel',
                      color: CustomTextColor.green,
                    ),
                  ),
                ),
                Expanded(
                  child: GradientElevatedButton(
                    gradientColor: GradientColors.red,
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const CustomText(
                      'complaints.action.delete',
                      color: CustomTextColor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomContainer(
          gradientColors: [cs.brandRed.withValues(alpha: 0.75), cs.brandRed],
          borderWidth: 0,
          width: double.infinity,
          padding: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.center,
            children: [
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
                        LucideIcons.trash2,
                        color: AppColors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const CustomText(
                      'complaints.delete.confirm_title',
                      type: CustomTextType.titleLarge,
                      color: CustomTextColor.white,
                    ),
                    const SizedBox(height: 6),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(
                        'complaints.delete.confirm_message',
                        type: CustomTextType.bodyMedium,
                        color: CustomTextColor.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.white.withValues(alpha: 0.2),
            ),
            icon: const Icon(LucideIcons.x, color: AppColors.white, size: 18),
          ),
        ),
      ],
    );
  }
}

class _ComplaintSubjectCard extends StatelessWidget {
  const _ComplaintSubjectCard({required this.subjectValueKey});

  final String subjectValueKey;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      borderSide: CustomBorderSide.borderTop,
      borderColor: CustomBorderColor.gold,
      child: Row(
        children: [
          CustomContainer(
            borderRadius: 15,
            containerColor: cs.brandGold,
            padding: const EdgeInsets.all(10),
            borderWidth: 1,
            child: const Icon(LucideIcons.fileText, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'complaints.details.subject_label',
                  type: CustomTextType.labelLarge,
                  color: CustomTextColor.hint,
                ),
                CustomText(
                  subjectValueKey,
                  type: CustomTextType.bodyLarge,
                  translate: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComplaintMessageCard extends StatelessWidget {
  const _ComplaintMessageCard({
    required this.borderColor,
    required this.iconBackgroundColor,
    required this.titleKey,
    required this.titleColor,
    required this.bodyKey,
    required this.bodyBorderColor,
    required this.bodyBorderOpacity,

    this.subtitleKey,
  });

  final CustomBorderColor borderColor;
  final Color iconBackgroundColor;
  final String titleKey;
  final CustomTextColor titleColor;
  final String bodyKey;

  final CustomBorderColor bodyBorderColor;
  final double bodyBorderOpacity;
  final String? subtitleKey;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderSide: CustomBorderSide.borderTop,
      borderColor: borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            children: [
              CustomContainer(
                borderRadius: 15,
                containerColor: iconBackgroundColor,
                padding: const EdgeInsets.all(10),
                borderWidth: 1,
                child: const Icon(
                  LucideIcons.messageSquare,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      titleKey,
                      type: CustomTextType.labelLarge,
                      color: titleColor,
                    ),
                    if (subtitleKey != null)
                      CustomText(
                        subtitleKey!,
                        type: CustomTextType.labelSmall,
                        color: CustomTextColor.green,
                      ),
                  ],
                ),
              ),
            ],
          ),
          CustomContainer(
            borderSide: CustomBorderSide.allBorder,
            borderWidth: 1,
            borderColor: bodyBorderColor,
            borderHasOpacity: bodyBorderOpacity,
            padding: const EdgeInsets.all(15),
            gradientColors: const [Color(0xffF9F8F6), Colors.white],
            child: CustomText(bodyKey.isEmpty ? '-' : bodyKey),
          ),
        ],
      ),
    );
  }
}

class _ComplaintAttachmentsCard extends StatelessWidget {
  const _ComplaintAttachmentsCard({required this.attachments});

  final List<Attachment> attachments;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      borderSide: CustomBorderSide.borderTop,
      borderColor: CustomBorderColor.gold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Row(
            children: [
              CustomContainer(
                borderRadius: 15,
                containerColor: cs.brandGold,
                padding: const EdgeInsets.all(10),
                borderWidth: 1,
                child: const Icon(LucideIcons.paperclip, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const CustomText(
                'complaints.details.attachments_title',
                type: CustomTextType.labelLarge,
                color: CustomTextColor.hint,
              ),
            ],
          ),
          ...attachments.map((a) => _AttachmentItem(attachment: a)),
        ],
      ),
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  const _AttachmentItem({required this.attachment});

  final Attachment attachment;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderSide: CustomBorderSide.allBorder,
      borderWidth: 1,
      borderColor: CustomBorderColor.gold,
      borderHasOpacity: 0.3,
      padding: const EdgeInsets.all(8),
      borderRadius: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: attachment.attachPath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, _) => const SizedBox(
                height: 180,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              errorWidget: (_, _, _) => const SizedBox(
                height: 100,
                child: Center(child: Icon(LucideIcons.imageOff, size: 36)),
              ),
            ),
          ),
          Row(
            spacing: 6,
            children: [
              const Icon(LucideIcons.image, size: 14),
              Expanded(
                child: CustomText(
                  attachment.attachName,
                  translate: false,
                  type: CustomTextType.bodySmall,
                  color: CustomTextColor.hint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
