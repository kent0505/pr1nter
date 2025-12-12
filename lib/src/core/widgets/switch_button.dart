import 'package:flutter/material.dart';

import '../constants.dart';
import 'button.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    super.key,
    required this.isActive,
    required this.onPressed,
  });

  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: Constants.milliseconds,
        ),
        height: 28,
        width: 64,
        decoration: BoxDecoration(
          color: isActive ? colors.accent : colors.tertiary3,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Button(
          onPressed: onPressed,
          minSize: 40,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(
                  milliseconds: Constants.milliseconds,
                ),
                top: 2,
                left: isActive ? 22 : 2,
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: Constants.milliseconds,
                  ),
                  height: 24,
                  width: 40,
                  decoration: BoxDecoration(
                    color: isActive ? colors.bg : colors.text2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
