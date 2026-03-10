import 'package:bawabatelhajj/core/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../complaint-categories/presentation/cubits/complaints_categories/complaints_categories_cubit.dart';
import '../../../complaint-kinds/presentation/cubits/complaints_kinds/complaints_kinds_cubit.dart';
import '../cubits/create_complaint/create_complaint_cubit.dart';
import '../widgets/create_complaint/create_complaint_layout.dart';

class CreateComplaint extends StatefulWidget {
  const CreateComplaint({super.key});

  @override
  State<CreateComplaint> createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  String? subjectErrorKey;
  String? detailsErrorKey;
  int? selectedCategory;
  int? selectedKind;

  bool get isFormValid {
    return selectedCategory != null &&
        selectedKind != null &&
        titleController.text.isNotEmpty &&
        titleController.text.length <= 150 &&
        detailsController.text.isNotEmpty &&
        detailsController.text.length <= 1000;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<ComplaintsCategoriesCubit>()..loadComplaintsCategories(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ComplaintsKindsCubit>()..loadComplaintsKinds(),
        ),
        BlocProvider(create: (context) => getIt<CreateComplaintCubit>()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CreateComplaintLayout(
          titleController: titleController,
          detailsController: detailsController,
          selectedCategory: selectedCategory,
          selectedKind: selectedKind,
          subjectErrorKey: subjectErrorKey,
          detailsErrorKey: detailsErrorKey,
          isFormValid: isFormValid,
          onCategoryChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
          onKindChanged: (int? value) {
            setState(() {
              selectedKind = value;
            });
          },
          onSubjectChanged: (value) {
            setState(() {
              subjectErrorKey = value.length > 150
                  ? 'complaints.create.subject_max_length_error'
                  : null;
            });
          },
          onDetailsChanged: (value) {
            setState(() {
              detailsErrorKey = value.length > 1000
                  ? 'complaints.create.details_max_length_error'
                  : null;
            });
          },
        ),
      ),
    );
  }
}
