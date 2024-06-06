library services;

import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_api/src/services/src/debug/service_debug.dart';

export 'src/calendar/service_calendar.dart';
export 'src/compress/service_compress.dart';
export 'src/coordinates/service_coordinates.dart';
export 'src/currency/service_currency.dart';
export 'src/encryption/service_encryption.dart';
export 'src/i18n/service_i18n.dart';
export 'src/input_validation/service_input_validation.dart';
export 'src/lints/service_lints.dart';
export 'src/logging/service_logging.dart';
export 'src/mock/service_mock.dart';
export 'src/search/service_search.dart';

/// This abstract class defines a globally-accessible service with various Flutter APIs
/// such as currency conversion, caching, logging, user authentication, and internationalization.
///
abstract class GsaaService {
  /// Default [GsaaService] constructor, recording this instance to the list of [_observables].
  ///
  GsaaService() {
    _observables.add(this);
  }

  /// To allow an subclass instance to be called like a function,
  /// the [call](https://dart.dev/language/callable-objects) method is implemented.
  ///
  GsaaService call() {
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

  /// Allocate the service resources.
  ///
  Future<void> init() async {
    if (!enabled) throw 'Service $runtimeType not enabled.';
  }

  /// Initialises all of the active prioritised services.
  ///
  static Future<void> initAll() async {
    // In order to control the runtime memory allocation,
    // below code is required to ensure the below instances are initialised.
    try {
      for (final service in <Function>{
        () => GsaaServiceCalendar.instance,
        () => GsaaServiceCompress.instance,
        () => GsaaServiceCoordinates.instance,
        () => GsaaServiceCurrency.instance,
        () => GsaaServiceDebug.instance,
        () => GsaaServiceEncryption.instance,
        () => GsaaServiceI18N.instance,
        () => GsaaServiceInputValidation.instance,
        () => GsaaServiceLints.instance,
        () => GsaaServiceLogging.instance,
        () => GsaaServiceMock.instance,
        () => GsaaServiceSearch.instance,
      }) {
        service();
      }
    } catch (e) {
      // Service is disabled.
    }
    await Future.wait(
      [
        for (final observer in _observables.where((observer) => !observer.manualInit && observer.enabled))
          observer.init().catchError(
            (e) {
              final errorMessage = 'Critical service error: $e';
              if (!'$e'.endsWith('not enabled.')) {
                // TODO
                // GsaaServiceLogging.logError(errorMessage);
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
  static final _observables = <GsaaService>[];
}
