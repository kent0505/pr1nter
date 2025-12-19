import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/loading.dart';
import '../../home/screens/home_screen.dart';
import '../../onboard/data/onboard_repository.dart';
import '../../onboard/screens/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          if (context.read<OnboardRepository>().onboard()) {
            context.replace(OnboardScreen.routePath);
          } else {
            context.replace(HomeScreen.routePath);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loading(),
    );
  }
}
