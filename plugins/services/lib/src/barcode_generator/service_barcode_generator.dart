import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:barcode/barcode.dart';

/// Class implementing methods and properties for generating barcode images.
///
class GsaServiceBarcodeGenerator extends GsaService {
  GsaServiceBarcodeGenerator._();

  static final _instance = GsaServiceBarcodeGenerator._();

  /// Globally-accessible class instance.
  ///
  static GsaServiceBarcodeGenerator get instance => _instance() as GsaServiceBarcodeGenerator;

  /// Generates an SVG representation of Code 128 barcode from the given [data].
  ///
  String generateCode128Svg(String data) {
    final generator = Barcode.code128();
    final code = generator.toSvg(data);
    return code;
  }
}
