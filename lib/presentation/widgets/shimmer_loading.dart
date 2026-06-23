import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key, required this.child});
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        final stops = [
          (_animation.value - 0.5).clamp(0.0, 1.0),
          _animation.value.clamp(0.0, 1.0),
          (_animation.value + 0.5).clamp(0.0, 1.0),
        ];
        // Ensure stops are strictly increasing
        final s0 = stops[0];
        final s1 = stops[1] > s0 ? stops[1] : s0 + 0.001;
        final s2 = stops[2] > s1 ? stops[2] : s1 + 0.001;

        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [
              AppColors.surface,
              AppColors.surfaceVariant,
              AppColors.surface,
            ],
            stops: [s0, s1, s2],
          ).createShader(bounds),
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}
