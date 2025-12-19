import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  OnboardBloc() : super(OnboardState()) {
    on<OnboardEvent>(
      (event, emit) => switch (event) {
        ChangeOnboard() => _changeOnboard(event, emit),
      },
    );
  }

  void _changeOnboard(
    ChangeOnboard event,
    Emitter<OnboardState> emit,
  ) async {
    emit(state.copyWith(index: event.index));
  }
}
