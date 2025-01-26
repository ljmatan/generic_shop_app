import 'package:generic_shop_app_architecture/gsar.dart';

/// On-device search services used for filtering results with the given parameters.
///
class GsaaServiceSearch extends GsarService {
  GsaaServiceSearch._();

  static final _instance = GsaaServiceSearch._();

  // ignore: public_member_api_docs
  static GsaaServiceSearch get instance => _instance() as GsaaServiceSearch;

  String _normalizeComparisonValue(String searchTerm) {
    searchTerm = searchTerm.trim().replaceAll(',', '').replaceAll('.', '').replaceAll('/', '').replaceAll('  ', ' ').toLowerCase();
    for (final character in searchTerm.split('').indexed) {
      try {
        final existingExcluded = _excludedCharacters.firstWhere((excludedChar) => excludedChar.chracter == character.$2);
        searchTerm = searchTerm.replaceAll(character.$2, existingExcluded.replacement);
      } catch (e) {
        continue;
      }
    }
    return searchTerm;
  }

  /// Compares the contents of [comparisonValue] instances against the given [searchTerm] with the specified [comparator].
  ///
  Future<List<dynamic>> findByCharacters({
    required String searchTerm,
    required List<dynamic> comparisonValues,
    required String Function(dynamic value) comparator,
  }) async {
    final normalizedSearchTerm = _normalizeComparisonValue(searchTerm);
    if (normalizedSearchTerm.isEmpty) return [];
    final results = <dynamic>[];
    for (final comparison in comparisonValues) {
      final comparisonValue = comparator(comparison);
      final normalizedComparisonValue = _normalizeComparisonValue(comparisonValue);
      if (normalizedComparisonValue.isEmpty) continue;
      if (normalizedComparisonValue.contains(normalizedSearchTerm)) {
        results.add(comparison);
      }
    }
    return results;
  }

  final _excludedCharacters = <({String chracter, String replacement})>[
    (
      chracter: 'š',
      replacement: 's',
    ),
    (
      chracter: 'đ',
      replacement: 'd',
    ),
    (
      chracter: 'č',
      replacement: 'c',
    ),
    (
      chracter: 'ć',
      replacement: 'c',
    ),
    (
      chracter: 'ž',
      replacement: 'z',
    ),
    (
      chracter: 'ä',
      replacement: 'a',
    ),
    (
      chracter: 'ö',
      replacement: 'o',
    ),
    (
      chracter: 'ü',
      replacement: 'u',
    ),
    (
      chracter: 'ß',
      replacement: 's',
    ),
  ];
}
