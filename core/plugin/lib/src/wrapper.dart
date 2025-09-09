part of '../plugin.dart';

/// [Widget] wrapper implemented with the current [plugin] integration.
///
/// This enables the [GsaPlugin] instances to be referenced with the [BuildContext] property.
///
class GsaPluginWrapper extends StatelessWidget {
  /// A wrapper class for accessing the defined plugin functionality.
  ///
  /// This class provides an abstraction layer for integrating plugins,
  /// allowing for extensibility and modularity in the application architecture.
  ///
  const GsaPluginWrapper({
    super.key,
    required this.child,
    required this.plugin,
  });

  /// [GsaPlugin] specified with this widget tree implementation.
  ///
  final GsaPlugin plugin;

  /// Property defining this [Widget] descendant.
  ///
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
