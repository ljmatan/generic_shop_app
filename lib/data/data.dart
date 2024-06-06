/// Library defining the global application data access points.

library data;

export 'src/data_checkout.dart';
export 'src/data_merchant.dart';
export 'src/data_sale_items.dart';
export 'src/data_user.dart';

/// Interface for the globally-accessible application data.
///
abstract class GsaData {
  /// Default [GsaData] constructor,
  /// implementing the observable mechanism on the instance after the object initialisation.
  ///
  GsaData() {
    _observables.add(this);
  }

  /// Active allocated runtime instances.
  ///
  static final _observables = <GsaData>[];

  /// Allocate the instance resources.
  ///
  Future<void> init();

  /// Removes any associated data from the device storage and runtime memory.
  ///
  void clear();

  /// Invokes the [init] method on all of the active subclass instances.
  ///
  static Future<void> initAll() async {
    for (final observable in _observables) {
      await observable.init();
    }
  }

  /// Invokes the [clear] method on each of the active observable instance.
  ///
  static void clearAll() {
    for (final observable in _observables) {
      observable.clear();
    }
  }
}
