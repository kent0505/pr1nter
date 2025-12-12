import 'package:flutter/material.dart';

import '../constants.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    super.key,
    required this.titles,
    required this.pages,
    this.height,
    this.padding,
    this.decoration,
  }) : assert(titles.length == pages.length);

  final List<String> titles;
  final List<Widget> pages;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.titles.length,
      animationDuration: const Duration(milliseconds: Constants.milliseconds),
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        Container(
          height: 44,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: colors.tertiary1,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _tabController.index == _selectedIndex
                  ? colors.tertiary3
                  : null,
            ),
            labelStyle: TextStyle(
              color: colors.accent,
              fontSize: 14,
              fontFamily: AppFonts.w500,
            ),
            unselectedLabelStyle: TextStyle(
              color: colors.text2,
              fontSize: 14,
              fontFamily: AppFonts.w500,
            ),
            tabs: List.generate(
              widget.titles.length,
              (index) {
                return Tab(
                  text: widget.titles[index],
                  height: 36,
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: widget.height,
            decoration: widget.decoration,
            padding: widget.padding,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TabBarView(
                controller: _tabController,
                children: widget.pages,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
