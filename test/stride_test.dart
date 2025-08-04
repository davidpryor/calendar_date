import 'package:flutter_test/flutter_test.dart';
import 'package:calendar_date/calendar_date.dart';

void main() {
  test(
    'into future',
    () {
      final CalendarDate from = CalendarDate.local();
      final CalendarDate to = from + const Duration(days: 1);
      final l = Stride(from, to, const Duration(days: 1)).toList();
      expect(l.length, 2);
      expect(l[0], from);
      expect(l[1], to);
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into past',
    () {
      final CalendarDate from = CalendarDate.local();
      final CalendarDate to = from - const Duration(days: 1);
      final l = Stride(from, to, const Duration(days: -1)).toList();
      expect(l.length, 2);
      expect(l[0], from);
      expect(l[1], to);
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  // create a test with an expect timeout

  test(
    'into future with sub-day increment',
    () {
      final CalendarDate from = CalendarDate.local();
      final CalendarDate to = from + const Duration(days: 1);
      expect(
        () => Stride(from, to, const Duration(hours: 1)).toList(),
        throwsA(isA<AssertionError>()),
      );
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into past with sub-day increment',
    () {
      final CalendarDate from = CalendarDate.local();
      final CalendarDate to = from + const Duration(days: -1);
      expect(
        () => Stride(from, to, const Duration(hours: -1)).toList(),
        throwsA(isA<AssertionError>()),
      );
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into past with non-whole day hours',
    () {
      final CalendarDate from = CalendarDate.local();
      final CalendarDate to = from + const Duration(days: -1);
      final l = Stride(from, to, const Duration(hours: -25)).toList();

      expect(l.length, 2);
      expect(l[0], from);
      expect(l[1], to);
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into future with day increment in hours',
    () {
      final CalendarDate from = CalendarDate.local();
      final CalendarDate to = from + const Duration(days: 1);
      final l = Stride(from, to, const Duration(hours: 24)).toList();
      expect(l.length, 2);
      expect(l[0], from);
      expect(l[1], to);
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into past with day increment in hours',
    () {
      final CalendarDate from = CalendarDate.local();
      final CalendarDate to = from + const Duration(days: -1);
      final l = Stride(from, to, const Duration(hours: -24)).toList();

      expect(l.length, 2);
      expect(l[0], from);
      expect(l[1], to);
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into the future 100 days',
    () {
      final CalendarDate from = CalendarDate.local();
      final CalendarDate to = from + const Duration(days: 100);
      final l = Stride(from, to, const Duration(days: 1)).toList();
      expect(l.length, 101);
      expect(l[0], from);
      expect(l[50], from + const Duration(days: 50));
      expect(l[100], to);
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
}
