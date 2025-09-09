part of '../../route_preview.dart';

class _WidgetMenuSectionDevice extends StatelessWidget {
  const _WidgetMenuSectionDevice({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  @override
  Widget build(BuildContext context) {
    return _WidgetMenuSection(
      label: 'Device',
      description: 'Operating system and device model options.',
      initiallyExpanded: true,
      children: [
        GsaWidgetDropdownMenu<TargetPlatform>(
          labelText: 'Platform',
          enableFilter: false,
          enableSearch: false,
          dropdownMenuEntries: [
            for (final platform in state._platforms)
              DropdownMenuEntry(
                label: platform.name,
                value: platform,
              ),
          ],
          initialSelection: state._platform,
          onSelected: (value) {
            if (value == null) {
              throw Exception(
                'Target platform value must not be null.',
              );
            }
            state._setPlatform(value);
          },
        ),
        const SizedBox(height: 20),
        GsaWidgetDropdownMenu<device_frame.DeviceInfo>(
          labelText: 'Model',
          enableFilter: false,
          enableSearch: false,
          dropdownMenuEntries: [
            for (final device in device_frame.Devices.all.where(
              (device) {
                return device.identifier.platform == state._platform;
              },
            ))
              DropdownMenuEntry(
                label: device.name,
                value: device,
              ),
          ],
          initialSelection: state._device,
          width: MediaQuery.of(context).size.width * .25 - 40,
          onSelected: (value) {
            if (value == null) {
              throw Exception(
                'Device value must not be null.',
              );
            }
            state._device = value;
            state.rebuild();
          },
        ),
      ],
    );
  }
}
