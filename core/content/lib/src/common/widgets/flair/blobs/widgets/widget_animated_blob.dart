part of '../widget_blobs.dart';

class _WidgetAnimatedBlob extends StatefulWidget {
  const _WidgetAnimatedBlob({
    required this.color,
    required this.pointCount,
    required this.baseRadius,
    required this.duration,
  });

  final Color color;

  final int pointCount;

  final double baseRadius;

  final Duration duration;

  @override
  State<_WidgetAnimatedBlob> createState() {
    return _WidgetAnimatedBlobState();
  }
}

class _WidgetAnimatedBlobState extends State<_WidgetAnimatedBlob> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late List<_ModelBlobPoint> _points;

  @override
  void initState() {
    super.initState();
    final random = dart_math.Random();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      },
    );
    _points = List.generate(
      widget.pointCount,
      (i) {
        final angle = 2 * dart_math.pi * i / widget.pointCount;
        return _ModelBlobPoint(
          angle: angle,
          offset: random.nextDouble() * dart_math.pi * 2,
          amplitude: 10 + random.nextDouble() * 20,
          speed: 0.5 + random.nextDouble(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _PainterBlob(
            points: _points,
            progress: _controller.value,
            baseRadius: widget.baseRadius,
            color: widget.color,
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
