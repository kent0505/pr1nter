import 'package:flutter/material.dart';

import '../constants.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    this.title = '',
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Center(
      child: Text(
        title.isEmpty ? 'No data' : title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.text,
          fontSize: 16,
          fontFamily: AppFonts.w600,
        ),
      ),
    );
  }
}
