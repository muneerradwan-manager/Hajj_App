import 'package:flutter_bloc/flutter_bloc.dart';

/// A base Cubit class that provides safe emit functionality.
/// Prevents emitting state after the cubit has been closed.
abstract class SafeCubit<State> extends Cubit<State> {
  SafeCubit(super.initialState);

  /// Safely emits a new state only if the cubit is not closed.
  /// This prevents the common "Cannot emit new states after calling close" error.
  void safeEmit(State state) {
    if (!isClosed) {
      emit(state);
    }
  }
}