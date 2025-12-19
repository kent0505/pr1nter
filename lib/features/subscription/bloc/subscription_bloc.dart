import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../data/subscription_repository.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _repository;

  SubscriptionBloc({required SubscriptionRepository repository})
      : _repository = repository,
        super(SubscriptionState()) {
    on<SubscriptionEvent>(
      (event, emit) => switch (event) {
        CheckSubscription() => _checkSubscription(event, emit),
        CheckPurchased() => _checkPurchased(event, emit),
        UseFree() => _useFree(event, emit),
      },
    );
  }

  void _checkSubscription(
    CheckSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (isIOS()) {
      emit(state.copyWith(loading: true));

      try {
        // final customerInfo = await Purchases.getCustomerInfo().timeout(
        //   const Duration(seconds: 10),
        // );

        // final offerings = await Purchases.getOfferings().timeout(
        //   const Duration(seconds: 10),
        // );

        // final offering = offerings.getOffering('paywall_1');

        // emit(state.copyWith(
        //   loading: false,
        //   isSubscription: customerInfo.entitlements.active.isNotEmpty,
        //   offering: offering,
        // ));
      } catch (e) {
        logger('Error checking Subscription: $e');

        emit(state.copyWith(loading: false));
      }
    } else {
      emit(state.copyWith(
        loading: false,
        subscribed: true,
        offering: null,
      ));
    }
  }

  void _checkPurchased(
    CheckPurchased event,
    Emitter<SubscriptionState> emit,
  ) {
    final subscribed = event.customerInfo.entitlements.active.isNotEmpty;
    emit(state.copyWith(subscribed: subscribed));
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
