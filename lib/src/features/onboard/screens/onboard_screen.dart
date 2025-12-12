import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/main_button.dart';
import '../../home/screens/home_screen.dart';
import '../data/onboard_repository.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  static const routePath = '/OnboardScreen';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int index = 0;

  final pageController = PageController();

  void onNext() async {
    if (index == 2) {
      await context.read<OnboardRepository>().removeOnboard();
      if (mounted) {
        context.replace(HomeScreen.routePath);
      }
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: Constants.milliseconds),
        curve: Curves.easeInOut,
      );
      setState(() {
        index++;
      });
    }
  }

  void onPageChanged(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 254),
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: const [
                Center(child: Text('1')),
                Center(child: Text('2')),
                Center(child: Text('3')),
              ],
            ),
          ),
          if (index != 3)
            Container(
              height: 254,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              color: colors.tertiary2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 4,
                        dotColor: colors.tertiary2,
                        activeDotColor: colors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    switch (index) {
                      0 => 'Aaa',
                      1 => 'Bbb',
                      2 => 'Ccc',
                      int() => '',
                    },
                    style: TextStyle(
                      color: colors.text,
                      fontSize: 26,
                      fontFamily: AppFonts.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    switch (index) {
                      0 => 'Aaa aaa',
                      1 => 'Bbb bbb',
                      2 => 'Ccc ccc',
                      int() => '',
                    },
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.text2,
                      fontSize: 14,
                      fontFamily: AppFonts.w500,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          Positioned(
            bottom: 44,
            left: 16,
            right: 16,
            child: MainButton(
              title: 'Continue',
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
