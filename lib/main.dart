import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/router.dart';
import 'core/themes.dart';
import 'core/utils.dart';
import 'features/onboard/data/onboard_repository.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/subscription/bloc/subscription_bloc.dart';
import 'features/subscription/data/subscription_repository.dart';

// final colors = Theme.of(context).extension<MyColors>()!;

// adb tcpip 5555 && adb connect 192.168.0.190

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  final adapty = Adapty();
  try {
    await adapty.activate(
      configuration: AdaptyConfiguration(
        apiKey: 'public_live_4SfeqTyU.Ejjofz3L4ib9jFd3hEhz',
      )..withActivateUI(true),
    );
  } catch (e) {
    logger(e);
  }

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardRepository>(
          create: (context) => OnboardRepositoryImpl(prefs: prefs),
        ),
        RepositoryProvider<SubscriptionRepository>(
          create: (context) => SubscriptionRepositoryImpl(
            prefs: prefs,
            adapty: adapty,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(
            create: (context) => SubscriptionBloc(
              repository: context.read<SubscriptionRepository>(),
            )..add(CheckSubscription()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: Themes(isDark: false).theme,
          darkTheme: Themes(isDark: true).theme,
          routerConfig: routerConfig,
        ),
      ),
    ),
  );
}
