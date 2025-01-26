import 'package:generic_shop_app_architecture/gsa_architecture.dart';

class GsaaServiceCalendar extends GsarService {
  GsaaServiceCalendar._();

  static final _instance = GsaaServiceCalendar._();

  static GsaaServiceCalendar get instance => _instance() as GsaaServiceCalendar;
}
