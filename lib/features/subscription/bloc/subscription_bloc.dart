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
  late final Adapty _adapty;

  SubscriptionBloc({required SubscriptionRepository repository})
      : _repository = repository,
        super(SubscriptionState()) {
    _adapty = _repository.getAdapty();

    on<CheckSubscription>(_checkSubscription);
    on<ProfileUpdated>(_onProfileUpdated);
    on<UseFreeDoc>(_useFreeDoc);
    on<UseFreeScan>(_useFreeScan);

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

    emit(state.copyWith(
      subscribed: subscribed,
      loading: false,
    ));
  }

  Future<void> _useFreeDoc(
    UseFreeDoc event,
    Emitter<SubscriptionState> emit,
  ) async {
    final freeDoc = _repository.getFreeDoc() - 1;
    await _repository.setFree(Keys.freeDoc, freeDoc);
    emit(state.copyWith(freeDoc: freeDoc));
  }

  Future<void> _useFreeScan(
    UseFreeScan event,
    Emitter<SubscriptionState> emit,
  ) async {
    final freeScan = _repository.getFreeScan() - 1;
    await _repository.setFree(Keys.freeScan, freeScan);
    emit(state.copyWith(freeScan: freeScan));
  }
}
