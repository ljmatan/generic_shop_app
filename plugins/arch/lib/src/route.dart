import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:universal_html/html.dart' as html;

/// Interface for the application navigation targets implemented with [MaterialPageRoute].
///
abstract class GsarRoute extends StatefulWidget {
  /// Default widget constructor with [key] parameter definition.
  ///
  const GsarRoute({super.key});

  /// Whether the route is enabled for client display.
  ///
  bool get enabled => true;

  /// Route identifier compatible as, for example, URL path.
  ///
  String get routeId;

  /// Route display name.
  ///
  String get displayName;

  /// Collection of [GsarRouteState] subclass instances or [State] object references.
  ///
  static final _observables = <GsarRouteState>[];

  /// Invokes the [setState] method in all of the [GsarRouteState] subclass instances.
  ///
  static void rebuildAll() {
    for (final observer in _observables) {
      observer._rebuild();
    }
  }

  /// Currently visible route state instance.
  ///
  static Type get presenting => _observables.last.runtimeType;

  /// Object holding the state of the [Navigator] widget.
  ///
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigates to the given route using the [Navigator.push] method.
  ///
  Future<dynamic> navigate([
    BuildContext? context,
  ]) async {
    context ??= navigatorKey.currentContext;
    if (context != null) return await Navigator.of(context).pushNamed(routeId);
  }

  /// Route observer informing of any route navigation changes.
  ///
  static final navigatorObserver = RouteObserver();
}

/// The default [State] implementation applied to all of the Route instances.
///
/// [State](https://api.flutter.dev/flutter/widgets/State-class.html) is information that
/// (1) can be read synchronously when the widget is built and
/// (2) might change during the lifetime of the widget.
///
abstract class GsarRouteState<T extends GsarRoute> extends State<T> with RouteAware, WidgetsBindingObserver {
  /// Currently visible route state instance.
  ///
  Type get presentingRoute => GsarRoute.presenting;

  /// Invokes the [setState] method in all of the [GsarRouteState] subclass instances.
  ///
  void rebuildAllRoutes() => GsarRoute.rebuildAll();

  /// Avoids the @protected annotation on the [setState] method with public method access.
  ///
  void _rebuild() => setState(() {});

  /// Runs a given [callback], returning it's result,
  /// blocking user input, and displaying a dialog with an error message in case of an exception.
  ///
  Future<dynamic> runBlocking(Function callback) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      final result = await callback();
      // ignore: use_build_context_synchronously
      if (context.mounted) Navigator.pop(context);
      return result;
    } catch (e) {
      // ignore: use_build_context_synchronously
      if (context.mounted) Navigator.pop(context);
    }
  }

  /// Updates the browser URL path property with defined display name and path.
  ///
  void _setUrlPath() {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: widget.displayName,
        primaryColor: Theme.of(context).primaryColor.toARGB32(),
      ),
    );
    if (kIsWeb) html.window.history.replaceState(null, widget.displayName, '/${widget.routeId}');
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
    GsarRoute._observables.add(this);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GsarRoute.navigatorObserver.subscribe(this, ModalRoute.of(context)!);
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
    GsarRoute.navigatorObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    GsarRoute._observables.remove(this);
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

/// [GsarRoute] extension methods applied to [BuildContext] objects.
///
extension GsarRouteBuildContextExt on BuildContext {
  /// Traverse the build context to find an instance of ancestor of type [GsarRouteState].
  ///
  /// This method can be used to avoid forwarding properties to [GsarRouteState] child widgets.
  ///
  GsarRouteState? get routeState {
    return findAncestorStateOfType<GsarRouteState>();
  }
}
