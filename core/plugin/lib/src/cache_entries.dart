part of '../plugin.dart';

/// A collection of cache entries specific to the plugin implementation.
///
class GsaPluginCacheEntries {
  /// Cache entry values implemented for plugin integration.
  ///
  GsaPluginCacheEntries({
    required this.values,
  });

  /// Collection of [GsaServiceCacheValue] entries specified by the plugin client.
  ///
  final List<GsaServiceCacheValue> values;
}
