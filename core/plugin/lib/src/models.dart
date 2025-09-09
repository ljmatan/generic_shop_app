part of '../plugin.dart';

/// A collection of model type references specific to the plugin implementation.
///
/// Generic model implementations defined in the `core/api` directory
/// can be set up with custom serialiser methods using this class.
///
class GsaPluginModels {
  /// Model type references implemented for plugin integration.
  ///
  GsaPluginModels({
    required this.values,
  });

  /// Collection of model type references specified by the plugin client.
  ///
  final Iterable<({Type reference, dynamic Function(dynamic) fromJson})> values;
}
