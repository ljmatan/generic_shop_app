/// Curated collection of plugin document resources.
///
class GsaPluginDocuments {
  /// Document collection constructor, accepting network URLs or asset file paths:
  ///
  /// ```dart
  /// return GsaPluginDocuments(
  ///   termsAndConditions: 'https://www.example.com/terms-and-conditions',
  ///   privacyPolicy: 'packages/$id/assets/documents/privacy-policy.html',
  /// );
  /// ```
  ///
  const GsaPluginDocuments({
    this.termsAndConditions,
    this.privacyPolicy,
    this.cookieNotice,
    this.helpAndFaq,
  });

  final String? termsAndConditions;

  final String? privacyPolicy;

  final String? cookieNotice;

  final String? helpAndFaq;
}
