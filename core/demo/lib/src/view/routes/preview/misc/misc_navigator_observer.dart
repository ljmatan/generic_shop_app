part of '../route_preview.dart';

class _NavigatorObserver implements NavigatorObserver {
  const _NavigatorObserver(
    this.onNavigatorChange,
  );

  final void Function() onNavigatorChange;

  @override
  void didChangeTop(Route topRoute, Route? previousTopRoute) {
    onNavigatorChange();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    onNavigatorChange();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    onNavigatorChange();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    onNavigatorChange();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    onNavigatorChange();
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    onNavigatorChange();
  }

  @override
  void didStopUserGesture() {
    // Do nothing.
  }

  @override
  NavigatorState? get navigator => null;
}
