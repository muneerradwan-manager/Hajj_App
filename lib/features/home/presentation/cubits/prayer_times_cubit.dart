import 'package:geolocator/geolocator.dart';

import 'package:hajj_app/core/cubits/safe_cubit.dart';
import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/home/domain/services/prayer_times_service.dart';

import 'prayer_times_state.dart';

class PrayerTimesCubit extends SafeCubit<PrayerTimesState> {
  final PrayerTimesService _service;

  PrayerTimesCubit(this._service) : super(const PrayerTimesState.initial());

  Future<void> loadPrayerTimes() async {
    safeEmit(state.copyWith(status: PrayerTimesStatus.loading));

    final result = await _service.getPrayerTimes();

    result.fold(
      (failure) => safeEmit(
        state.copyWith(
          status: PrayerTimesStatus.error,
          errorMessage: failure.message,
          isLocationError: failure is LocationFailure,
        ),
      ),
      (data) => safeEmit(
        state.copyWith(
          status: PrayerTimesStatus.loaded,
          prayerTimes: data,
          isLocationError: false,
        ),
      ),
    );
  }

  Future<void> openLocationSettings() async {
    // 1. Check if the device GPS is completely turned off
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // 2. Check app-specific permissions
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // If GPS is on but we don't have access, they must grant it in App Settings
      await Geolocator.openAppSettings();
    }
  }
}
