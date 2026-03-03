import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/features/home/presentation/cubits/prayer_times_cubit.dart';
import 'package:bawabatelhajj/features/home/presentation/cubits/prayer_times_state.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

class PrayerTimesWidget extends StatefulWidget {
  const PrayerTimesWidget({super.key});

  @override
  State<PrayerTimesWidget> createState() => _PrayerTimesWidgetState();
}

class _PrayerTimesWidgetState extends State<PrayerTimesWidget>
    with WidgetsBindingObserver {
  bool _waitingForSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final cubit = context.read<PrayerTimesCubit>();
    if (cubit.state.status == PrayerTimesStatus.initial) {
      cubit.loadPrayerTimes();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _waitingForSettings) {
      _waitingForSettings = false;
      context.read<PrayerTimesCubit>().loadPrayerTimes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cs.primary),
            color: cs.surface,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    'home.prayer_times',
                    type: CustomTextType.titleMedium,
                    color: CustomTextColor.green,
                  ),
                  CustomText(
                    state.prayerTimes?.locationName.isNotEmpty == true
                        ? state.prayerTimes!.locationName
                        : 'home.prayer_location',
                    type: CustomTextType.titleSmall,
                    color: CustomTextColor.gold,
                    translate:
                        state.prayerTimes?.locationName.isNotEmpty != true,
                  ),
                ],
              ),
              _buildPrayerRow(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrayerRow(BuildContext context, PrayerTimesState state) {
    if (state.status == PrayerTimesStatus.loading ||
        state.status == PrayerTimesStatus.initial) {
      return const SizedBox(
        height: 60,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.status == PrayerTimesStatus.error) {
      final cubit = context.read<PrayerTimesCubit>();
      final cs = Theme.of(context).colorScheme;

      return Column(
        spacing: 10,
        children: [
          CustomText(
            state.errorMessage,
            type: CustomTextType.bodySmall,
            color: CustomTextColor.hint,
          ),
          if (state.isLocationError)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  _waitingForSettings = true;
                  await cubit.openLocationSettings();
                },
                icon: Icon(LucideIcons.mapPin, size: 16, color: cs.primary),
                label: const CustomText(
                  'home.prayer_enable_location',
                  type: CustomTextType.labelMedium,
                  color: CustomTextColor.green,
                ),
              ),
            )
          else
            TextButton(
              onPressed: () => cubit.loadPrayerTimes(),
              child: const CustomText(
                'home.prayer_retry',
                type: CustomTextType.labelMedium,
                color: CustomTextColor.green,
              ),
            ),
        ],
      );
    }

    final model = state.prayerTimes!;
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormat = DateFormat('hh:mm', locale);

    final prayers = [
      _PrayerCellData('home.prayer_fajr', model.fajr, Prayer.fajr),
      _PrayerCellData('home.prayer_dhuhr', model.dhuhr, Prayer.dhuhr),
      _PrayerCellData('home.prayer_asr', model.asr, Prayer.asr),
      _PrayerCellData('home.prayer_maghrib', model.maghrib, Prayer.maghrib),
      _PrayerCellData('home.prayer_isha', model.isha, Prayer.isha),
    ];

    return Row(
      spacing: 5,
      children: [
        for (final p in prayers)
          Expanded(
            child: _PrayerTimeCell(
              nameKey: p.nameKey,
              time: timeFormat.format(p.dateTime),
              isActive: model.currentPrayer == p.prayer,
            ),
          ),
      ],
    );
  }
}

class _PrayerCellData {
  const _PrayerCellData(this.nameKey, this.dateTime, this.prayer);

  final String nameKey;
  final DateTime dateTime;
  final Prayer prayer;
}

class _PrayerTimeCell extends StatelessWidget {
  const _PrayerTimeCell({
    required this.nameKey,
    required this.time,
    this.isActive = false,
  });

  final String nameKey;
  final String time;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final nameColor = isActive ? CustomTextColor.white : CustomTextColor.green;
    final timeColor = isActive ? CustomTextColor.white : CustomTextColor.gold;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? cs.primary : cs.brandGold),
        color: isActive ? cs.primary : null,
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        spacing: 10,
        children: [
          CustomText(
            nameKey,
            type: CustomTextType.labelSmall,
            color: nameColor,
          ),
          CustomText(
            time,
            type: CustomTextType.bodySmall,
            color: timeColor,
            translate: false,
          ),
        ],
      ),
    );
  }
}
