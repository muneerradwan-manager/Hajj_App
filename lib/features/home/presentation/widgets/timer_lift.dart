import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:hijri_date/hijri.dart';

class TimerLift extends StatefulWidget {
  const TimerLift({super.key});

  @override
  State<TimerLift> createState() => _TimerLiftState();
}

class _TimerLiftState extends State<TimerLift> {
  static const _targetHijriDay = 9;
  static const _targetHijriMonth = 12;
  static const _targetHijriYear = 1447;

  late final DateTime _targetDate;
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _targetDate = HijriDate().hijriToGregorian(
      _targetHijriYear,
      _targetHijriMonth,
      _targetHijriDay,
    );
    _remaining = _calculateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _remaining = _calculateRemaining());
    });
  }

  Duration _calculateRemaining() {
    final diff = _targetDate.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final units = [
      _CountdownUnit(
        value: _remaining.inDays.toString().padLeft(2, '0'),
        labelKey: 'home.day',
      ),
      _CountdownUnit(
        value: (_remaining.inHours % 24).toString().padLeft(2, '0'),
        labelKey: 'home.hour',
      ),
      _CountdownUnit(
        value: (_remaining.inMinutes % 60).toString().padLeft(2, '0'),
        labelKey: 'home.minute',
      ),
      _CountdownUnit(
        value: (_remaining.inSeconds % 60).toString().padLeft(2, '0'),
        labelKey: 'home.second',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
        border: Border.all(color: cs.brandRed),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          const CustomText(
            'home.arafat_countdown',
            type: CustomTextType.titleMedium,
            color: CustomTextColor.red,
          ),
          Row(
            spacing: 5,
            children: [
              for (int i = 0; i < units.length; i++) ...[
                if (i > 0)
                  const CustomText(
                    ':',
                    color: CustomTextColor.red,
                    translate: false,
                  ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: cs.brandRed,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomText(
                          units[i].value,
                          type: CustomTextType.titleMedium,
                          color: CustomTextColor.white,
                          translate: false,
                        ),
                        CustomText(
                          units[i].labelKey,
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownUnit {
  const _CountdownUnit({required this.value, required this.labelKey});
  final String value;
  final String labelKey;
}
