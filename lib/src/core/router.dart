import 'package:go_router/go_router.dart';

import '../features/home/screens/home_screen.dart';
import '../features/onboard/screens/onboard_screen.dart';
import '../features/printer/screens/printables_screen.dart';
import '../features/settings/screens/connect_screen.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/vip/screens/vip_screen.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: OnboardScreen.routePath,
      builder: (context, state) => const OnboardScreen(),
    ),
    GoRoute(
      path: HomeScreen.routePath,
      builder: (context, state) => const HomeScreen(),
    ),

    // printer
    GoRoute(
      path: PrintablesScreen.routePath,
      builder: (context, state) => const PrintablesScreen(),
    ),

    // settings
    GoRoute(
      path: ConnectScreen.routePath,
      builder: (context, state) => const ConnectScreen(),
    ),

    // vip
    GoRoute(
      path: VipScreen.routePath,
      builder: (context, state) => const VipScreen(),
    ),
  ],
);
