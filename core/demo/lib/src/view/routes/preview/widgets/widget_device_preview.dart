part of '../route_preview.dart';

class _WidgetDevicePreview extends StatelessWidget {
  const _WidgetDevicePreview({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  @override
  Widget build(BuildContext context) {
    return device_frame.DeviceFrame(
      device: state._device,
      screen: (switch (state._pluginClient) {
        GsaPluginClient.demo => GsdPlugin.new,
        GsaPluginClient.fitnessTracker => GftPlugin.new,
        GsaPluginClient.froddoB2b => GfbPlugin.new,
        GsaPluginClient.froddoB2c => GfcPlugin.new,
      })(
        theme: state._theme,
        child: ScrollConfiguration(
          behavior: const _TouchScrollBehavior(),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Gsa(),
          ),
        ),
      ),
    );
  }
}
