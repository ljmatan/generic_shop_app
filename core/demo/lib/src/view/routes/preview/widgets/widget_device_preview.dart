part of '../route_preview.dart';

class _WidgetDevicePreview extends StatelessWidget {
  const _WidgetDevicePreview({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      trackpadScrollCausesScale: true,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox.expand(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: state._device.screenSize,
              devicePixelRatio: state._device.pixelRatio,
              viewPadding: state._deviceOrientation == Orientation.landscape ? state._device.rotatedSafeAreas : state._device.safeAreas,
              textScaler: GsaPlugin.of(context).theme.textScaler(
                screenSpecs: (
                  scale: 1,
                  width: state._device.screenSize.width,
                ),
              ),
            ),
            child: device_frame.DeviceFrame(
              device: state._device,
              orientation: state._deviceOrientation,
              screen: GsaPluginWrapper(
                plugin: state._plugin,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Gsa(
                    key: Key(
                      state._plugin.client.name,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
