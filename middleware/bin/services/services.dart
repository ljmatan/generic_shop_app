/// Globally-accessible application services,
/// such as cache management, user authentication, input validation, etc.
///
/// All of the service class instances are implemented as subclasses of the [GsamService] object.

library services;

import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// This abstract class defines a globally-accessible service with various Flutter APIs
/// such as currency conversion, caching, logging, user authentication, and internationalization.
///
abstract class GsamService implements GsaaService {
  /// Default [GsamService] constructor, recording this instance to the list of [_observables].
  ///
  GsamService() {
    _observables.add(this);
  }

  /// To allow an subclass instance to be called like a function,
  /// the [call](https://dart.dev/language/callable-objects) method is implemented.
  ///
  @override
  GsaaService call() {
    if (!enabled) throw 'Service $runtimeType not enabled.';
    return this;
  }

  @override
  bool get critical => false;

  @override
  bool get enabled => true;

  @override
  bool get manualInit => false;

  @override
  Future<void> init() async {
    if (!enabled) throw 'Service $runtimeType not enabled.';
  }

  /// Initialises all of the active prioritised services.
  ///
  static Future<void> initAll() async {
    await Future.wait(
      [
        for (final observer in _observables.where((observer) => !observer.manualInit && observer.enabled))
          observer.init().catchError(
            (e) {
              final errorMessage = 'Critical service error: $e';
              if (!'$e'.endsWith('not enabled.')) GsaaServiceLogging.logError(errorMessage);
              if (observer.critical) throw errorMessage;
            },
          ),
      ],
    );
  }

  @override
  Future<void> dispose() async {}

  /// Invokes the [dispose] method on all of the [_observables].
  ///
  static Future<void> disposeAll() async {
    await Future.wait(
      [
        for (final observable in _observables) observable.dispose(),
      ],
    );
  }

  @override
  Future<void> revaluate() async {
    if (!enabled) await dispose();
  }

  /// Invokes the [revaluate] method on all of the [_observables].
  ///
  static Future<void> revaluateAll() async {
    await Future.wait(
      [
        for (final observable in _observables) observable.revaluate(),
      ],
    );
  }

  /// List of active subclassed instances.
  ///
  static final _observables = <GsamService>[];
}
