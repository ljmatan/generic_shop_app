/// Library defining the navigation target (route) interfaces and their respective implementations.

library routes;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:generic_shop_app/services/services.dart';
import 'package:generic_shop_app/view/src/common/widgets/overlays/widget_overlay_alert.dart';
import 'package:generic_shop_app/view/src/common/widgets/overlays/widget_overlay_content_blocking.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

export 'auth/route_auth.dart';
export 'cart/route_cart.dart';
export 'chat/route_chat.dart';
export 'checkout/route_checkout.dart';
export 'contact/route_merchant_contact.dart';
export 'cookie_policy/route_cookie_policy.dart';
export 'debug/route_debug.dart';
export 'guest_info/route_guest_info.dart';
export 'help/route_help.dart';
export 'licences/route_licences.dart';
export 'login/route_login.dart';
export 'merchant/route_merchant.dart';
export 'onboarding/route_onboarding.dart';
export 'order_status/route_order_status.dart';
export 'privacy_policy/route_privacy_policy.dart';
export 'register/route_register.dart';
export 'sale_item_details/route_sale_item_details.dart';
export 'settings/route_settings.dart';
export 'shop/route_shop.dart';
export 'terms_and_conditions/route_terms_and_conditions.dart';

/// Interface for the application navigation targets implemented with [MaterialPageRoute].
///
abstract class GsaRoute extends StatefulWidget {
  /// Default widget constructor with [key] parameter definition.
  ///
  const GsaRoute({super.key});

  /// Whether the route is enabled for client display.
  ///
  bool get enabled => true;

  /// Route identifier compatible as, for example, URL path.
  ///
  String get routeId;

  /// Route display name.
  ///
  String get displayName;

  /// Collection of [GsaRouteState] subclass instances; [State] object references.
  ///
  static final _observables = <GsaRouteState>[];

  /// Invokes the [setState] method in all of the [GsaRouteState] subclass instances.
  ///
  static void rebuildAll() {
    for (final observer in _observables) {
      observer._rebuild();
    }
  }

  /// Currently visible route state instance.
  ///
  static Type get presenting => _observables.last.runtimeType;
}

/// The default [State] implementation applied to all of the Route instances.
///
/// [State](https://api.flutter.dev/flutter/widgets/State-class.html) is information that
/// (1) can be read synchronously when the widget is built and
/// (2) might change during the lifetime of the widget.
///
abstract class GsaRouteState<T extends GsaRoute> extends State<T> with RouteAware, WidgetsBindingObserver {
  /// Avoids the @protected annotation on the [setState] method with public method access.
  ///
  void _rebuild() => setState(() {});

  /// Runs a given [callback], returning it's result,
  /// blocking user input, and displaying a dialog with an error message in case of an exception.
  ///
  Future<dynamic> runBlocking(Function callback) async {
    try {
      GsaWidgetOverlayContentBlocking.open(context);
      final result = await callback();
      Navigator.pop(context);
      return result;
    } catch (e) {
      Navigator.pop(context);
      GsaWidgetOverlayAlert.open(context, '$e');
      GsaaServiceLogging.logError('$e');
    }
  }

  /// Updates the browser URL path property with defined display name and path.
  ///
  void _setUrlPath() {
    GsaServiceNavigator.instance.setUrlPath(
      widget.displayName.translatedFromType(GsaRoute),
      widget.routeId.translatedFromType(GsaRoute),
    );
  }

  /// The amount of time the user has seen this screen content.
  ///
  Duration _timeViewed = Duration.zero;

  /// Whether the screen content is currently visible to the user.
  ///
  bool _visible = false;

  /// Tracks the amount of time the user has viewed this content.
  ///
  late Timer _timeViewedTimer;

  /// Controller aimed at integrating with the main scrollable app view for additional input support.
  ///
  final mainScrollController = ScrollController();

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    GsaRoute._observables.add(this);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GsaServiceNavigator.instance.navigatorObserver.subscribe(this, ModalRoute.of(context)!);
      _visible = true;
      const duration = Duration(seconds: 1);
      _timeViewedTimer = Timer.periodic(duration, (_) {
        if (_visible) _timeViewed += duration;
      });
    });
  }

  @override
  @mustCallSuper
  void dispose() {
    _timeViewedTimer.cancel();
    mainScrollController.dispose();
    GsaServiceNavigator.instance.navigatorObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    GsaRoute._observables.remove(this);
    super.dispose();
  }

  @override
  @mustCallSuper
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        _visible = false;
        break;
      case AppLifecycleState.resumed:
        _visible = true;
        break;
    }
  }

  @override
  @mustCallSuper
  void didPush() {
    super.didPush();
    _setUrlPath();
  }

  @override
  @mustCallSuper
  void didPushNext() {
    super.didPushNext();
    _visible = false;
  }

  @override
  @mustCallSuper
  void didPop() {
    super.didPop();
  }

  @override
  @mustCallSuper
  void didPopNext() {
    super.didPopNext();
    _setUrlPath();
    _visible = true;
  }
}

/// [GsaRoute] extension methods applied to [BuildContext] objects.
///
extension GsaRouteBuildContextExt on BuildContext {
  /// Traverse the build context to find an instance of ancestor of type [GsaRouteState].
  ///
  /// This method can be used to avoid forwarding properties to [GsaRouteState] child widgets.
  ///
  GsaRouteState? get routeState {
    return findAncestorStateOfType<GsaRouteState>();
  }
}
