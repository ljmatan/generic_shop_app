import 'package:flutter/foundation.dart';
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
    String? fileName,
    String? method,
    int? line,
    List<StackFrame>? callerTraces,
  }) getStackTrace([int level = 3]) {
    try {
      final trace = StackTrace.current;
      final callerFrames = StackFrame.fromStackTrace(trace);
      callerFrames.removeWhere(
        (frame) {
          return frame.className == 'GsaServiceLogging' ||
              <String>{
                'getStackTrace',
                'fromStackTrace',
                'logGeneral',
                'logError',
                '_initialise',
                '_subscribe',
                'asynchronous suspension',
                'handleError',
                '_propagateToListeners',
                '_completeErrorObject',
                '_completeError',
              }.contains(frame.method);
        },
      );
      final stackTrace = callerFrames.isNotEmpty ? callerFrames[0] : null;
      callerFrames.removeAt(0);
      return (
        time: DateTime.now(),
        className: stackTrace?.className,
        package: stackTrace?.package,
        fileName: stackTrace?.source.split('(').last.split(')').first.replaceAll('package:', ''),
        method: stackTrace?.method,
        line: stackTrace?.line,
        callerTraces: callerFrames,
      );
    } catch (e) {
      return (
        time: DateTime.now(),
        className: null,
        package: null,
        fileName: null,
        method: null,
        line: null,
        callerTraces: null,
      );
    }
  }
}
