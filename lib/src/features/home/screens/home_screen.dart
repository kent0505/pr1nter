import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../internet/bloc/internet_bloc.dart';
import '../../internet/widgets/no_internet.dart';
import '../../printer/screens/printer_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../widgets/nav_bar.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routePath = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    final index = context.watch<HomeBloc>().state;

    return Scaffold(
      body: BlocBuilder<InternetBloc, bool>(
        builder: (context, hasConnection) {
          return hasConnection
              ? IndexedStack(
                  index: index,
                  children: const [
                    SizedBox(),
                    PrinterScreen(),
                    SettingsScreen(),
                  ],
                )
              : const NoInternet();
        },
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
