import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:gsa_architecture/gsar.dart';

/// API endpoint call and handling implementation references.
///
extension GsaaEndpointsAggregatedImplExt on GsaaEndpointsAggregated {
  Function get implementation {
    switch (this) {
      case GsaaEndpointsAggregated.getDataVersion:
        return GsaaApiAggregated.instance.getDataVersion;
      case GsaaEndpointsAggregated.getMobileAppData:
        return GsaaApiAggregated.instance.getMobileAppData;
    }
  }
}

/// Merchant / vendor related API calls and logic.
///
class GsaaApiAggregated extends GsarApi {
  const GsaaApiAggregated._();

  static const instance = GsaaApiAggregated._();

  @override
  String get protocol => 'http';

  @override
  String get identifier => 'aggregated';

  @override
  int get version => 0;

  Future<int> getDataVersion() async {
    final response = await get(
      GsaaEndpointsAggregated.getDataVersion.path,
    );
    final currentVersion = response['version'];
    if (currentVersion is! String) {
      throw 'Current data version is not a string: $currentVersion.';
    }
    try {
      final versionSegments = currentVersion.split('.');
      if (versionSegments.length != 4) {
        throw 'Current data version segmented length not 4: $currentVersion.';
      }
      try {
        final versionSegmentsInt = versionSegments.map((segment) => int.parse(segment));
        return versionSegmentsInt.elementAt(0) * 1000 +
            versionSegmentsInt.elementAt(1) * 100 +
            versionSegmentsInt.elementAt(2) * 10 +
            versionSegmentsInt.elementAt(3) * 1;
      } catch (e) {
        throw 'Current data version processing error: $currentVersion.';
      }
    } catch (e) {
      throw 'Current data version improper format: $currentVersion.';
    }
  }

  Future getMobileAppData() async {
    // TODO
  }
}
