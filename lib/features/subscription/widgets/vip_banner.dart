import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/subscription_bloc.dart';
import '../screens/subscription_screen.dart';

class VipBanner extends StatelessWidget {
  const VipBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 204,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: colors.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 3,
            right: 8,
            child: SvgWidget(Assets.printer3),
          ),
          Positioned(
            top: 26,
            left: 12,
            right: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upgrade to Pro',
                  style: TextStyle(
                    color: colors.tertiary1,
                    fontSize: 32,
                    fontFamily: AppFonts.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Print web pages, calendars, photos, and more — effortlessly',
                  style: TextStyle(
                    color: colors.tertiary1,
                    fontSize: 14,
                    fontFamily: AppFonts.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: colors.tertiary1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Button(
                onPressed: context.read<SubscriptionBloc>().state.subscribed
                    ? null
                    : () {
                        PaywallScreen.open(context);
                      },
                child: Center(
                  child: Text(
                    'Upgrade now',
                    style: TextStyle(
                      color: colors.accent,
                      fontSize: 18,
                      fontFamily: AppFonts.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
