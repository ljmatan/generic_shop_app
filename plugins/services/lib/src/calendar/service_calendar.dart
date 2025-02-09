import 'package:generic_shop_app_architecture/gsar.dart';

class GsaServiceCalendar extends GsaService {
  GsaServiceCalendar._();

  static final _instance = GsaServiceCalendar._();

  static GsaServiceCalendar get instance => _instance() as GsaServiceCalendar;
}
