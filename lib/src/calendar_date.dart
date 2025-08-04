import 'utils.dart';
import 'calendar_datetime.dart' show CalendarDateTime;
import 'stride.dart' show Stridable;

class CalendarDate
    implements Comparable<CalendarDate>, Stridable<CalendarDate, Duration> {
  final DateTime _internalDateTime;
  DateTime asDateTime() => DateTime.utc(year, month, day, 0, 0, 0, 0, 0);

  // Constructors
  CalendarDate(int year, [int month = 1, int day = 1])
      : _internalDateTime = DateTime.utc(year, month, day, 0, 0, 0, 0, 0);

  /// Calendar Date from local time.
  factory CalendarDate.local() => CalendarDate.fromDateTime(DateTime.now());

  /// Calendar Date from UTC timestamp.
  factory CalendarDate.zulu() =>
      CalendarDate.fromDateTime(DateTime.timestamp());

  /// Creates a Date object from a timestamp in milliseconds since epoch.
  /// It will truncate the time component.
  factory CalendarDate.fromMillisecondsSinceEpoch(
    int millisecondsSinceEpoch, {
    bool inLocalTime = false,
  }) =>
      CalendarDate.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(
          millisecondsSinceEpoch,
          isUtc: !inLocalTime,
        ),
      );

  /// Creates a Date object from a timestamp in microseconds since epoch.
  /// It will truncate the time component.
  factory CalendarDate.fromMicrosecondsSinceEpoch(
    int microsecondsSinceEpoch, {
    bool inLocalTime = false,
  }) =>
      CalendarDate.fromDateTime(
        DateTime.fromMicrosecondsSinceEpoch(
          microsecondsSinceEpoch,
          isUtc: !inLocalTime,
        ),
      );

  /// Creates a DateUTC object from a DateTime object.
  /// Ignores timezone.
  factory CalendarDate.fromDateTime(DateTime dateTime) =>
      CalendarDate(dateTime.year, dateTime.month, dateTime.day);

  /// Creates a DateUTC object from a DateTime object.
  /// ignores timezone.
  factory CalendarDate.parse(String input) {
    final dt = DateTime.parse(input);
    return CalendarDate.fromDateTime(dt);
  }
  static CalendarDate? tryParse(String input) {
    try {
      return CalendarDate.parse(input);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    String y = year.fourDigits;
    String m = month.twoDigits;
    String d = day.twoDigits;
    return '$y-$m-$d';
  }

  String toIso8601String() {
    String y =
        (year >= -9999 && year <= 9999) ? year.fourDigits : year.sixDigits;
    String m = month.twoDigits;
    String d = day.twoDigits;
    return '$y-$m-$d';
  }

  // Operators
  @override
  int compareTo(CalendarDate other) =>
      _internalDateTime.compareTo(other._internalDateTime);
  @override
  bool operator ==(Object other) =>
      other is CalendarDate && _internalDateTime == other._internalDateTime;
  @override
  int get hashCode => _internalDateTime.hashCode;
  bool isBefore(CalendarDate other) =>
      _internalDateTime.isBefore(other._internalDateTime);
  @override
  bool operator <(CalendarDate other) => isBefore(other);
  bool isAfter(CalendarDate other) =>
      _internalDateTime.isAfter(other._internalDateTime);
  @override
  bool operator >(CalendarDate other) => isAfter(other);
  bool isAtSameMomentAs(CalendarDate other) =>
      _internalDateTime.isAtSameMomentAs(other._internalDateTime);
  @override
  bool operator <=(CalendarDate other) =>
      isBefore(other) || isAtSameMomentAs(other);
  @override
  bool operator >=(CalendarDate other) =>
      isAfter(other) || isAtSameMomentAs(other);

  /// Add a duration to the date.
  /// It will ignore time attributes that would not change the year, month, or day.
  CalendarDate add(Duration duration) => CalendarDate.fromDateTime(
        _internalDateTime.add(Duration(days: duration.inDays)),
      );
  @override
  CalendarDate operator +(Duration duration) => add(duration);

  /// Subtract a duration to the date.
  /// It will ignore time attributes that would not change the year, month, or day.
  CalendarDate subtract(Duration duration) => CalendarDate.fromDateTime(
        _internalDateTime.subtract(Duration(days: duration.inDays)),
      );
  @override
  CalendarDate operator -(Duration duration) => subtract(duration);

  /// Difference between two dates.
  Duration difference(CalendarDate other) =>
      _internalDateTime.difference(other._internalDateTime);

  // Wrappers
  int get year => _internalDateTime.year;
  int get month => _internalDateTime.month;
  int get day => _internalDateTime.day;
  int get weekday => _internalDateTime.weekday;
  String get timeZoneName => _internalDateTime.timeZoneName;
  Duration get timeZoneOffset => _internalDateTime.timeZoneOffset;
  int get millisecondsSinceEpoch => _internalDateTime.millisecondsSinceEpoch;
  int get microsecondsSinceEpoch => _internalDateTime.microsecondsSinceEpoch;
  // Weekday constants that are returned by [weekday] method:
  static const int monday = DateTime.monday;
  static const int tuesday = DateTime.tuesday;
  static const int wednesday = DateTime.wednesday;
  static const int thursday = DateTime.thursday;
  static const int friday = DateTime.friday;
  static const int saturday = DateTime.saturday;
  static const int sunday = DateTime.sunday;
  static const int daysPerWeek = DateTime.daysPerWeek;
  // Month constants that are returned by the [month] getter.
  static const int january = DateTime.january;
  static const int february = DateTime.february;
  static const int march = DateTime.march;
  static const int april = DateTime.april;
  static const int may = DateTime.may;
  static const int june = DateTime.june;
  static const int july = DateTime.july;
  static const int august = DateTime.august;
  static const int september = DateTime.september;
  static const int october = DateTime.october;
  static const int november = DateTime.november;
  static const int december = DateTime.december;
  static const int monthsPerYear = DateTime.monthsPerYear;

  CalendarDate copyWith({int? year, int? month, int? day}) {
    return CalendarDate(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
    );
  }
}

extension CalendarDateConversion on CalendarDateTime {
  CalendarDate asCalendarDate() => CalendarDate(year, month, day);
}
