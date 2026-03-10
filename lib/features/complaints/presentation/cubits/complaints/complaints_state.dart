import 'package:equatable/equatable.dart';

import 'package:bawabatelhajj/features/complaints/domain/entities/complaint.dart';

enum ComplaintsStatus { initial, loading, loaded, error }

class ComplaintsState extends Equatable {
  final ComplaintsStatus status;
  final List<Complaint> complaints;
  final String errorMessage;
  final bool isRefreshing;

  const ComplaintsState({
    required this.status,
    required this.complaints,
    required this.errorMessage,
    required this.isRefreshing,
  });

  const ComplaintsState.initial()
    : status = ComplaintsStatus.initial,
      complaints = const [],
      errorMessage = '',
      isRefreshing = false;

  int get totalCount => complaints.length;
  int get pendingCount =>
      complaints.where((c) => c.statusType == ComplaintStatusType.pending).length;
  int get inReviewCount =>
      complaints.where((c) => c.statusType == ComplaintStatusType.inReview).length;
  int get resolvedCount =>
      complaints.where((c) => c.statusType == ComplaintStatusType.resolved).length;

  ComplaintsState copyWith({
    ComplaintsStatus? status,
    List<Complaint>? complaints,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return ComplaintsState(
      status: status ?? this.status,
      complaints: complaints ?? this.complaints,
      errorMessage: errorMessage ?? this.errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [status, complaints, errorMessage, isRefreshing];
}
