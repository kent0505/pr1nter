import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/main_button.dart';
import '../bloc/subscription_bloc.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  static const routePath = '/PaywallScreen';

  static Future<void> init() async {
    if (isIOS()) {
      // await Purchases.configure(
      //   PurchasesConfiguration('appl_auTfWPTCdpqGLabMbPQsWcSrpvh'),
      // );
    }
  }

  static bool canOpen(BuildContext context) {
    final state = context.read<SubscriptionBloc>().state;
    return isIOS() && state.free <= 0 && !state.subscribed;
  }

  static void open(BuildContext context) {
    context.push(PaywallScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          if (state.loading || state.offering == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Offering not found',
                    style: TextStyle(
                      color: colors.text,
                      fontSize: 16,
                      fontFamily: AppFonts.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                    title: 'Back',
                    width: Constants.mainButtonWidth,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            );
          }

          return PaywallView(
            offering: state.offering,
            onDismiss: () {
              context.pop();
            },
            onPurchaseCompleted: (customerInfo, storeTransaction) {
              context
                  .read<SubscriptionBloc>()
                  .add(CheckPurchased(customerInfo: customerInfo));
              context.pop();
            },
            onRestoreCompleted: (customerInfo) {
              context
                  .read<SubscriptionBloc>()
                  .add(CheckPurchased(customerInfo: customerInfo));
              context.pop();
            },
            onPurchaseCancelled: () {
              context.pop();
            },
            onPurchaseError: (e) {
              context.pop();
            },
            onRestoreError: (e) {
              context.pop();
            },
          );
        },
      ),
    );
  }
}
