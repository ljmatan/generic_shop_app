part of '../plugin.dart';

/// Defines the plugin route configuration.
///
/// Plugin route collection and initial route are defined with this class,
/// as well as any replacements for common routes defined with the `core/content` plugin
///
class GsaPluginRoutes {
  /// Constructs a plugin route collection.
  ///
  GsaPluginRoutes({
    required this.values,
    required this.initialRoute,
    this.replacements,
  });

  /// A collection of routes specific to the plugin implementation.
  ///
  final List<GsaRouteType> values;

  /// App screen specified for display after the splash and user consent screens.
  ///
  final GsaRoute Function(BuildContext context) initialRoute;

  /// Route entries used to replace the generic route implementations.
  ///
  final Iterable<({GsaRouteType original, GsaRoute Function() replacement})>? replacements;
}
