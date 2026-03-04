import 'package:equatable/equatable.dart';

import 'package:bawabatelhajj/features/auth/domain/entities/user_profile.dart';

enum MeStatus { initial, loading, loaded, error }

class MeState extends Equatable {
  final MeStatus status;
  final UserProfile? profile;
  final String errorMessage;
  final bool isNetworkError;

  const MeState({
    required this.status,
    this.profile,
    required this.errorMessage,
    required this.isNetworkError,
  });

  const MeState.initial()
    : status = MeStatus.initial,
      profile = null,
      errorMessage = '',
      isNetworkError = false;

  MeState copyWith({
    MeStatus? status,
    UserProfile? profile,
    String? errorMessage,
    bool? isNetworkError,
    bool clearProfile = false,
  }) {
    return MeState(
      status: status ?? this.status,
      profile: clearProfile ? null : (profile ?? this.profile),
      errorMessage: errorMessage ?? this.errorMessage,
      isNetworkError: isNetworkError ?? this.isNetworkError,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage, isNetworkError];
}
