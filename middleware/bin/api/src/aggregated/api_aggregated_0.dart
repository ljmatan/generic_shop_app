part of '../../api.dart';

extension GsaaEndpointsAggregatedExt on GsaaEndpointsAggregated {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaaEndpointsAggregated.getDataVersion:
        return GsamApiAggregated0.instance.getDataVersion;
      case GsaaEndpointsAggregated.getMobileAppData:
        return GsamApiAggregated0.instance.getMobileAppData;
    }
  }
}

class GsamApiAggregated0 extends GsamApi {
  GsamApiAggregated0._() : super._();

  static final instance = GsamApiAggregated0._();

  @override
  int get version => 0;

  @override
  String get identifier => 'aggregated';

  @override
  List<({Future<shelf.Response> Function(shelf.Request p1) handler, String method, String path})> get endpoints {
    return [];
  }

  Future<shelf.Response> getDataVersion(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final dataVersionLogLines = await dart_io.File(
          '${GsamConfig.rootDirectoryPath}/middleware/store/media/src/data.version',
        ).readAsLines();
        int dataVersion = -1;
        for (final line in dataVersionLogLines) {
          final parsedVersion = int.tryParse(line);
          if (parsedVersion != null) {
            dataVersion = parsedVersion;
            break;
          }
        }
        return _responseOk(
          body: {
            'version': dataVersion,
          },
        );
      },
    );
  }

  Future<shelf.Response> getMobileAppData(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) {
        return _responseOk(
          body: {
            '': '',
          },
        );
      },
    );
  }
}
