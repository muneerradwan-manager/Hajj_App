import 'package:flutter/material.dart';

import '../widgets/evaluations_layout.dart';

class EvaluationsView extends StatefulWidget {
  const EvaluationsView({super.key});

  @override
  State<EvaluationsView> createState() => _EvaluationsViewState();
}

class _EvaluationsViewState extends State<EvaluationsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: EvaluationsLayout(),
    );
  }
}
