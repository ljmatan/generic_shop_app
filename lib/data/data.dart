/// Library defining the global application data access points.

library data;

import 'dart:math';

import 'package:flutter/material.dart';

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

  /// Collection of callbacks invoked with the [notifyListeners] method.
  ///
  final _listeners = <(String id, VoidCallback callback)>[];

  /// Records a [VoidCallback] instance to the [_listeners] property for invocation on changes propagated
  /// via [notifyListeners] method.
  ///
  /// The method will return a unique [String] identifier for the newly-added listener.
  ///
  String addListener(VoidCallback value) {
    /// Generates a random, unsecured [String] value to serve as a listener identifier.
    ///
    String generateRandomString(int length) {
      const characters = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      final random = Random();
      return String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => characters.codeUnitAt(random.nextInt(characters.length)),
        ),
      );
    }

    String id = generateRandomString(10);
    do {
      id = generateRandomString(10);
    } while (_listeners.where((listener) => listener.$1 == id).isNotEmpty);
    _listeners.add((id, value));
    return id;
  }

  /// Removes a recorded listener matching by either it's [value] or a custom [id] provided by the [addListener] method.
  ///
  /// Either the [id] or the [callback] parameters are to be forwarded to the method for identifying the listener to be removed.
  ///
  void removeListener({
    String? id,
    VoidCallback? callback,
  }) {
    if (id == null && callback == null) {
      debugPrint('No id or value parameters forwarded.');
      return;
    }
    if (id != null) {
      _listeners.removeWhere((listener) => listener.$1 == id);
    }
    if (callback != null) {
      _listeners.removeWhere((listener) => listener.$2 == callback);
    }
  }

  /// A method used to notify of changes any listener objects added with the [addListener] method.
  ///
  void notifyListeners() async {
    for (final listener in _listeners) {
      listener.$2();
    }
  }

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
