import 'dart:async';

import 'package:flutter/material.dart';

import '../constants.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  int _index = 0;
  late Timer _timer;

  void _start() {
    _timer = Timer.periodic(
      const Duration(milliseconds: Constants.milliseconds),
      (timer) {
        setState(() {
          _index < 2 ? _index++ : _index = 0;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Indicator(_index == 0),
          _Indicator(_index == 1),
          _Indicator(_index == 2),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator(this.active);

  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return SizedBox(
      height: 12,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: Constants.milliseconds),
        height: active ? 12 : 8,
        width: active ? 12 : 8,
        margin: EdgeInsets.symmetric(horizontal: active ? 2 : 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.accent,
        ),
      ),
    );
  }
}
