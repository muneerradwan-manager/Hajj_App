import 'dart:async';
import 'dart:math';

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
  _EventCountdownTarget? _activeTarget;
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = Duration.zero;
    _refreshCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(_refreshCountdown);
    });
  }

  void _refreshCountdown() {
    final now = DateTime.now();
    final nextTarget = _resolveCurrentOrNextTarget(now);
    _activeTarget = nextTarget;
    if (nextTarget == null) {
      _remaining = Duration.zero;
      return;
    }

    final diff = nextTarget.targetDate.difference(now);
    _remaining = diff.isNegative ? Duration.zero : diff;
  }

  _EventCountdownTarget? _resolveCurrentOrNextTarget(DateTime now) {
    final currentHijriYear = HijriDate.fromDate(now).hYear;
    final ongoingTargets = <_EventCountdownTarget>[];
    final upcomingTargets = <_EventCountdownTarget>[];

    for (final event in IslamicEventsManager.allEvents) {
      for (final year in [currentHijriYear, currentHijriYear + 1]) {
        final validDays =
            event.days
                .where(
                  (day) => _tryHijriToGregorian(year, event.month, day) != null,
                )
                .toList()
              ..sort();

        if (validDays.isEmpty) continue;

        final startDay = validDays.first;
        final endDay = validDays.last;
        final startDate = _tryHijriToGregorian(year, event.month, startDay);
        final endDate = _tryHijriToGregorian(year, event.month, endDay);
        if (startDate == null || endDate == null) continue;

        final eventEndExclusive = endDate.add(const Duration(days: 1));
        final isOngoing =
            !now.isBefore(startDate) && now.isBefore(eventEndExclusive);

        if (isOngoing) {
          ongoingTargets.add(
            _EventCountdownTarget(
              event: event,
              targetDate: eventEndExclusive,
              isEnding: true,
            ),
          );
          continue;
        }

        if (startDate.isAfter(now)) {
          upcomingTargets.add(
            _EventCountdownTarget(
              event: event,
              targetDate: startDate,
              isEnding: false,
            ),
          );
        }
      }
    }

    if (ongoingTargets.isNotEmpty) {
      ongoingTargets.sort((a, b) {
        final byDate = a.targetDate.compareTo(b.targetDate);
        if (byDate != 0) return byDate;
        return a.event.id.compareTo(b.event.id);
      });
      return ongoingTargets.first;
    }

    if (upcomingTargets.isEmpty) return null;
    upcomingTargets.sort((a, b) {
      final byDate = a.targetDate.compareTo(b.targetDate);
      if (byDate != 0) return byDate;
      return a.event.id.compareTo(b.event.id);
    });
    return upcomingTargets.first;
  }

  DateTime? _tryHijriToGregorian(int year, int month, int day) {
    try {
      final hijriDate = HijriDate.fromHijri(year, month, day);
      return hijriDate.hijriToGregorian(year, month, day);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;
    final locale = languageCode == 'ar' ? 'ar' : 'en';
    final eventTitle = _activeTarget?.event.getTitle(locale) ?? '';
    final headerKey = _activeTarget == null
        ? 'home.no_upcoming_events'
        : _activeTarget!.isEnding
        ? 'home.event_ends_in'
        : 'home.event_starts_in';

    final units = [
      _CountdownUnit(
        value: max(0, _remaining.inDays).toString().padLeft(2, '0'),
        labelKey: 'home.day',
      ),
      _CountdownUnit(
        value: max(0, _remaining.inHours % 24).toString().padLeft(2, '0'),
        labelKey: 'home.hour',
      ),
      _CountdownUnit(
        value: max(0, _remaining.inMinutes % 60).toString().padLeft(2, '0'),
        labelKey: 'home.minute',
      ),
      _CountdownUnit(
        value: max(0, _remaining.inSeconds % 60).toString().padLeft(2, '0'),
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
          CustomText(
            headerKey,
            args: _activeTarget == null ? null : {'event': eventTitle},
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

class _EventCountdownTarget {
  const _EventCountdownTarget({
    required this.event,
    required this.targetDate,
    required this.isEnding,
  });

  final IslamicEvent event;
  final DateTime targetDate;
  final bool isEnding;
}
