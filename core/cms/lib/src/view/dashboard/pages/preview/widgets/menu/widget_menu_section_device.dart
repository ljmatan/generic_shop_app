part of '../../page_preview.dart';

class _WidgetMenuSectionDevice extends StatefulWidget {
  const _WidgetMenuSectionDevice({
    required this.state,
  });

  final _GscPagePreviewState state;

  @override
  State<_WidgetMenuSectionDevice> createState() => _WidgetMenuSectionDeviceState();
}

class _WidgetMenuSectionDeviceState extends State<_WidgetMenuSectionDevice> {
  void _setPlatform(
    TargetPlatform value,
  ) {
    widget.state._platform = value;
    widget.state._device = device_frame.Devices.all.firstWhere(
      (device) {
        return device.identifier.platform == value;
      },
    );
    widget.state.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _WidgetMenuSection(
      label: 'Device',
      description: 'Operating system and device model options.',
      children: [
        GsaWidgetDropdownMenu<TargetPlatform>(
          labelText: 'Platform',
          enableFilter: false,
          enableSearch: false,
          dropdownMenuEntries: [
            for (final platform in widget.state._platforms)
              DropdownMenuEntry(
                label: platform.name,
                value: platform,
              ),
          ],
          initialSelection: widget.state._platform,
          onSelected: (value) {
            if (value == null) {
              throw Exception(
                'Target platform value must not be null.',
              );
            }
            _setPlatform(value);
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
                return device.identifier.platform == widget.state._platform;
              },
            ))
              DropdownMenuEntry(
                label: device.name,
                value: device,
              ),
          ],
          initialSelection: widget.state._device,
          width: MediaQuery.of(context).size.width * .25 - 40,
          onSelected: (value) {
            if (value == null) {
              throw Exception(
                'Device value must not be null.',
              );
            }
            widget.state._device = value;
            widget.state.setState(() {});
          },
        ),
        const SizedBox(height: 20),
        GsaWidgetDropdownMenu<Orientation>(
          labelText: 'Orientation',
          enableFilter: false,
          enableSearch: false,
          dropdownMenuEntries: [
            for (final orientation in <({String label, Orientation value})>{
              (
                label: 'Portrait',
                value: Orientation.portrait,
              ),
              (
                label: 'Landscape',
                value: Orientation.landscape,
              ),
            })
              DropdownMenuEntry(
                label: orientation.label,
                value: orientation.value,
              ),
          ],
          initialSelection: widget.state._deviceOrientation,
          width: MediaQuery.of(context).size.width * .25 - 40,
          onSelected: (value) {
            if (value == null) {
              throw Exception(
                'Device orientation value must not be null.',
              );
            }
            widget.state._deviceOrientation = value;
            widget.state.setState(() {});
          },
        ),
      ],
    );
  }
}
