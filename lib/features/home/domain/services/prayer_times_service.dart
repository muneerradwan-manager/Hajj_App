import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/home/domain/models/prayer_times_model.dart';

abstract class PrayerTimesService {
  Future<Either<Failure, PrayerTimesModel>> getPrayerTimes();
}
