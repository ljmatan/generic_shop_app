/// A mixin that provides wrappers for executing synchronous and asynchronous
/// functions with a consistent API.
///
/// Intended as a base for adding the logging behaviour to method calls.
///
abstract mixin class GsaMethods {
  /// Logs the usage of a method.
  ///
  /// This method can be overridden to implement custom usage logging.
  ///
  /// The optional [current] parameter supplies the stack trace at the point of invocation.
  ///
  void logUsage([StackTrace? current]) {}

  /// Executes a synchronous [function] and returns its result.
  ///
  /// This wrapper can be extended to add logic before or after the call, such as:
  ///
  /// - logging function calls,
  /// - capturing stack traces,
  /// - measuring performance.
  ///
  /// Example:
  ///
  /// ```dart
  /// final result = executeSync(() => 2 + 2);
  /// print(result); // Outputs: 4
  /// ```
  ///
  dynamic executeSync(
    Function function, {
    StackTrace? stackTrace,
  }) {
    logUsage(stackTrace);
    return function();
  }

  /// Executes an asynchronous [function] and returns the result.
  ///
  /// This wrapper can be extended to add logic before or after the call, such as:
  ///
  /// - logging async tasks
  /// - capturing stack traces
  ///
  /// Example:
  ///
  /// ```dart
  /// final result = await executeAsync(() async {
  ///   return await Future(true);
  /// });
  /// print(result); // Outputs: true
  /// ```
  ///
  Future<dynamic> executeAsync(
    Function function, {
    StackTrace? stackTrace,
  }) async {
    logUsage(stackTrace);
    return await function();
  }
}
