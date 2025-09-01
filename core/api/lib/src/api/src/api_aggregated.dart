import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// API endpoint call and handling implementation references.
///
extension GsaEndpointsAggregatedImplExt on GsaEndpointsAggregated {
  Function get implementation {
    switch (this) {
      case GsaEndpointsAggregated.getDataVersion:
        return GsaApiAggregated.instance.getDataVersion;
      case GsaEndpointsAggregated.getMobileAppData:
        return GsaApiAggregated.instance.getMobileAppData;
    }
  }
}

/// Merchant / vendor related API calls and logic.
///
class GsaApiAggregated extends GsaApi {
  const GsaApiAggregated._();

  /// Globally-accessible class instance.
  ///
  static const instance = GsaApiAggregated._();

  @override
  String get protocol => 'http';

  Future<int> getDataVersion() async {
    final response = await get(GsaEndpointsAggregated.getDataVersion.path);
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
