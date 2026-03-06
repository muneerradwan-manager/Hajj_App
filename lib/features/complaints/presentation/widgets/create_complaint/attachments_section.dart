import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:bawabatelhajj/shared/widgets/custom_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

class AttachmentsSection extends StatelessWidget {
  const AttachmentsSection({super.key});

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
                child: const Icon(
                  LucideIcons.camera,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              const CustomText(
                'complaints.create.attachments_label',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomContainer(
            borderSide: CustomBorderSide.allBorder,
            borderWidth: 1.15,
            borderRadius: 14,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                CustomContainer(
                  width: 100,
                  height: 100,
                  containerColor: const Color(0xffD9C89E),
                  hasOpacity: 0.2,
                  child: Icon(
                    LucideIcons.upload,
                    color: cs.primary,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                const CustomText(
                  'complaints.create.attachments_select_images',
                ),
                const SizedBox(height: 5),
                const CustomText(
                  'complaints.create.attachments_formats_hint',
                  color: CustomTextColor.hint,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
