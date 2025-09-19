part of '../service_tracking.dart';

class _GsaServiceTrackingEventEngagement {
  const _GsaServiceTrackingEventEngagement();

  static const observables = <_GsaServiceTrackingEventEngagement>[];

  _GsaServiceTrackingEventEngagement._() {
    observables.add(this);
  }

  /// Records an app open / start event.
  ///
  Future<void> logAppOpen() async {
    for (final observable in observables) {
      await observable.logAppOpen();
    }
  }

  /// Records a sign in / login event.
  ///
  /// A custom [client] value can be forwarded for identifying providers such as Google Oauth.
  ///
  Future<void> logSignIn({
    String? client,
  }) async {
    for (final observable in observables) {
      await observable.logSignIn(
        client: client,
      );
    }
  }

  /// Records a registration event.
  ///
  /// A custom [client] value can be forwarded for identifying providers such as Google Oauth.
  ///
  Future<void> logRegistration({
    String? client,
  }) async {
    for (final observable in observables) {
      await observable.logRegistration(
        client: client,
      );
    }
  }

  /// Records the total app usage time for a runtime session,
  /// alongside any of the screen view records.
  ///
  Future<void> logSession({
    required Duration sessionTime,
    required List<GsaRoute> viewedRoutes,
  }) async {
    for (final observable in observables) {
      await observable.logSession(
        sessionTime: sessionTime,
        viewedRoutes: viewedRoutes,
      );
    }
  }
}

enum _GsaServiceTrackingEventEngagementTypes {
  /// Event invoked on every app open.
  ///
  appOpen,

  /// Event invoked on every login.
  ///
  signIn,

  /// Event invoked on every registration.
  ///
  registration,

  /// Event invoked marking the user session time and screen views.
  ///
  session;

  String get id {
    switch (this) {
      case _GsaServiceTrackingEventEngagementTypes.appOpen:
        return 'app_open';
      case _GsaServiceTrackingEventEngagementTypes.signIn:
        return 'sign_in';
      case _GsaServiceTrackingEventEngagementTypes.registration:
        return 'registration';
      case _GsaServiceTrackingEventEngagementTypes.session:
        return 'session';
    }
  }
}
