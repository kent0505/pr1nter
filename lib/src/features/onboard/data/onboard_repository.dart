import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';

abstract interface class OnboardRepository {
  const OnboardRepository();

  bool onboard();
  Future<void> removeOnboard();
  String getPrinter();
  Future<void> savePrinter(String model);
}

final class OnboardRepositoryImpl implements OnboardRepository {
  OnboardRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  bool onboard() {
    return _prefs.getBool(Keys.onboard) ?? true;
  }

  @override
  Future<void> removeOnboard() async {
    await _prefs.setBool(Keys.onboard, false);
  }

  @override
  String getPrinter() {
    return _prefs.getString(Keys.model) ?? '';
  }

  @override
  Future<void> savePrinter(String model) async {
    await _prefs.setString(Keys.model, model);
  }
}
