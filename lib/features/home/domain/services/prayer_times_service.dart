import 'package:dartz/dartz.dart';

import 'package:hajj_app/core/errors/failures.dart';
import 'package:hajj_app/features/home/domain/models/prayer_times_model.dart';

abstract class PrayerTimesService {
  Future<Either<Failure, PrayerTimesModel>> getPrayerTimes();
}
