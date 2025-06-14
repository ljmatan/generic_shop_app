part of '../route_preview.dart';

class _TouchScrollBehavior extends MaterialScrollBehavior {
  const _TouchScrollBehavior();

  @override
  Set<dart_ui.PointerDeviceKind> get dragDevices => {
        dart_ui.PointerDeviceKind.touch,
        dart_ui.PointerDeviceKind.mouse,
      };
}
