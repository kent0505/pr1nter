import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:pr1nter/core/utils.dart';

import '../../../core/constants.dart';
import '../data/subscription_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _repository;
  late final Adapty _adapty;

  SubscriptionBloc({required SubscriptionRepository repository})
      : _repository = repository,
        super(SubscriptionState()) {
    _adapty = _repository.getAdapty();

    on<CheckSubscription>(_checkSubscription);
    on<ProfileUpdated>(_onProfileUpdated);
    on<UseFree>(_useFree);

    _adapty.didUpdateProfileStream.listen(
      (profile) => add(ProfileUpdated(profile)),
    );
  }

  Future<void> _checkSubscription(
    CheckSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    final profile = await _adapty.getProfile();
    add(ProfileUpdated(profile));
  }

  void _onProfileUpdated(
    ProfileUpdated event,
    Emitter<SubscriptionState> emit,
  ) {
    logger(event.profile.accessLevels);
    logger(event.profile.subscriptions);
    final subscribed = event.profile.accessLevels['premium']?.isActive ?? false;

    emit(state.copyWith(subscribed: subscribed));
  }

  Future<void> _useFree(
    UseFree event,
    Emitter<SubscriptionState> emit,
  ) async {
    final free = _repository.getFree() - 1;
    await _repository.setFree(free);
    emit(state.copyWith(free: free));
  }
}
