part 'model.g.dart';

abstract mixin class GsarModel {
  const GsarModel();

  Map<String, dynamic> toJson();

  List<({String key, Type type, bool nullable})> generateFields() {
    return [];
  }
}
