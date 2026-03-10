import 'package:equatable/equatable.dart';

import 'package:bawabatelhajj/features/complaints/domain/entities/complaint.dart';

enum ComplaintsStatus { initial, loading, loaded, error }

class ComplaintsState extends Equatable {
  final ComplaintsStatus status;
  final List<Complaint> complaints;
  final String errorMessage;

  const ComplaintsState({
    required this.status,
    required this.complaints,
    required this.errorMessage,
  });

  const ComplaintsState.initial()
    : status = ComplaintsStatus.initial,
      complaints = const [],
      errorMessage = '';

  int get totalCount => complaints.length;
  int get pendingCount =>
      complaints.where((c) => c.status == 'تم الإرسال').length;

  int get inReviewCount =>
      complaints.where((c) => c.status == 'قيد المراجعة').length;

  int get resolvedCount =>
      complaints.where((c) => c.status == 'تم الرد').length;

  ComplaintsState copyWith({
    ComplaintsStatus? status,
    List<Complaint>? complaints,
    String? errorMessage,
  }) {
    return ComplaintsState(
      status: status ?? this.status,
      complaints: complaints ?? this.complaints,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, complaints, errorMessage];
}
