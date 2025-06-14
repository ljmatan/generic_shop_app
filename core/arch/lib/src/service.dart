import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_services/services.dart';

/// This abstract class defines a globally-accessible service with various Flutter APIs
/// such as currency conversion, caching, logging, user authentication, and internationalization.
///
abstract class GsaService {
  /// Default [GsaService] constructor, recording this instance to the list of [_observables].
  ///
  GsaService() {
    _observables.add(this);
    if (!enabled) debugPrint('Service $runtimeType is disabled.');
  }

  /// To allow an subclass instance to be called like a function,
  /// the [call](https://dart.dev/language/callable-objects) method is implemented.
  ///
  GsaService call() {
    if (!enabled) throw 'Service $runtimeType not enabled.';
    return this;
  }

  /// If true, service initialisation fail will render the app inoperable.
  ///
  bool get critical => false;

  /// Getter method for the [_enabled] field defining the service status.
  ///
  bool get enabled => true;

  /// If the value is true, the service [init] method will not be automatically invoked.
  ///
  bool get manualInit => false;

  /// The error message applied in case of a disabled [GsaService].
  ///
  String get _disabledErrorMessage => 'Service $runtimeType not enabled.';

  /// Allocate the service resources.
  ///
  @mustCallSuper
  Future<void> init() async {
    if (!enabled) throw _disabledErrorMessage;
  }

  /// Initialises all of the active prioritised services.
  ///
  static Future<void> initAll() async {
    await Future.wait(
      [
        for (final observer in _observables.where((observer) => !observer.manualInit && observer.enabled))
          (observer).init().catchError(
            (e) {
              final errorMessage = 'Critical service error: $e';
              if (e != observer._disabledErrorMessage) {
                GsaServiceLogging.logError(errorMessage);
              }
              if (observer.critical) throw errorMessage;
            },
          ),
      ],
    );
  }

  /// Disable the service and deallocate any related resources.
  ///
  /// Subclass instances are expected to implement this method by overriding it, if needed.
  ///
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

  /// Checks if the service is [enabled], and invokes the [dispose] method if the service is disabled.
  ///
  /// Used for consent status changes.
  ///
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
  static final _observables = <GsaService>[];
}
