import 'package:bawabatelhajj/features/complaint-categories/domain/entities/complaint_category.dart';
import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';

import '../repositories/complaint_categories_repository.dart';

class GetComplaintCategoriesUseCase {
  const GetComplaintCategoriesUseCase(this._repository);

  final ComplaintCategoriesRepository _repository;

  Future<Either<Failure, List<ComplaintCategory>>> call() =>
      _repository.getAllComplaintCategories();
}
