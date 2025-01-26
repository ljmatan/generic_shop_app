import 'package:gsa_architecture/gsa_architecture.dart';

class GsaServiceAuth extends GsarService {
  GsaServiceAuth._();

  static final _instance = GsaServiceAuth._();

  // ignore: public_member_api_docs
  static GsaServiceAuth get instance => _instance() as GsaServiceAuth;

  @override
  bool get critical => true;
}
