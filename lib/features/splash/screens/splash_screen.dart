import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/loading.dart';
import '../../home/screens/home_screen.dart';
import '../../onboard/data/onboard_repository.dart';
import '../../onboard/screens/onboard_screen.dart';
import '../../subscription/bloc/subscription_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (!state.loading) {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              if (context.mounted) {
                if (context.read<OnboardRepository>().onboard()) {
                  context.replace(OnboardScreen.routePath);
                } else {
                  context.replace(HomeScreen.routePath);
                }
              }
            },
          );
        }
      },
      child: const Scaffold(
        body: Loading(),
      ),
    );
  }
}
