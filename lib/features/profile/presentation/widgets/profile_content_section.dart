import 'package:flutter/material.dart';

import 'profile_card.dart';

class ProfileContentSection extends StatelessWidget {
  const ProfileContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 20.0;

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: ProfileCard(),
    );
  }
}
