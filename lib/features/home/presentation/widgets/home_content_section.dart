import 'package:flutter/material.dart';

import 'hajj_ayah.dart';
import 'home_card.dart';
import 'prayer_times.dart';
import 'quick_actions.dart';
import 'send_help_button.dart';
import 'timer_lift.dart';

class HomeContentSection extends StatelessWidget {
  const HomeContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 20.0;

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        spacing: 30,
        children: [
          HomeCard(),
          SendHelpButton(),
          TimerLift(),
          PrayerTimesWidget(),
          QuickActions(),
          HajjAyah(),
        ],
      ),
    );
  }
}
