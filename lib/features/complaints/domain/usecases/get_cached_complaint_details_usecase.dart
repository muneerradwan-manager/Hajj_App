import 'package:bawabatelhajj/features/complaints/domain/entities/complaint.dart';
import 'package:bawabatelhajj/features/complaints/domain/repositories/complaints_repository.dart';

class GetCachedComplaintDetailsUseCase {
  const GetCachedComplaintDetailsUseCase(this._repository);

  final ComplaintsRepository _repository;

  Future<Complaint?> call(int id) => _repository.getCachedComplaintDetails(id);
}
