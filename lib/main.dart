import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/router.dart';
import 'core/themes.dart';
import 'features/onboard/data/onboard_repository.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/subscription/bloc/subscription_bloc.dart';
import 'features/subscription/data/subscription_repository.dart';
import 'features/subscription/screens/subscription_screen.dart';

// final colors = Theme.of(context).extension<MyColors>()!;

// adb tcpip 5555 && adb connect 192.168.0.190

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await PaywallScreen.init();

  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardRepository>(
          create: (context) => OnboardRepositoryImpl(prefs: prefs),
        ),
        RepositoryProvider<SubscriptionRepository>(
          create: (context) => SubscriptionRepositoryImpl(prefs: prefs),
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
