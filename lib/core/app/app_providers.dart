import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubits/me/me_cubit.dart';
import '../di/dependency_injection.dart';
import '../localization/localization_cubit.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LocalizationCubit>()),
        BlocProvider(create: (_) => getIt<MeCubit>()),
      ],
      child: child,
    );
  }
}
