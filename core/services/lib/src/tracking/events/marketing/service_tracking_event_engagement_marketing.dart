part of '../../service_tracking.dart';

class _GsaServiceTrackingEventEngagementMarketing extends _GsaServiceTrackingEventEngagement {
  _GsaServiceTrackingEventEngagementMarketing._() : super._();

  static final _instance = _GsaServiceTrackingEventEngagementMarketing._();

  /// Records an app open / start event.
  ///
  @override
  Future<void> logAppOpen() async {
    await GsaServiceTracking.instance._logEvent(
      GsaServiceTrackingModelEvent.marketing(
        id: _GsaServiceTrackingEventEngagementTypes.appOpen.id,
      ),
    );
  }

  /// Records a sign in / login event.
  ///
  /// A custom [client] value can be forwarded for identifying providers such as Google Oauth.
  ///
  @override
  Future<void> logSignIn({
    String? client,
  }) async {
    await GsaServiceTracking.instance._logEvent(
      GsaServiceTrackingModelEvent.marketing(
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
  @override
  Future<void> logRegistration({
    String? client,
  }) async {
    await GsaServiceTracking.instance._logEvent(
      GsaServiceTrackingModelEvent.marketing(
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
  @override
  Future<void> logSession({
    required Duration sessionTime,
    required List<GsaRoute> viewedRoutes,
  }) async {
    await GsaServiceTracking.instance._logEvent(
      GsaServiceTrackingModelEvent.marketing(
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
