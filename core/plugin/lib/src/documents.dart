part of '../plugin.dart';

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

  /// Legal document specifying the terms and conditions of app usage.
  ///
  final String? termsAndConditions;

  /// Legal document specifying the app's privacy policy.
  ///
  final String? privacyPolicy;

  /// Legal document specifying the app's cookie notice.
  ///
  final String? cookieNotice;

  /// Help and FAQ document for user assistance.
  ///
  final String? helpAndFaq;
}
