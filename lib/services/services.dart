/// Globally-accessible application services,
/// such as cache management, user authentication, input validation, etc.
///
/// All of the service class instances are implemented as subclasses of the [GsaService] object.

library services;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

import 'package:generic_shop_app/services/services.dart';

export 'src/app_tracking_transparency/service_app_tracking_transparency.dart';
export 'src/auth/service_auth.dart';
export 'src/bookmarks/service_bookmarks.dart';
export 'src/cache/service_cache.dart';
export 'src/consent/service_consent.dart';
export 'src/location/service_location.dart';
export 'src/logging/service_logging.dart';
export 'src/navigator/service_navigator.dart';
export 'src/tracking/service_tracking.dart';
export 'src/url_launcher/service_url_launcher.dart';

/// This abstract class defines a globally-accessible service with various Flutter APIs
/// such as currency conversion, caching, logging, user authentication, and internationalization.
///
abstract class GsaService implements GsaaService {
  /// Default [GsaService] constructor, recording this instance to the list of [_observables].
  ///
  GsaService() {
    _observables.add(this);
  }

  /// To allow a subclass instance to be called like a function,
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

  @mustCallSuper
  @override
  Future<void> init() async {
    if (!enabled) throw 'Service $runtimeType not enabled.';
  }

  /// Initialises all of the active prioritised services.
  ///
  static Future<void> initAll() async {
    // In order to control the runtime memory allocation,
    // below code is required to ensure the below instances are initialised.
    for (final service in <dynamic>{
      () => GsaServiceCache.instance,
      () => GsaServiceAppTrackingTransparency.instance,
      () => GsaServiceAuth.instance,
      () => GsaServiceBookmarks.instance,
      () => GsaServiceConsent.instance,
      () => GsaServiceLocation.instance,
      () => GsaServiceLogging.instance,
      () => GsaServiceNavigator.instance,
      () => GsaServiceTracking.instance,
      () => GsaServiceUrlLauncher.instance,
    }) {
      try {
        service();
      } catch (e) {
        // Service is disabled.
      }
    }
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

  @mustCallSuper
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
  static final _observables = <GsaService>[];
}
