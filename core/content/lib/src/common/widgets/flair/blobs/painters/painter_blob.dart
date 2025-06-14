part of '../widget_blobs.dart';

class _PainterBlob extends CustomPainter {
  final List<_ModelBlobPoint> points;
  final double progress;
  final double baseRadius;
  final Color color;

  _PainterBlob({
    required this.points,
    required this.progress,
    required this.baseRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final offsets = points.map((p) {
      final r = p.radius(progress, baseRadius);
      return Offset(
        center.dx + dart_math.cos(p.angle) * r,
        center.dy + dart_math.sin(p.angle) * r,
      );
    }).toList();

    final path = Path();
    if (offsets.isEmpty) return;

    // Create smooth path with cubic Bézier curves
    for (int i = 0; i < offsets.length; i++) {
      final p1 = offsets[i];
      final p2 = offsets[(i + 1) % offsets.length];
      final p3 = offsets[(i + 2) % offsets.length];

      final cp1 = Offset.lerp(p1, p2, 0.5)!;
      final cp2 = Offset.lerp(p2, p3, 0.5)!;

      if (i == 0) path.moveTo(cp1.dx, cp1.dy);
      path.quadraticBezierTo(p2.dx, p2.dy, cp2.dx, cp2.dy);
    }

    path.close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
