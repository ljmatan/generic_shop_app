part of '../service_tracking.dart';

class _GsaServiceTrackingEventCart {
  const _GsaServiceTrackingEventCart();

  static final observables = <_GsaServiceTrackingEventCart>[];

  _GsaServiceTrackingEventCart._() {
    observables.add(this);
  }

  Future<void> logItemView() async {
    for (final observable in observables) {
      await observable.logItemView();
    }
  }

  Future<void> logItemSearch() async {
    for (final observable in observables) {
      await observable.logItemSearch();
    }
  }

  Future<void> logCategoryView() async {
    for (final observable in observables) {
      await observable.logCategoryView();
    }
  }

  Future<void> logItemBookmark() async {
    for (final observable in observables) {
      await observable.logItemBookmark();
    }
  }

  Future<void> logItemAdd() async {
    for (final observable in observables) {
      await observable.logItemAdd();
    }
  }

  Future<void> logItemRemove() async {
    for (final observable in observables) {
      await observable.logItemRemove();
    }
  }

  Future<void> logItemUpdateAmount() async {
    for (final observable in observables) {
      await observable.logItemUpdateAmount();
    }
  }

  Future<void> logCartViewed() async {
    for (final observable in observables) {
      await observable.logCartViewed();
    }
  }

  Future<void> logCheckoutStarted() async {
    for (final observable in observables) {
      await observable.logCheckoutStarted();
    }
  }

  Future<void> logCheckoutAbandoned() async {
    for (final observable in observables) {
      await observable.logCheckoutAbandoned();
    }
  }

  Future<void> logPaymentInitiated() async {
    for (final observable in observables) {
      await observable.logPaymentInitiated();
    }
  }

  Future<void> logPaymentStatus() async {
    for (final observable in observables) {
      await observable.logPaymentStatus();
    }
  }
}
