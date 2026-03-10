import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bawabatelhajj/core/di/dependency_injection.dart';

import '../cubits/complaints/complaints_cubit.dart';
import '../widgets/complaints/complaints_layout.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ComplaintsCubit>()..loadComplaints(),
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: ComplaintsLayout(),
      ),
    );
  }
}
