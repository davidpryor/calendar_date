import 'package:flutter_test/flutter_test.dart';
import 'package:strider/strider.dart';

/// Dummy Stridable class to replace DummyStridable for testing and development.
class DummyStridable implements Stridable<DummyStridable, int> {
  final int value;

  const DummyStridable(this.value);

  @override
  DummyStridable operator +(int amount) => DummyStridable(value + amount);
  @override
  DummyStridable operator -(int amount) => DummyStridable(value - amount);
  @override
  bool operator >(DummyStridable other) => value > other.value;
  @override
  bool operator <(DummyStridable other) => value < other.value;
  @override
  bool operator >=(DummyStridable other) => value >= other.value;
  @override
  bool operator <=(DummyStridable other) => value <= other.value;

  int compareTo(DummyStridable other) => value.compareTo(other.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DummyStridable &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'DummyStridable($value)';
}

void main() {
  test('same day', () {
    final DummyStridable from = const DummyStridable(1);
    final to = const DummyStridable(1);
    expect(from, to);
    final l = Stride(from, to, 1).toList();
    expect(l.length, 1);
    expect(l[0], from);
    expect(l[0], to);
  });
  test('to before from (assertion)', () {
    final DummyStridable from = const DummyStridable(1);
    final to = const DummyStridable(0);
    expect(from > to, true);
    expect(() => Stride(from, to, 1).toList(), throwsAssertionError);
  });
  test(
    'into future',
    () {
      final DummyStridable from = const DummyStridable(1);
      final DummyStridable to = const DummyStridable(2);
      final l = Stride(from, to, 1).toList();
      expect(l.length, 2);
      expect(l[0], from);
      expect(l[1], to);
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into past',
    () {
      final DummyStridable from = const DummyStridable(1);
      final DummyStridable to = const DummyStridable(0);
      final l = Stride(from, to, -1).toList();
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
      final DummyStridable from = const DummyStridable(1);
      final DummyStridable to = const DummyStridable(2);
      expect(
        () => Stride(from, to, 0).toList(),
        throwsAssertionError,
      );
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into past with sub-day increment',
    () {
      final DummyStridable from = const DummyStridable(1);
      final DummyStridable to = const DummyStridable(0);
      expect(
        () => Stride(from, to, -0).toList(),
        throwsAssertionError,
      );
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
  test(
    'into the future 100 days',
    () {
      final DummyStridable from = const DummyStridable(1);
      final DummyStridable to = const DummyStridable(101);
      final l = Stride(from, to, 1).toList();
      expect(l.length, 101);
      expect(l[0], from);
      expect(l[50], from + 50);
      expect(l[100], to);
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );
}
