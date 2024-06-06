library hosting;

import 'package:shelf_static/shelf_static.dart';

import '../router/router.dart';
import '../server.dart';

/// Class defining the web resource hosting features.
///
class GsamHosting {
  const GsamHosting._();

  /// Allocate the hosting service resources.
  ///
  static Future<void> init() async {
    for (final entry in _GsamHostingEntry.values) {
      GsamRouterType.resources.router.mount(
        '/resources/${entry.directory}',
        createStaticHandler(
          '${GsamConfig.rootDirectoryPath}/middleware/store/hosting/${entry.directory}',
          defaultDocument: entry.root,
        ),
      );
    }
  }
}

/// Individual entries for the static web resources made available with the server.
///
enum _GsamHostingEntry {
  /// Paths implemented in webservers so that requests to the servers for well-known services or information are
  /// available at URLs consistent well-known locations across servers.
  ///
  wellKnown,

  /// Folder with publically-available server resources of generic type.
  ///
  public,

  /// Content-management system.
  ///
  cms,

  /// Demo project showcase repository.
  ///
  demo,

  /// Documentation for the API bindings.
  ///
  docsApi,

  /// Documentation for the backend middleware service.
  docsBe,

  /// Documentation for the CMS project.
  ///
  docsCms,

  /// Documentation for the frontend (mobile app) project.
  ///
  docsFe,

  /// User privacy policy resources.
  ///
  privacyPolicy,

  /// User terms and conditions resources.
  ///
  termsAndConditions,
}

extension _GsamHostingEntryExt on _GsamHostingEntry {
  /// Parent directory for this web resource entry.
  ///
  String get directory {
    switch (this) {
      case _GsamHostingEntry.wellKnown:
        return '.well_known';
      case _GsamHostingEntry.public:
        return 'public';
      case _GsamHostingEntry.cms:
        return 'cms';
      case _GsamHostingEntry.demo:
        return 'demo';
      case _GsamHostingEntry.docsApi:
        return 'docs-api';
      case _GsamHostingEntry.docsBe:
        return 'docs-be';
      case _GsamHostingEntry.docsCms:
        return 'docs-cms';
      case _GsamHostingEntry.docsFe:
        return 'docs-fe';
      case _GsamHostingEntry.privacyPolicy:
        return 'privacy-policy';
      case _GsamHostingEntry.termsAndConditions:
        return 'terms-and-conditions';
    }
  }

  /// Root HTML file for the web resource rendering.
  ///
  String get root {
    switch (this) {
      case _GsamHostingEntry.wellKnown:
      case _GsamHostingEntry.public:
      case _GsamHostingEntry.cms:
      case _GsamHostingEntry.demo:
      case _GsamHostingEntry.docsApi:
      case _GsamHostingEntry.docsBe:
      case _GsamHostingEntry.docsCms:
      case _GsamHostingEntry.docsFe:
      case _GsamHostingEntry.privacyPolicy:
      case _GsamHostingEntry.termsAndConditions:
        return 'index.html';
    }
  }
}
