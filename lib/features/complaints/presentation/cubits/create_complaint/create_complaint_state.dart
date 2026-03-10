import 'dart:io';
import 'package:equatable/equatable.dart';

enum CreateComplaintStatus { initial, submitting, success, error }

class CreateComplaintState extends Equatable {
  final CreateComplaintStatus status;

  final int? categoryId;
  final int? kindId;

  final String title;
  final String details;

  final List<File> attachments;

  final String errorMessage;
  final String successMessage;

  const CreateComplaintState({
    required this.status,
    required this.categoryId,
    required this.kindId,
    required this.title,
    required this.details,
    required this.attachments,
    required this.errorMessage,
    required this.successMessage,
  });

  const CreateComplaintState.initial()
      : status = CreateComplaintStatus.initial,
        categoryId = null,
        kindId = null,
        title = '',
        details = '',
        attachments = const [],
        errorMessage = '',
        successMessage = '';

  String? get titleError =>
      title.length > 150 ? 'complaints.create.subject_max_length_error' : null;

  String? get detailsError =>
      details.length > 1000 ? 'complaints.create.details_max_length_error' : null;

  bool get isFormValid =>
      categoryId != null &&
      kindId != null &&
      title.isNotEmpty &&
      title.length <= 150 &&
      details.isNotEmpty &&
      details.length <= 1000;

  bool get isSubmitting => status == CreateComplaintStatus.submitting;
  bool get isSuccess => status == CreateComplaintStatus.success;

  CreateComplaintState copyWith({
    CreateComplaintStatus? status,
    int? categoryId,
    int? kindId,
    String? title,
    String? details,
    List<File>? attachments,
    String? errorMessage,
    String? successMessage,
  }) {
    return CreateComplaintState(
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      kindId: kindId ?? this.kindId,
      title: title ?? this.title,
      details: details ?? this.details,
      attachments: attachments ?? this.attachments,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categoryId,
        kindId,
        title,
        details,
        attachments,
        errorMessage,
        successMessage,
      ];
}
