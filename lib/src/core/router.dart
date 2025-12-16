import 'package:go_router/go_router.dart';

import '../features/home/screens/home_screen.dart';
import '../features/onboard/screens/onboard_screen.dart';
import '../features/onboard/screens/printer_model_screen.dart';
import '../features/printer/screens/camera_screen.dart';
import '../features/printer/screens/printable_detail_screen.dart';
import '../features/printer/screens/printables_screen.dart';
import '../features/printer/screens/web_screen.dart';
import '../features/scanner/screens/scanner_screen.dart';
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
      path: HomeScreen.routePath,
      builder: (context, state) => const HomeScreen(),
    ),

    // onboard
    GoRoute(
      path: OnboardScreen.routePath,
      builder: (context, state) => const OnboardScreen(),
    ),
    GoRoute(
      path: PrinterModelScreen.routePath,
      builder: (context, state) => const PrinterModelScreen(),
    ),

    // printer
    GoRoute(
      path: PrintablesScreen.routePath,
      builder: (context, state) => const PrintablesScreen(),
    ),
    GoRoute(
      path: PrintableDetailScreen.routePath,
      builder: (context, state) => PrintableDetailScreen(
        asset: state.extra as String,
      ),
    ),
    GoRoute(
      path: CameraScreen.routePath,
      builder: (context, state) => CameraScreen(
        path: state.extra as String,
      ),
    ),
    GoRoute(
      path: WebScreen.routePath,
      builder: (context, state) => const WebScreen(),
    ),

    // scanner
    GoRoute(
      path: ScannerScreen.routePath,
      builder: (context, state) => ScannerScreen(
        paths: state.extra as List<String>,
      ),
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
