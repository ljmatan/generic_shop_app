import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

part 'src/api.dart';
part 'src/cache_entries.dart';
part 'src/client.dart';
part 'src/cookies.dart';
part 'src/documents.dart';
part 'src/features.dart';
part 'src/models.dart';
part 'src/routes.dart';
part 'src/services.dart';
part 'src/theme.dart';

/// The application client implementations base service definitions.
///
/// These definitions are required to be implemented in order to comply with the
/// application architecture, which may be based off of various client integrations.
///
abstract class GsaPlugin extends InheritedWidget {
  /// Constructs a new instance of the plugin.
  ///
  const GsaPlugin({
    super.key,
    required super.child,
  });

  @override
  updateShouldNotify(covariant GsaPlugin oldWidget) {
    return false;
  }

  /// Returns the nearest ancestor widget of [GsaPlugin] type.
  ///
  static GsaPlugin of(BuildContext context) {
    GsaPlugin? plugin;
    context.visitAncestorElements(
      (element) {
        if (element.widget is GsaPlugin) {
          plugin = element.widget as GsaPlugin;
          return false;
        }
        return true;
      },
    );
    if (plugin == null) {
      throw Exception(
        'Plugin not found in element tree.',
      );
    }
    return plugin!;
  }

  /// The client specified for this plugin integration.
  ///
  GsaPluginClient get client;

  /// The identifier for the plugin project specified in the `pubspec.yaml` file.
  ///
  String get id;

  /// A collection of functionalities specific to the plugin implementation.
  ///
  /// See [GsaPluginFeatures] for more information.
  ///
  GsaPluginFeatures get features {
    return GsaPluginFeatures();
  }

  /// Collection of data models specific to the plugin implementation.
  ///
  /// See [GsaPluginModels] for more information.
  ///
  GsaPluginModels? get models {
    return null;
  }

  /// A collection of routes specific to the plugin implementation.
  ///
  /// See [GsaPluginRoutes] for more information.
  ///
  GsaPluginRoutes get routes;

  /// Getter method providing information on the used cookies.
  ///
  /// See [GsaPluginCookies] for more information.
  ///
  GsaPluginCookies get enabledCookieTypes;

  /// Cache entries specified for this plugin integration.
  ///
  /// See [GsaPluginCacheEntries] for more information.
  ///
  GsaPluginCacheEntries? get cacheEntries {
    return null;
  }

  /// Services specified for this plugin integration.
  ///
  /// See [GsaPluginServices] for more information.
  ///
  GsaPluginServices? get services {
    return null;
  }

  /// Theme properties specified for this plugin integration.
  ///
  /// See [GsaPluginTheme] for more information.
  ///
  GsaPluginTheme get theme {
    return const GsaPluginTheme();
  }

  /// Collection of translations implemented for this plugin integration.
  ///
  List<List<GsaServiceI18NBaseTranslations>>? get translations {
    return null;
  }

  /// Document resource location specifications.
  ///
  /// See [GsaPluginDocuments] for more information.
  ///
  GsaPluginDocuments? get documentUrls {
    return null;
  }

  /// Widget specified for display above the [MaterialApp.builder.child] object.
  ///
  Widget? get overlayBuilder {
    return null;
  }

  /// API methods specified for this plugin integration.
  ///
  /// See [GsaPluginApi] for more information.
  ///
  GsaPluginApi? get api {
    return null;
  }

  /// Method implemented for managing and initialisation of the plugin-specific implementations.
  ///
  /// This method is called before the [init] method invocation.
  ///
  @mustCallSuper
  Future<void> setupService() async {
    // Define model serialization options.
    if (models != null) {
      for (final model in models!.values) {
        switch (model.reference) {
          case const (GsaModelUser):
            GsaModelUser.originDataFromJson = model.fromJson;
            break;
          case const (GsaModelSaleItem):
            GsaModelSaleItem.originDataFromJson = model.fromJson;
            break;
          case const (GsaModelClient):
            GsaModelClient.originDataFromJson = model.fromJson;
            break;
          default:
            throw Exception(
              'Model type not set up for serialisation: ${model.reference}.',
            );
        }
      }
    }
    // Specify view configuration.
    if (routes.replacements?.isNotEmpty == true) {
      GsaRoutes.replacementRoute = (route) {
        try {
          return routes.replacements!.firstWhere(
            (replacement) {
              return replacement.original == route;
            },
          ).replacement;
        } catch (e) {
          return null;
        }
      };
    }
    // Set translation resources.
    GsaServiceI18N.instance.setPluginTranslatableRouteTypes(
      routes.values.map(
        (route) {
          return route.runtimeType;
        },
      ),
    );
    if (translations != null) {
      GsaServiceI18N.instance.setPluginTranslatedValues(translations!);
    }
    // Register client cookie collection.
    if (cacheEntries != null) {
      GsaServiceCache.instance.registerCacheEntries(
        cacheEntries!.values,
      );
    }
    // Allocate service memory objects.
    if (services != null) {
      for (final service in services!.values) {
        service;
      }
    }
  }

  /// Method implemented for managing and initialisation of the application resources.
  ///
  Future<void> init() async {}
}
