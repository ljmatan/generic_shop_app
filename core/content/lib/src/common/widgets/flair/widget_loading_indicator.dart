import 'dart:math' as dart_math;

import 'package:flutter/material.dart';

class GsaWidgetLoadingIndicator extends StatefulWidget {
  const GsaWidgetLoadingIndicator({super.key});

  @override
  State<GsaWidgetLoadingIndicator> createState() {
    return _GsaWidgetLoadingIndicatorState();
  }
}

class _GsaWidgetLoadingIndicatorState extends State<GsaWidgetLoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  double _dotOffset(int index) {
    final progress = (_controller.value + index * 0.2) % 1.0;
    final wave = -10 * dart_math.sin(progress * 2 * dart_math.pi);
    return wave;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              3,
              (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Transform.translate(
                    offset: Offset(0, _dotOffset(i)),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
