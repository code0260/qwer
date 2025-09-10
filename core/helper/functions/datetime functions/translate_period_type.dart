import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnPeriodType(PeriodType? type) {
  switch (type) {
    case PeriodType.day:
      return "day";
    case PeriodType.week:
      return "week";
    case PeriodType.month:
      return "month";
    case PeriodType.year:
      return "year";
    default:
      return null;
  }
}

String? translateToArPeriodType(PeriodType? type) {
  switch (type) {
    case PeriodType.day:
      return "يوم";
    case PeriodType.week:
      return "أسبوع";
    case PeriodType.month:
      return "شهر";
    case PeriodType.year:
      return "سنة";
    case PeriodType.last30Days:
      return "آخر 30 يومًا";
    default:
      return null;
  }
}

String? translateToEnPeriodTypeFromString(String? type) {
  switch (type) {
    case "يوم":
      return "day";
    case "أسبوع":
      return "week";
    case "شهر":
      return "month";
    case "سنة":
      return "year";
    default:
      return null;
  }
}

String? translateToArPeriodTypeFromString(String? type) {
  switch (type) {
    case "day":
      return "يوم";
    case "week":
      return "أسبوع";
    case "month":
      return "شهر";
    case "year":
      return "سنة";
    default:
      return null;
  }
}

PeriodType translateToEnumPeriodTypeFromArString(String? type) {
  switch (type) {
    case "يوم":
      return PeriodType.day;
    case "أسبوع":
    case "آخر 7 أيام":
      return PeriodType.week;
    case "شهر":
      return PeriodType.month;
    case "آخر 30 يومًا":
      return PeriodType.last30Days;
    case "سنة":
      return PeriodType.year;
    default:
      return PeriodType.month;
  }
}
