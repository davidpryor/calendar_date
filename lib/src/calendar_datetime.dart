import 'utils.dart';
import 'calendar_date.dart' show CalendarDate;
import 'stride.dart' show Stridable, Stride;

class CalendarDateTime
    implements
        Comparable<CalendarDateTime>,
        Stridable<CalendarDateTime, Duration> {
  final DateTime _internalDateTime;
  DateTime asDateTime() => DateTime.utc(
        year,
        month,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );

  // Constructors
  CalendarDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : _internalDateTime = DateTime.utc(
          year,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        );

  /// Calendar Date & Time from local time.
  factory CalendarDateTime.local() =>
      CalendarDateTime.fromDateTime(DateTime.now());

  /// Calendar Date & Time from UTC timestamp.
  factory CalendarDateTime.zulu() =>
      CalendarDateTime.fromDateTime(DateTime.timestamp());

  /// Creates a Date object from a timestamp in milliseconds since epoch.
  factory CalendarDateTime.fromMillisecondsSinceEpoch(
    int millisecondsSinceEpoch, {
    bool inLocalTime = false,
  }) =>
      CalendarDateTime.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(
          millisecondsSinceEpoch,
          isUtc: !inLocalTime,
        ),
      );

  /// Creates a Date object from a timestamp in microseconds since epoch.
  factory CalendarDateTime.fromMicrosecondsSinceEpoch(
    int microsecondsSinceEpoch, {
    bool inLocalTime = false,
  }) =>
      CalendarDateTime.fromDateTime(
        DateTime.fromMicrosecondsSinceEpoch(
          microsecondsSinceEpoch,
          isUtc: !inLocalTime,
        ),
      );

  /// Creates a CalendarDateTime object from a DateTime object.
  /// Ignores timezone.
  factory CalendarDateTime.fromDateTime(DateTime dateTime) =>
      CalendarDateTime(dateTime.year, dateTime.month, dateTime.day);

  /// Creates a CalendarDateTime object from a DateTime object.
  /// ignores timezone.
  factory CalendarDateTime.parse(String input) {
    final dt = DateTime.parse(input);
    return CalendarDateTime.fromDateTime(dt);
  }
  static CalendarDateTime? tryParse(String input) {
    try {
      return CalendarDateTime.parse(input);
    } catch (e) {
      return null;
    }
  }

  String toIso8601String() {
    String y =
        (year >= -9999 && year <= 9999) ? year.fourDigits : year.sixDigits;
    String m = month.twoDigits;
    String d = day.twoDigits;
    String h = hour.twoDigits;
    String min = minute.twoDigits;
    String sec = second.twoDigits;
    String ms = millisecond.threeDigits;
    String us = microsecond == 0 ? '' : microsecond.threeDigits;
    return '$y-$m-${d}T$h:$min:$sec.$ms${us}Z';
  }

  // Operators
  @override
  int compareTo(CalendarDateTime other) =>
      _internalDateTime.compareTo(other._internalDateTime);
  @override
  bool operator ==(Object other) =>
      other is CalendarDateTime && _internalDateTime == other._internalDateTime;
  @override
  int get hashCode => _internalDateTime.hashCode;
  bool isBefore(CalendarDateTime other) =>
      _internalDateTime.isBefore(other._internalDateTime);
  @override
  bool operator <(CalendarDateTime other) => isBefore(other);
  bool isAfter(CalendarDateTime other) =>
      _internalDateTime.isAfter(other._internalDateTime);
  @override
  bool operator >(CalendarDateTime other) => isAfter(other);
  bool isAtSameMomentAs(CalendarDateTime other) =>
      _internalDateTime.isAtSameMomentAs(other._internalDateTime);
  @override
  bool operator <=(CalendarDateTime other) =>
      isBefore(other) || isAtSameMomentAs(other);
  @override
  bool operator >=(CalendarDateTime other) =>
      isAfter(other) || isAtSameMomentAs(other);

  /// Add a duration to the date.
  CalendarDateTime add(Duration duration) =>
      CalendarDateTime.fromDateTime(_internalDateTime.add(duration));
  @override
  CalendarDateTime operator +(Duration duration) => add(duration);

  /// Subtract a duration to the date.
  CalendarDateTime subtract(Duration duration) =>
      CalendarDateTime.fromDateTime(_internalDateTime.subtract(duration));
  @override
  CalendarDateTime operator -(Duration duration) => subtract(duration);

  /// Difference between two dates.
  Duration difference(CalendarDateTime other) =>
      _internalDateTime.difference(other._internalDateTime);

  // Wrappers
  int get year => _internalDateTime.year;
  int get month => _internalDateTime.month;
  int get day => _internalDateTime.day;
  int get weekday => _internalDateTime.weekday;
  int get hour => _internalDateTime.hour;
  int get minute => _internalDateTime.minute;
  int get second => _internalDateTime.second;
  int get millisecond => _internalDateTime.millisecond;
  int get microsecond => _internalDateTime.microsecond;
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

  CalendarDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return CalendarDateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

extension CalendarDateTimeConversion on CalendarDate {
  CalendarDateTime asCalendarDateTime() =>
      CalendarDateTime(year, month, day, 0, 0, 0, 0, 0);
}

extension CalendarDateTimeStrideUtil on CalendarDateTime {
  /// Creates a generator iterator that yields dates from this date to the [to] date,
  /// [to] is inclusive.
  Iterable<CalendarDateTime> stride({
    required CalendarDateTime to,
    required Duration by,
  }) {
    return Stride<CalendarDateTime, Duration>(this, to, by);
  }
}
