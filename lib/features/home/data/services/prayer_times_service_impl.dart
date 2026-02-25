import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geocoding/geocoding.dart' as geocoding;

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/home/domain/models/prayer_times_model.dart';
import 'package:hajj_app/features/home/domain/services/prayer_times_service.dart';

class PrayerTimesServiceImpl implements PrayerTimesService {
  @override
  Future<Either<Failure, PrayerTimesModel>> getPrayerTimes() async {
    try {
      // 1. Check location service enabled
      final serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return left(const LocationFailure('Location services are disabled.'));
      }

      // 2. Check / request permission
      var permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          return left(const LocationFailure('Location permission denied.'));
        }
      }
      if (permission == geo.LocationPermission.deniedForever) {
        return left(
          const LocationFailure(
            'Location permission permanently denied. Enable it in settings.',
          ),
        );
      }

      // 3. Get current position
      final position = await geo.Geolocator.getCurrentPosition(
        locationSettings: const geo.LocationSettings(
          accuracy: geo.LocationAccuracy.low,
        ),
      );

      // 4. Reverse geocode to get city name in Arabic
      String locationName = '';
      try {
        await geocoding.setLocaleIdentifier('ar');
        final placemarks = await geocoding.placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          locationName =
              placemarks.first.locality ??
              placemarks.first.subAdministrativeArea ??
              '';
        }
      } catch (_) {
        // Silently fail — location name is a nice-to-have
      }

      // 5. Calculate prayer times using Umm al-Qura (Saudi Arabia)
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.umm_al_qura.getParameters();
      params.madhab = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(coordinates, params);

      return right(
        PrayerTimesModel(
          fajr: prayerTimes.fajr,
          sunrise: prayerTimes.sunrise,
          dhuhr: prayerTimes.dhuhr,
          asr: prayerTimes.asr,
          maghrib: prayerTimes.maghrib,
          isha: prayerTimes.isha,
          currentPrayer: prayerTimes.currentPrayer(),
          nextPrayer: prayerTimes.nextPrayer(),
          locationName: locationName,
        ),
      );
    } catch (e) {
      return left(UnknownFailure('Failed to get prayer times: $e'));
    }
  }
}
