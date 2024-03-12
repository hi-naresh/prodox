import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;
  static const double maxVerticalTranslation = 40.0; // Named constant for clarity

  const NavButton({
    super.key,
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final isCloseToDesired = difference < 1.0 / length;
    // Pre-compute conditional values to simplify the widget tree
    final double verticalTranslation =
    isCloseToDesired ? (1 - length * difference) * maxVerticalTranslation : 0;
    final double currentOpacity = isCloseToDesired ? length * difference : 1.0;

    // Use a more direct approach for conditional rendering to avoid unnecessary transformations
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap(index),
        child: isCloseToDesired
            ? Transform.translate(
          offset: Offset(0, verticalTranslation),
          child: Opacity(opacity: currentOpacity, child: child),
        )
            : child, // Avoid unnecessary transformations if not close to desired position
      ),
    );
  }
}
