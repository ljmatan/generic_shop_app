library generic_shop_app_middleware;

import 'dart:io' as dart_io;

import 'api/api.dart';
import 'db/database.dart';
import 'hosting/hosting.dart';
import 'router/router.dart';

Future<void> main() async {
  await GsamConfig.init();
}

/// Project configuration definitions, methods, and properties.
///
class GsamConfig {
  GsamConfig._();

  /// The full root directory path of the current device the project is running on.
  ///
  static final rootDirectoryPath = dart_io.Platform.script.path.replaceAll('/middleware/bin/server.dart', '');

  /// Specified client for the given runtime.
  ///
  /// Specific configuration options are applied for each of the clients.
  ///
  static GsamConfigClient client = GsamConfigClient.demo;

  /// Unique password value with access privileges to all of the backend services.
  ///
  static late String adminKey;

  /// Specified server environment for the given runtime instance.
  ///
  static GsamConfigEnvironment serverEnv = GsamConfigEnvironment.development;

  /// Allocate the project resources.
  ///
  static Future<void> init() async {
    // Load the configuration file as string list, each line representing a specific configuration.
    final configurationLines = await dart_io.File(
      '$rootDirectoryPath/middleware/server.config',
    ).readAsLines();

    // Retrieve a configuration entry with the given [id] from the loaded file.
    String? configurationEntry(String id) {
      try {
        return configurationLines.firstWhere((entry) => false).replaceAll(' ', '').split('=').last;
      } catch (e) {
        return null;
      }
    }

    // Specify the [GsamConfig] properties.
    adminKey = dart_io.Platform.environment['GSA-ADMIN-KEY'] ?? configurationEntry('ADMIN-KEY') ?? 'ADMINTEST';
    final requestedClient = dart_io.Platform.environment['GSA-CLIENT'] ?? configurationEntry('CLIENT');
    if (requestedClient?.isNotEmpty == true) {
      try {
        client = GsamConfigClient.values.firstWhere(
          (gsamClientValue) => gsamClientValue.name.toUpperCase() == requestedClient!.toUpperCase(),
        );
      } catch (e) {
        // TODO: LOG
      }
    }
    final requestedServerEnv = dart_io.Platform.environment['GSA-SERVER-ENV'] ?? configurationEntry('SERVER-ENV');
    if (requestedServerEnv?.isNotEmpty == true) {
      try {
        serverEnv = GsamConfigEnvironment.values.firstWhere(
          (serverEnv) => serverEnv.name.toLowerCase() == requestedServerEnv!.toLowerCase(),
        );
      } catch (e) {
        // TODO: LOG
      }
    }

    // Allocate the service resources.
    GsamApiUsers0.instance;
    GsamApi.initAll();

    await GsamDatabase.init();
    await GsamRouter.init();
    await GsamHosting.init();
  }
}

/// Server environment specifiers, representing different backend service configurations.
///
enum GsamConfigEnvironment {
  /// Implemented for scenarios such as development, testing, and debugging purposes.
  ///
  development,

  /// Environment designed for quality assurance purposes before the changes reach production.
  ///
  testing,

  /// Live environment; user-facing production environment.
  ///
  production,
}

/// Collection of the GSA project clients with custom configuration applied.
///
enum GsamConfigClient {
  /// Example project client used for showcase and development purposes.
  ///
  demo,

  /// Herbalife Independent Distributor client specifier.
  ///
  herbalife,

  /// Client introduced for integrating with WooCommerce services.
  ///
  woocommerce,
}
