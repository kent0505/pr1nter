import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../../printer/screens/printer_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../subscription/bloc/subscription_bloc.dart';
import '../../subscription/data/subscription_repository.dart';
import '../widgets/nav_bar.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routePath = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.read<SubscriptionRepository>().showPaywall();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final index = context.watch<HomeBloc>().state;

    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        logger(state);
      },
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: index,
            children: const [
              SizedBox(),
              PrinterScreen(),
              SettingsScreen(),
            ],
          ),
          bottomNavigationBar: const NavBar(),
        );
      },
    );
  }
}
