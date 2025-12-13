import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';

abstract interface class OnboardRepository {
  const OnboardRepository();

  bool isOnboard();
  Future<void> removeOnboard();
  String getPrinterModel();
  Future<void> savePrinterModel(String model);
}

final class OnboardRepositoryImpl implements OnboardRepository {
  OnboardRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  bool isOnboard() {
    return _prefs.getBool(Keys.onboard) ?? true;
  }

  @override
  Future<void> removeOnboard() async {
    await _prefs.setBool(Keys.onboard, false);
  }

  @override
  String getPrinterModel() {
    return _prefs.getString(Keys.model) ?? '';
  }

  @override
  Future<void> savePrinterModel(String model) async {
    await _prefs.setString(Keys.model, model);
  }
}
