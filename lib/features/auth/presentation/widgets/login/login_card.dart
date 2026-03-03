import 'package:flutter/material.dart';

import 'package:bawabatelhajj/shared/widgets/app_card_container.dart';

import 'login_form.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCardContainer(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 18),
      borderRadius: 28,
      showShadow: true,
      child: LoginForm(),
    );
  }
}
