part of '../service_tracking.dart';

class _GsaServiceTrackingEventEngagement {
  const _GsaServiceTrackingEventEngagement._();

  /// Records an app open / start event.
  ///
  /// If this is the first app open on installation,
  /// [isFirstAppOpen] parameter should be provided as `true`.
  ///
  Future<void> logAppOpen({
    bool isFirstAppOpen = false,
  }) async {
    await GsaServiceTracking.instance._logEvent(
      GsaServiceTrackingModelEvent(
        id: isFirstAppOpen ? _GsaServiceTrackingEventEngagementTypes.firstAppOpen.id : _GsaServiceTrackingEventEngagementTypes.appOpen.id,
      ),
    );
  }

  /// Records a sign in / login event.
  ///
  /// A custom [client] value can be forwarded for identifying providers such as Google Oauth.
  ///
  Future<void> logSignIn({
    String? client,
  }) async {
    await GsaServiceTracking.instance._logEvent(
      GsaServiceTrackingModelEvent(
        id: _GsaServiceTrackingEventEngagementTypes.signIn.id,
        properties: client == null
            ? null
            : {
                'client': client,
              },
      ),
    );
  }

  /// Records a registration event.
  ///
  /// A custom [client] value can be forwarded for identifying providers such as Google Oauth.
  ///
  Future<void> logRegistration({
    String? client,
  }) async {
    await GsaServiceTracking.instance._logEvent(
      GsaServiceTrackingModelEvent(
        id: _GsaServiceTrackingEventEngagementTypes.registration.id,
        properties: client == null
            ? null
            : {
                'client': client,
              },
      ),
    );
  }

  /// Records the total app usage time for a runtime session,
  /// alongside any of the screen view records.
  ///
  Future<void> logSession({
    required Duration sessionTime,
    required List<GsaRoute> viewedRoutes,
  }) async {
    await GsaServiceTracking.instance._logEvent(
      GsaServiceTrackingModelEvent(
        id: _GsaServiceTrackingEventEngagementTypes.session.id,
        properties: {
          'timeInMilliseconds': sessionTime.inMilliseconds.toString(),
          'screenViews': jsonEncode(
            viewedRoutes.map(
              (route) {
                return route.displayName;
              },
            ).toList(),
          ),
        },
      ),
    );
  }
}

enum _GsaServiceTrackingEventEngagementTypes {
  /// Event invoked on first app open.
  ///
  firstAppOpen,

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
      case _GsaServiceTrackingEventEngagementTypes.firstAppOpen:
        return 'first_app_open';
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
