import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../bloc/vip_bloc.dart';

class VipScreen extends StatelessWidget {
  const VipScreen({super.key});

  static const routePath = '/VipScreen';

  static Future<void> init() async {
    if (isIOS()) {
      // await Purchases.configure(
      //   PurchasesConfiguration('appl_auTfWPTCdpqGLabMbPQsWcSrpvh'),
      // );
    }
  }

  static bool canOpen(BuildContext context) {
    final state = context.read<VipBloc>().state;
    return isIOS() && state.free <= 0 && !state.isVip;
  }

  static void open(BuildContext context) {
    context.push(VipScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      body: BlocBuilder<VipBloc, VipState>(
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
                  .read<VipBloc>()
                  .add(CheckPurchased(customerInfo: customerInfo));
              context.pop();
            },
            onRestoreCompleted: (customerInfo) {
              context
                  .read<VipBloc>()
                  .add(CheckPurchased(customerInfo: customerInfo));
              context.pop();
            },
            onPurchaseCancelled: () {
              context.pop();
              DialogWidget.show(
                context,
                title: 'Purchase Cancelled',
                buttonTexts: ['OK'],
                buttonColors: [colors.tertiary2],
                onPresseds: [
                  () {
                    context.pop();
                  },
                ],
              );
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
