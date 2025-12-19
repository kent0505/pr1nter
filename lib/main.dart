import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/router.dart';
import 'src/core/themes.dart';
import 'src/features/onboard/data/onboard_repository.dart';
import 'src/features/home/bloc/home_bloc.dart';
import 'src/features/vip/bloc/vip_bloc.dart';
import 'src/features/vip/data/vip_repository.dart';
import 'src/features/vip/screens/vip_screen.dart';

// final colors = Theme.of(context).extension<MyColors>()!;

// adb tcpip 5555 && adb connect 192.168.0.190

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await VipScreen.init();

  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardRepository>(
          create: (context) => OnboardRepositoryImpl(prefs: prefs),
        ),
        RepositoryProvider<VipRepository>(
          create: (context) => VipRepositoryImpl(prefs: prefs),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(
            create: (context) => VipBloc(
              repository: context.read<VipRepository>(),
            )..add(CheckVip()),
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
