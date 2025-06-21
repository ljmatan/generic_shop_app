import 'dart:io' as dart_io;
import 'dart:typed_data' as dart_typed_data;

import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:share_plus/share_plus.dart' as share_plus;

/// User activity Share service.
///
class GsaServiceShare extends GsaService {
  GsaServiceShare._();

  static final _instance = GsaServiceShare._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServiceShare get instance => _instance() as GsaServiceShare;

  /// Compresses a given [value] to a gz directory, storing it to the device memory.
  ///
  Future<
      ({
        dart_io.File file,
        dart_typed_data.Uint8List fileBytes,
      })> compressValue(dart_typed_data.Uint8List value) async {
    final tempDirectory = await path_provider.getTemporaryDirectory();
    final compressedFileName = DateTime.now().toIso8601String() + '.gz';
    final compressedFile = dart_io.File(
      path.join(tempDirectory.path, compressedFileName),
    );
    final compressedFileBytes = dart_io.GZipCodec().encode(value.toList());
    await compressedFile.writeAsBytes(compressedFileBytes);
    return (
      file: compressedFile,
      fileBytes: dart_typed_data.Uint8List.fromList(
        compressedFileBytes,
      ),
    );
  }

  /// Function used for sharing text values with other device applications.
  ///
  Future<void> shareText(String value) async {
    await share_plus.SharePlus.instance.share(
      share_plus.ShareParams(
        text: value,
      ),
    );
  }

  /// Share [file] bytes using the system sghare functionality.
  ///
  Future<void> shareFile(
    dart_typed_data.Uint8List file, {
    String? text,
    bool compressed = true,
  }) async {
    ({
      dart_io.File file,
      dart_typed_data.Uint8List fileBytes,
    })? compressedValue;
    if (compressed) {
      compressedValue = await compressValue(file);
    }
    await share_plus.SharePlus.instance.share(
      share_plus.ShareParams(
        text: text,
        files: compressedValue != null
            ? [
                share_plus.XFile(
                  compressedValue.file.path,
                ),
              ]
            : [
                share_plus.XFile.fromData(
                  file,
                ),
              ],
      ),
    );
  }
}
