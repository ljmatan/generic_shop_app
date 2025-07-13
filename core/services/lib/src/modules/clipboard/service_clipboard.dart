import 'package:flutter/services.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Utility methods for interacting with the system's clipboard.
///
class GsaServiceClipboard extends GsaService {
  GsaServiceClipboard._();

  static final _instance = GsaServiceClipboard._();

  /// Globally-accessible class instance.
  ///
  static GsaServiceClipboard get instance => _instance() as GsaServiceClipboard;

  /// Stores the given clipboard [text] data to the clipboard.
  ///
  Future<void> copyToClipboard(
    String text, {
    bool showConfirmation = true,
  }) async {
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    if (showConfirmation) {
      const GsaWidgetOverlayAlert(
        'Copied to clipboard.',
      ).openDialog();
    }
  }
}
