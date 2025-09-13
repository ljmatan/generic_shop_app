import 'dart:typed_data' as dart_typed_data;

import 'package:generic_shop_app_architecture/arch.dart';
import 'package:file_picker/file_picker.dart' as file_picker;

class GsdServiceOpenFile extends GsaService {
  GsdServiceOpenFile._();

  static final _instance = GsdServiceOpenFile._();

  /// Globally-accessible class instance.
  ///
  static GsdServiceOpenFile get instance => _instance() as GsdServiceOpenFile;

  Future<({String name, dart_typed_data.Uint8List bytes})?> openImageFile() async {
    final result = await file_picker.FilePicker.platform.pickFiles(
      type: file_picker.FileType.custom,
      allowedExtensions: const [
        'jpg',
        'jpeg',
        'png',
        'svg',
      ],
      withData: true,
    );
    if (result != null) {
      final element = result.files.single;
      if (element.bytes != null) {
        return (
          name: element.name,
          bytes: element.bytes!,
        );
      }
    } else {
      // User canceled the picker.
    }
  }

  Future<({String name, dart_typed_data.Uint8List bytes})?> openFontFile() async {
    final result = await file_picker.FilePicker.platform.pickFiles(
      type: file_picker.FileType.custom,
      allowedExtensions: const [
        'otf',
        'ttf',
      ],
      withData: true,
    );
    if (result != null) {
      final element = result.files.single;
      if (element.bytes != null) {
        return (
          name: element.name,
          bytes: element.bytes!,
        );
      }
    } else {
      // User canceled the picker.
    }
  }
}
