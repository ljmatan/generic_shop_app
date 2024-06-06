import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app/services/services.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:flutter_web_plugins/url_strategy.dart' as url_strategy;
import 'package:universal_html/html.dart' as html;

/// Designed for application navigation services implementation and handling.
///
class GsaServiceNavigator extends GsaService {
  GsaServiceNavigator._();

  static final _instance = GsaServiceNavigator._();

  // ignore: public_member_api_docs
  static GsaServiceNavigator get instance => _instance() as GsaServiceNavigator;

  @override
  Future<void> init() async {
    await super.init();
    if (kIsWeb) url_strategy.usePathUrlStrategy();
  }

  /// The [NavigatorState] type key applied to the parent [MaterialApp] widget.
  ///
  /// [BuildContext] can be obtained from this property, for example, for navigation.
  ///
  final navigatorStateKey = GlobalKey<NavigatorState>();

  /// Current navigator widget state context.
  ///
  BuildContext get context {
    if (navigatorStateKey.currentContext == null) throw 'Navigator key context is null.';
    return navigatorStateKey.currentContext!;
  }

  /// Navigation observer for [RouteAware] subscription.
  ///
  final navigatorObserver = RouteObserver<ModalRoute>();

  /// Currently visible route, represented by a [GsaRoute] subclass instance [runtimeType].
  ///
  Type get presenting => GsaRoute.presenting;

  /// Sets the application switcher description and the browser tab title.
  ///
  void setTitle(String title) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: title,
        primaryColor: Theme.of(context).primaryColor.value,
      ),
    );
  }

  /// Sets the browser URL path for web targets.
  ///
  void setUrlPath(String title, String path) {
    setTitle(title);
    if (kIsWeb) html.window.history.replaceState(null, title, '/$path');
  }
}
