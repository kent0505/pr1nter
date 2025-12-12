import 'package:flutter/material.dart';

import '../../home/widgets/home_appbar.dart';
import '../../vip/widgets/vip_icon_button.dart';

class PrinterScreen extends StatelessWidget {
  const PrinterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeAppbar(
          title: 'Printer',
          right: VipIconButton(),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [],
          ),
        ),
      ],
    );
  }
}
