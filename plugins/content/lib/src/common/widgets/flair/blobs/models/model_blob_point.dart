part of '../widget_blobs.dart';

class _ModelBlobPoint {
  _ModelBlobPoint({
    required this.angle,
    required this.offset,
    required this.amplitude,
    required this.speed,
  });

  final double angle;

  final double offset;

  final double amplitude;

  final double speed;

  double radius(
    double t,
    double base,
  ) {
    return base + dart_math.sin(t * speed * 2 * dart_math.pi + offset) * amplitude;
  }
}
