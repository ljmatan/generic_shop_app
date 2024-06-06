import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// Debugging services used for development purposes.
///
class GsaaServiceDebug extends GsaaService {
  GsaaServiceDebug._();

  static final _instance = GsaaServiceDebug._();

  // ignore: public_member_api_docs
  static GsaaServiceDebug get instance => _instance() as GsaaServiceDebug;

  /// Returns the information on the caller frame stack trace.
  ///
  ({
    DateTime time,
    String? className,
    String? package,
    String? method,
    List<StackTrace> callerFrames,
  }) getStackTrace([int level = 3]) {
    // Get current stack trace info.
    final trace = StackTrace.current;
    return (
      // TODO: Fix
      time: DateTime.now(),
      className: null,
      package: null,
      method: null,
      callerFrames: [],
      // className: stackFrame?.className,
      // package: stackFrame?.package,
      // method: stackFrame?.method,
      // callerFrames: callerFrames,
    );
  }
}
