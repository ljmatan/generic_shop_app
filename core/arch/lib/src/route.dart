import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_content/content.dart';

/// Type identifier for the [GsaRoute] objects.
///
/// The class can be implemented with [Enum] types so that route structure is always valid:
///
/// ```dart
/// enum ExampleRouteEnum implements GsaRouteType {
///   example;
///
///   @override
///   Type get routeType {
///     switch (this) {
///       case ExampleRouteEnum.example:
///         return ExampleRouteType;
///     }
///   }
///
///   @override
///   String get routeId {
///     switch (this) {
///       case ExampleRouteEnum.example:
///         return 'example-route';
///     }
///   }
///
///   @override
///   String get displayName {
///     switch (this) {
///       case ExampleRouteEnum.example:
///         return 'Example Route';
///     }
///   }
/// }
/// ```
///
abstract class GsaRouteType {
  /// Instantiable route widget representation.
  ///
  GsaRoute Function([dynamic args]) get widget;

  /// Specified route for this type.
  ///
  Type get routeRuntimeType;

  /// Route prefix used with [routeId].
  ///
  String? get routeIdPrefix;

  /// Route identifier used with named routes, URL path identifiers, etc.
  ///
  String get routeId;

  /// Human-readable route display name.
  ///
  String get displayName;
}

/// Interface for the application navigation targets implemented with [MaterialPageRoute].
///
abstract class GsaRoute extends StatefulWidget {
  /// Default widget constructor with [key] parameter definition.
  ///
  const GsaRoute({super.key});

  /// The defined type of any subclass instance.
  ///
  GsaRouteType get routeType;

  /// Route identifier used with named routes, URL path identifiers, etc.
  ///
  /// Derived from [routeType], but can be overridden within subclass instances.
  ///
  String get routeId {
    return routeType.routeId;
  }

  /// Human-readable route display name.
  ///
  /// Derived from [routeType], but can be overridden within subclass instances.
  ///
  String get displayName {
    return routeType.displayName;
  }

  /// Whether the route is enabled for client display.
  ///
  bool get enabled {
    return true;
  }

  /// Property defining if child widget values are to be translated.
  ///
  bool get translatable {
    return true;
  }

  /// Collection of [GsaRouteState] subclass instances or [State] object references.
  ///
  static final observables = <GsaRouteState>[];

  /// Currently-active route state object.
  ///
  /// Returns `null` if the route is not active.
  ///
  /// The method is provided with a [GsaRouteState] subclass as a [T] parameter:
  ///
  /// ```dart
  /// GsaRoute.state<GsaRouteStateExample>().exampleMethod();
  /// ```
  ///
  static T? state<T>() {
    return observables.firstWhereOrNull(
      (observable) {
        return observable.runtimeType == T;
      },
    ) as T?;
  }

  /// Invokes the [setState] method in all of the [GsaRouteState] subclass instances.
  ///
  static void rebuildAll() {
    for (final observer in observables) {
      observer.rebuild();
    }
  }

  /// Currently visible route state instance.
  ///
  static GsaRouteState<GsaRoute> get presenting => observables.last;

  /// Object holding the state of the [Navigator] widget.
  ///
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Object holding the state of the [Navigator] widget,
  /// assigned as a replacement for the default [navigatorKey], with [push] method usage.
  ///
  /// This value is set by the `core/demo` project in order to enable navigation
  /// within the device preview module.
  ///
  static GlobalKey<NavigatorState>? navigatorKeyOverride;

  /// The build context in which the widget with this key builds.
  ///
  static BuildContext? get navigatorContext {
    return (navigatorKeyOverride ?? navigatorKey).currentContext;
  }

  /// Navigates to the given route using the [Navigator.push] method.
  ///
  Future<dynamic> push({
    BuildContext? context,
    bool replacement = false,
  }) async {
    context ??= (navigatorKeyOverride ?? navigatorKey).currentContext;
    if (context != null) {
      final route = MaterialPageRoute<void>(
        builder: (BuildContext context) => this,
        settings: RouteSettings(
          name: routeId,
        ),
      );
      return replacement
          ? await Navigator.of(context).pushAndRemoveUntil(
              route,
              (_) => false,
            )
          : await Navigator.of(context).push(
              route,
            );
    }
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
abstract class GsaRouteState<T extends GsaRoute> extends State<T> with RouteAware, WidgetsBindingObserver, GsaMethods {
  /// Currently visible route state instance.
  ///
  GsaRouteState<GsaRoute> get presentingRoute => GsaRoute.presenting;

  /// Invokes the [setState] method in all of the [GsaRouteState] subclass instances.
  ///
  void rebuildAllRoutes() => GsaRoute.rebuildAll();

  /// Avoids the @protected annotation on the [setState] method with public method access.
  ///
  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

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
            child: GsaWidgetLoadingIndicator(),
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
        label: widget.routeType.displayName,
        primaryColor: Theme.of(context).primaryColor.value,
      ),
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
  Timer? _timeViewedTimer;

  /// Controller aimed at integrating with the main scrollable app view for additional input support.
  ///
  final mainScrollController = ScrollController();

  final _listeners = <({
    String id,
    GsaData notifier,
  })>[];

  /// Registers a listener with a given [GsaData] [notifier] with the specified [callback].
  ///
  void subscribe(
    List<
            ({
              GsaData notifier,
              Function? callback,
            })>
        subscriptionEntries,
  ) {
    for (final subscriptionEntry in subscriptionEntries) {
      final listenerId = subscriptionEntry.notifier.addListener(
        () async {
          if (subscriptionEntry.callback != null) {
            await subscriptionEntry.callback!();
          }
          rebuild();
        },
      );
      _listeners.add(
        (
          id: listenerId,
          notifier: subscriptionEntry.notifier,
        ),
      );
    }
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    GsaRoute.observables.add(this);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final modalRoute = ModalRoute.of(context);
      if (modalRoute != null) {
        GsaRoute.navigatorObserver.subscribe(this, modalRoute);
      }
      _visible = true;
      const duration = Duration(seconds: 1);
      _timeViewedTimer = Timer.periodic(duration, (_) {
        if (_visible) _timeViewed += duration;
      });
    });
  }

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The method is implemented in place of the [build] method.
  ///
  Widget view(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return Scaffold(
        body: Center(
          child: GsaWidgetError(
            'This route is not enabled for display.',
            retry: Navigator.of(context).canPop() ? () => Navigator.pop(context) : null,
            retryLabel: Navigator.of(context).canPop() ? 'Go Back' : null,
          ),
        ),
      );
    }
    if (GsaRoutes.replacementRoute != null) {
      final replacementRoute = GsaRoutes.replacementRoute!(widget.routeType);
      if (replacementRoute != null) {
        return replacementRoute()!;
      }
    }
    return view(context);
  }

  @override
  @mustCallSuper
  void dispose() {
    _timeViewedTimer?.cancel();
    mainScrollController.dispose();
    for (final listener in _listeners) {
      listener.notifier.removeListener(id: listener.id);
    }
    GsaRoute.navigatorObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    GsaRoute.observables.remove(this);
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

  @override
  void logUsage([StackTrace? current]) {
    GsaServiceLogging.instance.logMethod();
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
