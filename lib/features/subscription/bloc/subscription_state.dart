part of 'subscription_bloc.dart';

final class SubscriptionState {
  final bool loading;
  final bool subscribed;
  final int freeDoc;
  final int freeScan;

  SubscriptionState({
    this.loading = true,
    this.subscribed = false,
    this.freeDoc = Constants.freeDoc,
    this.freeScan = Constants.freeScan,
  });

  SubscriptionState copyWith({
    bool? loading,
    bool? subscribed,
    int? freeDoc,
    int? freeScan,
  }) {
    return SubscriptionState(
      loading: loading ?? this.loading,
      subscribed: subscribed ?? this.subscribed,
      freeDoc: freeDoc ?? this.freeDoc,
      freeScan: freeScan ?? this.freeScan,
    );
  }
}
