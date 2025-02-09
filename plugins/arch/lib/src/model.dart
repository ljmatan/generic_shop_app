part 'model.g.dart';

abstract mixin class GsaModel {
  const GsaModel();

  Map<String, dynamic> toJson();

  List<({String key, Type type, bool nullable})> generateFields() {
    return [];
  }
}
