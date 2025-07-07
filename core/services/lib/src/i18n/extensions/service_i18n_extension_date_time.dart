part of '../service_i18n.dart';

enum GsaServiceI18nDateFormattingOrder {
  dmy,
  mdy,
  ymd,
}

enum GsaServiceI18nDateFormattingSeparator {
  slash,
  dash,
  dot,
}

extension GsaServiceI18nDateFormatting on DateTime {
  String formatted({
    GsaServiceI18nDateFormattingOrder order = GsaServiceI18nDateFormattingOrder.dmy,
    GsaServiceI18nDateFormattingSeparator separator = GsaServiceI18nDateFormattingSeparator.dot,
    bool includeTime = false,
    bool padZero = true,
  }) {
    String sep;
    switch (separator) {
      case GsaServiceI18nDateFormattingSeparator.slash:
        sep = '/';
        break;
      case GsaServiceI18nDateFormattingSeparator.dash:
        sep = '-';
        break;
      case GsaServiceI18nDateFormattingSeparator.dot:
        sep = '.';
        break;
    }
    String twoDigits(int n) => padZero && n < 10 ? '0$n' : '$n';
    final d = twoDigits(day);
    final m = twoDigits(month);
    final y = year.toString();
    String dateStr;
    switch (order) {
      case GsaServiceI18nDateFormattingOrder.dmy:
        dateStr = '$d$sep$m$sep$y';
        break;
      case GsaServiceI18nDateFormattingOrder.mdy:
        dateStr = '$m$sep$d$sep$y';
        break;
      case GsaServiceI18nDateFormattingOrder.ymd:
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
