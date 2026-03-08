import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_state.dart';
import 'package:bawabatelhajj/shared/widgets/custom_snackbar.dart';

import '../widgets/profile_layout.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeCubit, MeState>(
      listenWhen: (previous, current) =>
          previous.isNetworkError != current.isNetworkError ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (!state.isNetworkError || state.errorMessage.isEmpty) return;
        final isCurrentRoute = ModalRoute.of(context)?.isCurrent ?? true;
        if (!isCurrentRoute) return;
        showMessage(
          context,
          'app.no_internet_connection',
          SnackBarType.failuer,
          translate: true,
        );
      },
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: ProfileLayout(),
      ),
    );
  }
}
