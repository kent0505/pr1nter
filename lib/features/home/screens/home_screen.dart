import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../printer/models/preview.dart';
import '../../printer/screens/preview_screen.dart';
import '../../printer/screens/printer_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../sharing/bloc/sharing_bloc.dart';
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

    return BlocListener<SharingBloc, SharingState>(
      listener: (context, state) {
        if (state is ShareLoaded) {
          context.push(
            PreviewScreen.routePath,
            extra: Preview(files: state.files),
          );
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: index,
          children: const [
            SizedBox(),
            PrinterScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}
