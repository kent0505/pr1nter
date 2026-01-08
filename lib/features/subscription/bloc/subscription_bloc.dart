import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adapty_flutter/adapty_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../data/subscription_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _repository;

  AdaptyProfile? _currentProfile;

  SubscriptionBloc({required SubscriptionRepository repository})
      : _repository = repository,
        super(SubscriptionState()) {
    on<SubscriptionEvent>(
      (event, emit) => switch (event) {
        CheckSubscription() => _checkSubscription(event, emit),
        SetStatus() => _setStatus(event, emit),
        UseFree() => _useFree(event, emit),
      },
    );
  }

  void _checkSubscription(
    CheckSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    Adapty().didUpdateProfileStream.listen((profile) {
      _currentProfile = profile;

      logger(profile.subscriptions);

      add(SetStatus());
    });
  }

  void _setStatus(
    SetStatus event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(
      subscribed: _currentProfile?.accessLevels['premium']?.isActive ?? false,
    ));
  }

  void _useFree(
    UseFree event,
    Emitter<SubscriptionState> emit,
  ) async {
    int free = _repository.getFree();
    free = free - 1;
    logger('free = $free');
    await _repository.setFree(free);
    emit(state.copyWith(free: free));
  }
}
