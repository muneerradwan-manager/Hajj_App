import 'package:flutter/material.dart';

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
  String? selectedDepartment;

  bool get isFormValid {
    return selectedDepartment != null &&
        titleController.text.isNotEmpty &&
        titleController.text.length <= 150 &&
        detailsController.text.isNotEmpty &&
        detailsController.text.length <= 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CreateComplaintLayout(
        titleController: titleController,
        detailsController: detailsController,
        selectedDepartment: selectedDepartment,
        subjectErrorKey: subjectErrorKey,
        detailsErrorKey: detailsErrorKey,
        isFormValid: isFormValid,
        onDepartmentChanged: (value) {
          setState(() {
            selectedDepartment = value;
          });
        },
        onTitleChanged: (value) {
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
    );
  }
}
