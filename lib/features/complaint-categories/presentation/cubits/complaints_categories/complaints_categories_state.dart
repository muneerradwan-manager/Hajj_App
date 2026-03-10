import 'package:bawabatelhajj/features/complaint-categories/domain/entities/complaint_category.dart';
import 'package:equatable/equatable.dart';

enum ComplaintCategoryStatus { initial, loading, loaded, error }

class ComplaintsCategoriesState extends Equatable {
  final ComplaintCategoryStatus status;
  final List<ComplaintCategory> complaints;
  final String errorMessage;

  const ComplaintsCategoriesState({
    required this.status,
    required this.complaints,
    required this.errorMessage,
  });

  const ComplaintsCategoriesState.initial()
    : status = ComplaintCategoryStatus.initial,
      complaints = const [],
      errorMessage = '';

  int get totalCount => complaints.length;

  ComplaintsCategoriesState copyWith({
    ComplaintCategoryStatus? status,
    List<ComplaintCategory>? complaints,
    String? errorMessage,
  }) {
    return ComplaintsCategoriesState(
      status: status ?? this.status,
      complaints: complaints ?? this.complaints,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, complaints, errorMessage];
}
