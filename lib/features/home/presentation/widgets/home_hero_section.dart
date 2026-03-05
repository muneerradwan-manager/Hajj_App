import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri_date/hijri.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/functions/date_format.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../shared/widgets/custom_container.dart';

enum CalendarType { hijri, gregorian }

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final fullName = context.select(
      (MeCubit cubit) => cubit.state.profile?.fullName ?? '',
    );
    final firstName = _extractFirstName(fullName);
    final greetingName = firstName.isEmpty ? '-' : firstName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'home.greeting',
                  args: {'name': greetingName},
                  textAlign: TextAlign.center,
                  type: CustomTextType.headlineSmall,
                  color: CustomTextColor.white,
                ),
                const SizedBox(height: 10),
                const CustomText(
                  'home.welcome_subtitle',
                  textAlign: TextAlign.center,
                  type: CustomTextType.labelLarge,
                  color: CustomTextColor.lightGold,
                ),
              ],
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.overlay.withValues(alpha: .23),
              ),
              onPressed: () {},
              icon: const Icon(LucideIcons.bell, color: Colors.white),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: _DateCard(
                icon: LucideIcons.calendar,
                labelKey: 'home.hijri_date',
                value: getHDate(),
                onTap: () => _openCalendar(context, CalendarType.hijri),
              ),
            ),
            Expanded(
              child: _DateCard(
                icon: LucideIcons.clock,
                labelKey: 'home.gregorian_date',
                value: getMDate(),
                onTap: () => _openCalendar(context, CalendarType.gregorian),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _extractFirstName(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '';
    return parts.first;
  }

  Future<void> _openCalendar(BuildContext context, CalendarType type) async {
    final locale = Localizations.localeOf(context).languageCode;
    final hijriLocale = _resolveHijriLocale(locale);

    await showDialog<void>(
      context: context,
      builder: (_) => _UnifiedCalendarDialog(
        type: type,
        localeCode: type == CalendarType.hijri ? hijriLocale : locale,
      ),
    );
  }

  String _resolveHijriLocale(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return 'ar';
      case 'tr':
      case 'id':
      case 'ms':
      case 'fil':
      case 'bn':
      case 'ur':
        return languageCode;
      default:
        return 'en';
    }
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.icon,
    required this.labelKey,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String labelKey;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      hasOpacity: 0.3,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 5,
            children: [
              Icon(icon, color: cs.surfaceDim),
              CustomText(
                labelKey,
                type: CustomTextType.labelSmall,
                color: CustomTextColor.white,
              ),
            ],
          ),
          const SizedBox(height: 5),
          CustomText(
            value,
            type: CustomTextType.bodyLarge,
            color: CustomTextColor.white,
            translate: false,
          ),
        ],
      ),
    );
  }
}

class _UnifiedCalendarDialog extends StatefulWidget {
  const _UnifiedCalendarDialog({required this.type, required this.localeCode});

  final CalendarType type;
  final String localeCode;

  @override
  State<_UnifiedCalendarDialog> createState() => _UnifiedCalendarDialogState();
}

class _UnifiedCalendarDialogState extends State<_UnifiedCalendarDialog> {
  late final DateTime _todayG;
  late final HijriDate _todayH;

  late int _year;
  late int _month;

  @override
  void initState() {
    super.initState();

    _todayG = DateTime.now();

    HijriDate.setLocal(widget.localeCode);
    _todayH = HijriDate.now();

    if (widget.type == CalendarType.gregorian) {
      _year = _todayG.year;
      _month = _todayG.month;
    } else {
      _year = _todayH.hYear;
      _month = _todayH.hMonth;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final headerTitle = widget.type == CalendarType.hijri
        ? '${HijriDate.fromHijri(_year, _month, 1).longMonthName} $_year'
        : DateFormat.yMMMM(
            widget.localeCode,
          ).format(DateTime(_year, _month, 1));

    final weekDayLabels = _weekDayLabels();
    final leadingEmptyCells = _leadingEmptyCells();
    final daysInMonth = _daysInMonth();
    final totalCells = ((leadingEmptyCells + daysInMonth + 6) ~/ 7) * 7;

    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      title: Row(
        children: [
          IconButton(
            onPressed: () => _changeMonth(1),
            icon: const Icon(LucideIcons.chevronRight),
          ),
          Expanded(
            child: Column(
              children: [
                CustomText(
                  widget.type == CalendarType.hijri
                      ? 'home.hijri_date'
                      : 'home.gregorian_date',
                  type: CustomTextType.labelLarge,
                  color: CustomTextColor.green,
                ),
                const SizedBox(height: 4),
                CustomText(
                  headerTitle,
                  translate: false,
                  type: CustomTextType.bodyLarge,
                  color: CustomTextColor.gold,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _changeMonth(-1),
            icon: const Icon(LucideIcons.chevronLeft),
          ),
        ],
      ),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: weekDayLabels
                  .map(
                    (label) => Expanded(
                      child: Center(
                        child: CustomText(
                          label,
                          translate: false,
                          type: CustomTextType.labelSmall,
                          color: CustomTextColor.hint,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              itemCount: totalCells,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                if (index < leadingEmptyCells ||
                    index >= leadingEmptyCells + daysInMonth) {
                  return const SizedBox.shrink();
                }

                final day = index - leadingEmptyCells + 1;
                final isToday = _isToday(day);

                return Container(
                  decoration: BoxDecoration(
                    color: isToday ? cs.primary : cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isToday ? cs.primary : cs.outlineVariant,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    _formatNumber(day),
                    translate: false,
                    type: CustomTextType.bodyMedium,
                    color: isToday
                        ? CustomTextColor.white
                        : CustomTextColor.green,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const CustomText(
            'app.cancel',
            type: CustomTextType.labelLarge,
          ),
        ),
      ],
    );
  }

  void _changeMonth(int offset) {
    setState(() {
      _month += offset;
      if (_month < 1) {
        _month = 12;
        _year -= 1;
      } else if (_month > 12) {
        _month = 1;
        _year += 1;
      }
    });
  }

  List<String> _weekDayLabels() {
    // الاثنين -> الأحد (مثل كودك السابق)
    return List.generate(7, (index) {
      final mondayBased = DateTime(2024, 1, 1).add(Duration(days: index));
      return DateFormat.E(widget.localeCode).format(mondayBased);
    });
  }

  int _leadingEmptyCells() {
    if (widget.type == CalendarType.gregorian) {
      final first = DateTime(_year, _month, 1);
      return first.weekday - 1; // Monday-based
    } else {
      final hMonth = HijriDate.fromHijri(_year, _month, 1);
      final firstG = hMonth.hijriToGregorian(_year, _month, 1);
      return firstG.weekday - 1;
    }
  }

  int _daysInMonth() {
    if (widget.type == CalendarType.gregorian) {
      // آخر يوم بالشهر: day 0 من الشهر اللي بعده
      return DateTime(_year, _month + 1, 0).day;
    } else {
      final hMonth = HijriDate.fromHijri(_year, _month, 1);
      return hMonth.getDaysInMonth(_year, _month);
    }
  }

  bool _isToday(int day) {
    if (widget.type == CalendarType.gregorian) {
      return _todayG.year == _year &&
          _todayG.month == _month &&
          _todayG.day == day;
    } else {
      return _todayH.hYear == _year &&
          _todayH.hMonth == _month &&
          _todayH.hDay == day;
    }
  }

  String _formatNumber(int value) {
    if (widget.localeCode == 'ar') {
      const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
      final chars = value.toString().split('');
      return chars.map((c) => arabicDigits[int.parse(c)]).join();
    }
    return value.toString();
  }
}
