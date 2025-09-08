part of '../plugin.dart';

/// Collection of plugin services.
///
class GsaPluginServices {
  /// Constructs a plugin client collection.
  ///
  GsaPluginServices({
    required this.values,
  });

  /// Collection of services implemented by a client integration.
  ///
  final List<GsaService> values;
}
