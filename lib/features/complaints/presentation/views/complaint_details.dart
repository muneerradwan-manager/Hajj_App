import 'package:flutter/material.dart';

import '../widgets/complaint_details/complaint_details_layout.dart';

class ComplaintDetails extends StatelessWidget {
  const ComplaintDetails({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ComplaintDetailsLayout(complaintId: id),
    );
  }
}
