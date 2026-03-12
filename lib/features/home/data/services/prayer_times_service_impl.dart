import 'dart:io' show Platform;

import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geocoding/geocoding.dart' as geocoding;

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/home/domain/models/prayer_times_model.dart';
import 'package:bawabatelhajj/features/home/domain/services/prayer_times_service.dart';

class PrayerTimesServiceImpl implements PrayerTimesService {
  @override
  Future<Either<Failure, PrayerTimesModel>> getPrayerTimes() async {
    try {
      // 1. Check location service enabled
      final serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return left(const LocationFailure('home.help_dialog_location_error'));
      }

      // 2. Check / request permission
      var permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          return left(
            const LocationFailure('home.prayer_permission_denied'),
          );
        }
      }
      if (permission == geo.LocationPermission.deniedForever) {
        return left(
          const LocationFailure(
            'home.prayer_permission_denied_forever',
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
        if (Platform.isAndroid || Platform.isIOS) {
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
        } else {
          // Fallback for desktop: use OpenStreetMap Nominatim API
          final response = await Dio().get(
            'https://nominatim.openstreetmap.org/reverse',
            queryParameters: {
              'lat': position.latitude,
              'lon': position.longitude,
              'format': 'json',
              'accept-language': 'ar',
            },
            options: Options(headers: {'User-Agent': 'bawabatelhajj/1.0'}),
          );
          final address = response.data['address'] as Map<String, dynamic>?;
          if (address != null) {
            locationName =
                (address['city'] ?? address['town'] ?? address['state'] ?? '')
                    as String;
          }
        }
      } catch (_) {
        // Silently fail — location name is a nice-to-have
      }

      // 5. Calculate prayer times using Umm al-Qura (Saudi Arabia)
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.umm_al_qura.getParameters();
      params.madhab = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(coordinates, params);

      // Map non-salah values to the last actual prayer for UI display
      var currentPrayer = prayerTimes.currentPrayer();
      if (currentPrayer == Prayer.sunrise) {
        currentPrayer = Prayer.fajr;
      } else if (currentPrayer == Prayer.none) {
        currentPrayer = Prayer.isha;
      }

      return right(
        PrayerTimesModel(
          fajr: prayerTimes.fajr,
          sunrise: prayerTimes.sunrise,
          dhuhr: prayerTimes.dhuhr,
          asr: prayerTimes.asr,
          maghrib: prayerTimes.maghrib,
          isha: prayerTimes.isha,
          currentPrayer: currentPrayer,
          nextPrayer: prayerTimes.nextPrayer(),
          locationName: locationName,
        ),
      );
    } catch (e) {
      return left(const UnknownFailure('home.prayer_error'));
    }
  }
}
