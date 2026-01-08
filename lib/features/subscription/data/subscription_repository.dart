import 'package:shared_preferences/shared_preferences.dart';
import 'package:adapty_flutter/adapty_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';

abstract interface class SubscriptionRepository {
  const SubscriptionRepository();

  int getFree();
  Future<void> setFree(int free);
  Future<void> showPaywall();
  Adapty getAdapty();
}

final class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl({
    required SharedPreferences prefs,
    required Adapty adapty,
  })  : _prefs = prefs,
        _adapty = adapty;

  final SharedPreferences _prefs;
  final Adapty _adapty;

  @override
  int getFree() {
    return _prefs.getInt(Keys.free) ?? Constants.free;
  }

  @override
  Future<void> setFree(int free) async {
    await _prefs.setInt(Keys.free, free);
  }

  @override
  Future<void> showPaywall() async {
    try {
      final paywall = await _adapty.getPaywall(placementId: 'test_paywall');
      final view = await AdaptyUI().createPaywallView(paywall: paywall);
      await view.present();
    } catch (e) {
      logger(e);
    }
  }

  @override
  Adapty getAdapty() {
    return _adapty;
  }
}
