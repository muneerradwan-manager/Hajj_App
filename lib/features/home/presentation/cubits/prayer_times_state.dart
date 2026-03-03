import 'package:equatable/equatable.dart';

import 'package:bawabatelhajj/features/home/domain/models/prayer_times_model.dart';

enum PrayerTimesStatus { initial, loading, loaded, error }

class PrayerTimesState extends Equatable {
  final PrayerTimesStatus status;
  final PrayerTimesModel? prayerTimes;
  final String errorMessage;
  final bool isLocationError;

  const PrayerTimesState({
    required this.status,
    this.prayerTimes,
    this.errorMessage = '',
    this.isLocationError = false,
  });

  const PrayerTimesState.initial()
    : status = PrayerTimesStatus.initial,
      prayerTimes = null,
      errorMessage = '',
      isLocationError = false;

  PrayerTimesState copyWith({
    PrayerTimesStatus? status,
    PrayerTimesModel? prayerTimes,
    String? errorMessage,
    bool? isLocationError,
  }) {
    return PrayerTimesState(
      status: status ?? this.status,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      errorMessage: errorMessage ?? this.errorMessage,
      isLocationError: isLocationError ?? this.isLocationError,
    );
  }

  @override
  List<Object?> get props => [
    status,
    prayerTimes,
    errorMessage,
    isLocationError,
  ];
}
