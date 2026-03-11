import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../../../shared/widgets/gradient_elevated_button.dart';

import '../../cubits/complaints/complaints_cubit.dart';

class NewComplaintButton extends StatelessWidget {
  const NewComplaintButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientElevatedButton(
      onPressed: () async {
        final created = await context.push<bool>(AppRoutes.createComplaintPath);
        if (created == true) {
          context.read<ComplaintsCubit>().loadComplaints();
        }
      },
      gradientColor: GradientColors.red,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Icon(LucideIcons.plus),
          CustomText('complaints.new_complaint', color: CustomTextColor.white),
        ],
      ),
    );
  }
}
