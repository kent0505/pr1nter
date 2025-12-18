import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/img.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/tab_widget.dart';
import '../../vip/widgets/vip_icon_button.dart';
import 'printable_detail_screen.dart';

class PrintablesScreen extends StatelessWidget {
  const PrintablesScreen({super.key});

  static const routePath = '/PrintablesScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'Printables',
        right: VipIconButton(),
      ),
      body: TabWidget(
        titles: const [
          'Gift cards',
          'Calendars',
          'Planners',
        ],
        pages: const [
          _Data(children: [
            _Card(asset: Assets.gift1, svg: true),
            _Card(asset: Assets.gift2, svg: true),
            _Card(asset: Assets.gift3),
            _Card(asset: Assets.gift4),
            _Card(asset: Assets.gift5),
            _Card(asset: Assets.gift6),
          ]),
          _Data(children: [
            _Card(asset: Assets.calendar1),
            _Card(asset: Assets.calendar2),
            _Card(asset: Assets.calendar3),
            _Card(asset: Assets.calendar4),
            _Card(asset: Assets.calendar5),
            _Card(asset: Assets.calendar6),
          ]),
          _Data(children: [
            _Card(asset: Assets.planner1),
            _Card(asset: Assets.planner2),
            _Card(asset: Assets.planner3),
            _Card(asset: Assets.planner4),
            _Card(asset: Assets.planner5),
            _Card(asset: Assets.planner6),
          ]),
        ],
      ),
    );
  }
}

class _Data extends StatelessWidget {
  const _Data({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: children,
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.asset,
    this.svg = false,
  });

  final String asset;
  final bool svg;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        context.push(
          PrintableDetailScreen.routePath,
          extra: asset,
        );
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 2 - 20,
        child: svg ? SvgWidget(asset) : Img(asset: asset),
      ),
    );
  }
}
