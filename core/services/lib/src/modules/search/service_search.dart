import 'package:generic_shop_app_architecture/gsar.dart';

/// On-device search services used for filtering results with the given parameters.
///
class GsaServiceSearch extends GsaService {
  GsaServiceSearch._();

  static final _instance = GsaServiceSearch._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServiceSearch get instance => _instance() as GsaServiceSearch;

  String _normalizeComparisonValue(String searchTerm) {
    searchTerm = searchTerm.trim().replaceAll('  ', ' ').toLowerCase();
    for (final character in searchTerm.split('').indexed) {
      try {
        final existingExcluded = _excludedCharacters.firstWhere(
          (excludedChar) {
            return excludedChar.chracter == character.$2;
          },
        );
        searchTerm = searchTerm.replaceAll(
          character.$2,
          existingExcluded.replacement,
        );
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
    required Iterable<dynamic> comparisonValues,
    required Iterable<String> Function(dynamic value) comparator,
  }) async {
    final normalizedSearchTerm = _normalizeComparisonValue(searchTerm);
    if (normalizedSearchTerm.isEmpty) return [];
    final results = <dynamic>[];
    for (final comparison in comparisonValues) {
      final comparisonValues = comparator(comparison);
      for (final comparisonValue in comparisonValues) {
        final normalizedComparisonValue = _normalizeComparisonValue(comparisonValue);
        if (normalizedComparisonValue.isEmpty) continue;
        if (normalizedComparisonValue.contains(normalizedSearchTerm)) {
          results.add(comparison);
          break;
        }
      }
    }
    return results;
  }

  final _excludedCharacters = <({
    String chracter,
    String replacement,
  })>[
    for (final specialCharacter in const <String>{
      ',',
      '.',
      '/',
      '-',
    })
      (
        chracter: specialCharacter,
        replacement: '',
      ),
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
