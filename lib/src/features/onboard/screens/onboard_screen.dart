import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/image_widget.dart';
import '../../../core/widgets/main_button.dart';
import 'printer_model_screen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  static const routePath = '/OnboardScreen';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final pageController = PageController();

  int index = 0;

  void onNext() {
    if (index == 2) {
      if (mounted) {
        context.replace(PrinterModelScreen.routePath);
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

    const padding = 254.0;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
            ),
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: ImageWidget(asset: Assets.onboard1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: ImageWidget(asset: Assets.onboard2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: ImageWidget(asset: Assets.onboard3),
                ),
              ],
            ),
          ),
          if (index != 3)
            Container(
              height: padding,
              padding: const EdgeInsets.all(16),
              color: colors.tertiary2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 4,
                        dotColor: colors.text2,
                        activeDotColor: colors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      switch (index) {
                        0 => 'All Your Documents in One Place',
                        1 => 'Import Files Instantly',
                        2 => 'Scan with Your Camera',
                        int() => '',
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: 32,
                        fontFamily: AppFonts.w700,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      switch (index) {
                        0 =>
                          'Organize, view, and manage your files effortlessly from a single home screen.',
                        1 =>
                          'Select documents from your device in just a few taps — fast, simple, and secure.',
                        2 =>
                          'Turn paper documents into high-quality digital files using your phone’s camera.',
                        int() => '',
                      },
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.text3,
                        fontSize: 16,
                        fontFamily: AppFonts.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  MainButton(
                    title: 'Continue',
                    onPressed: onNext,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
