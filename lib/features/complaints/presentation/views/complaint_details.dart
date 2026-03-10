import 'package:flutter/material.dart';

import '../../domain/entities/complaint.dart';
import '../widgets/complaint_details/complaint_details_layout.dart';

class ComplaintDetails extends StatelessWidget {
  const ComplaintDetails({super.key, required this.complaint});

  final Complaint complaint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ComplaintDetailsLayout(complaint: complaint),
    );
  }
}
