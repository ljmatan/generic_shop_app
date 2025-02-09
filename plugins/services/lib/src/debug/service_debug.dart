import 'package:generic_shop_app_architecture/gsar.dart';

/// Debugging services used for development purposes.
///
class GsaServiceDebug extends GsaService {
  GsaServiceDebug._();

  static final _instance = GsaServiceDebug._();

  // ignore: public_member_api_docs
  static GsaServiceDebug get instance => _instance() as GsaServiceDebug;

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
