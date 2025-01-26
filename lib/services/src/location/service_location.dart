import 'package:gsa_architecture/gsar.dart';

/// Linter services with custom code inspection configuration.
///
class GsaServiceLocation extends GsarService {
  GsaServiceLocation._();

  static final _instance = GsaServiceLocation._();

  // ignore: public_member_api_docs
  static GsaServiceLocation get instance => _instance() as GsaServiceLocation;
}
