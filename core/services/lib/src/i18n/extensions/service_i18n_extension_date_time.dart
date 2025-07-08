part of '../service_i18n.dart';

enum GsaServiceI18NDateFormattingOrder {
  dmy,
  mdy,
  ymd,
}

enum GsaServiceI18NDateFormattingSeparator {
  slash,
  dash,
  dot,
}

extension GsaServiceI18NDateFormatting on DateTime {
  String formatted({
    GsaServiceI18NDateFormattingOrder order = GsaServiceI18NDateFormattingOrder.dmy,
    GsaServiceI18NDateFormattingSeparator separator = GsaServiceI18NDateFormattingSeparator.dot,
    bool includeTime = false,
    bool padZero = true,
  }) {
    String sep;
    switch (separator) {
      case GsaServiceI18NDateFormattingSeparator.slash:
        sep = '/';
        break;
      case GsaServiceI18NDateFormattingSeparator.dash:
        sep = '-';
        break;
      case GsaServiceI18NDateFormattingSeparator.dot:
        sep = '.';
        break;
    }
    String twoDigits(int n) => padZero && n < 10 ? '0$n' : '$n';
    final d = twoDigits(day);
    final m = twoDigits(month);
    final y = year.toString();
    String dateStr;
    switch (order) {
      case GsaServiceI18NDateFormattingOrder.dmy:
        dateStr = '$d$sep$m$sep$y';
        break;
      case GsaServiceI18NDateFormattingOrder.mdy:
        dateStr = '$m$sep$d$sep$y';
        break;
      case GsaServiceI18NDateFormattingOrder.ymd:
        dateStr = '$y$sep$m$sep$d';
        break;
    }
    if (!includeTime) return dateStr;
    final h = twoDigits(hour);
    final min = twoDigits(minute);
    final sec = twoDigits(second);
    return '$dateStr $h:$min:$sec';
  }
}
