import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubits/phases/phases_cubit.dart';
import '../widgets/evaluations_layout.dart';

class EvaluationsView extends StatefulWidget {
  const EvaluationsView({super.key});

  @override
  State<EvaluationsView> createState() => _EvaluationsViewState();
}

class _EvaluationsViewState extends State<EvaluationsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PhasesCubit>()..loadPhases(),
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: EvaluationsLayout(),
      ),
    );
  }
}
