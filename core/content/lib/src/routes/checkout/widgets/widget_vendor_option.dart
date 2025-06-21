part of '../route_checkout.dart';

class _WidgetVendorOption extends StatefulWidget {
  const _WidgetVendorOption();

  @override
  State<_WidgetVendorOption> createState() => _WidgetVendorOptionState();
}

class _WidgetVendorOptionState extends State<_WidgetVendorOption> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(51.509364, -0.128928),
            initialZoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
          ],
        ),
      ],
    );
  }
}
