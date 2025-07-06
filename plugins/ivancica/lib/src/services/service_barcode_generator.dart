import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:barcode/barcode.dart';

/// Class implementing methods and properties for generating barcode images.
///
class GivServiceBarcodeGenerator extends GsaService {
  GivServiceBarcodeGenerator._();

  static final _instance = GivServiceBarcodeGenerator._();

  /// Globally-accessible class instance.
  ///
  static GivServiceBarcodeGenerator get instance => _instance() as GivServiceBarcodeGenerator;

  /// Generates an SVG representation of Code 128 barcode from the given [data].
  ///
  String generateCode128Svg(String data) {
    final generator = Barcode.code128();
    final code = generator.toSvg(
      data,
      drawText: false,
    );
    return code;
  }
}
