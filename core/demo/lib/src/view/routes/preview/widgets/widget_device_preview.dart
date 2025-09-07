part of '../route_preview.dart';

class _WidgetDevicePreview extends StatelessWidget {
  const _WidgetDevicePreview({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(
        size: state._device.screenSize,
        devicePixelRatio: state._device.pixelRatio,
        textScaler: GsaTheme.instance.textScaler(
          context,
          state._device.screenSize.width,
        ),
      ),
      child: device_frame.DeviceFrame(
        device: state._device,
        screen: Theme(
          data: state._theme.data,
          child: ScrollConfiguration(
            behavior: const _TouchScrollBehavior(),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Navigator(
                key: state._navigatorKey,
                observers: [
                  state._navigatorObserver,
                ],
                initialRoute: state._routes[state._routeIndex].routeId,
                onDidRemovePage: (page) {
                  state._onNavigatorChange();
                },
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (_) => state._routes
                        .firstWhere(
                          (route) => route.routeId == settings.name,
                        )
                        .widget(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
