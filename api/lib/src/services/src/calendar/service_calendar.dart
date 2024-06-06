import 'package:generic_shop_app_api/src/services/services.dart';

class GsaaServiceCalendar extends GsaaService {
  GsaaServiceCalendar._();

  static final _instance = GsaaServiceCalendar._();

  static GsaaServiceCalendar get instance => _instance() as GsaaServiceCalendar;
}
