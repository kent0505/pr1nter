import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/field.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../internet/bloc/internet_bloc.dart';
import '../../internet/widgets/no_internet.dart';
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
                    _PreviewWidgets(),
                    Center(child: Text('2')),
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

class _PreviewWidgets extends StatelessWidget {
  const _PreviewWidgets();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 50),
        const MainButton(
          title: 'Disabled button',
        ),
        const SizedBox(height: 10),
        MainButton(
          title: 'Show dialog',
          onPressed: () {
            DialogWidget.show(
              context,
              title: 'Test dialog',
              buttonTexts: [
                'Cancel',
                'OK',
              ],
              buttonColors: [
                Colors.redAccent,
                Colors.greenAccent,
              ],
              onPresseds: [
                () {
                  context.pop();
                },
                () {
                  context.pop();
                }
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        const Field(
          hintText: 'Test',
          fieldType: FieldType.text,
        ),
        const SizedBox(height: 10),
        Field(
          hintText: 'Default',
          fieldType: FieldType.text,
          prefixIcon: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgWidget(
                Assets.settings,
                color: Colors.black,
              ),
            ],
          ),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                onPressed: () {},
                child: const SvgWidget(
                  Assets.star,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          controller: TextEditingController(text: 'Initial value'),
        ),
        const SizedBox(height: 10),
        const Field(
          hintText: 'Multiline',
          fieldType: FieldType.multiline,
        ),
        const SizedBox(height: 10),
        const Field(
          hintText: 'Phone',
          fieldType: FieldType.phone,
        ),
        const SizedBox(height: 10),
        const Field(
          hintText: 'Decimal',
          fieldType: FieldType.decimal,
        ),
        const SizedBox(height: 10),
        const Field(
          hintText: 'Number',
          fieldType: FieldType.number,
        ),
        const SizedBox(height: 10),
        const Field(
          hintText: 'Password',
          fieldType: FieldType.password,
        ),
      ],
    );
  }
}
