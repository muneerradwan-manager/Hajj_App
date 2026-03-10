import 'package:bawabatelhajj/features/complaint-categories/domain/entities/complaint_category.dart';
import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';

abstract class ComplaintCategoriesRepository {
  Future<Either<Failure, List<ComplaintCategory>>> getAllComplaintCategories();
}
