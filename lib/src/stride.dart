/// Interface for types that can be used in a stride operation.
abstract class Stridable<T, E> {
  T operator +(E other);
  T operator -(E other);
  bool operator <(T other);
  bool operator >(T other);
  bool operator <=(T other);
  bool operator >=(T other);
  // ignore: hash_and_equals, annotate_overrides
  bool operator ==(Object other);
}

/// A stride operation that generates an iterable of values from `from` to `to`
class Stride<T extends Stridable<T, E>, E extends Object> extends Iterable<T> {
  final T from;
  final T to;
  final E by;
  const Stride(this.from, this.to, this.by)
      : assert(
            (from >= to && from + by < from) ||
                (from <= to && from + by > from),
            'StrideTo: Incrementing $from by $by must move towards $to.');

  /// Checks if the stride arguments are valid.
  /// If from is greater than to, the increment must be negative.
  /// If from is less than to, the increment must be positive.
  bool _hasValidArguments() =>
      (from >= to && from + by < from) || (from <= to && from + by > from);

  @override
  Iterator<T> get iterator => _generator.iterator;
  Iterable<T> get _generator sync* {
    if (!_hasValidArguments()) {
      // Caught by assertion in debug
      throw ArgumentError(
          'StrideTo: Incrementing $from by $by must move towards $to.');
    }
    if (from == to) {
      yield from;
      return;
    }
    T prev = from;
    T current = from;
    if (from < to) {
      while (current <= to) {
        yield current;
        prev = current;
        current = current + by;
        if (current == prev) {
          // Caught by assertion in debug
          throw ArgumentError(
              'StrideTo: Infinite loop detected. The increment is too small.');
        }
      }
    } else {
      while (current >= to) {
        yield current;
        prev = current;
        current = current + by;
        if (current == prev) {
          // Caught by assertion in debug
          throw ArgumentError(
              'StrideTo: Infinite loop detected. The increment is too small.');
        }
      }
    }
  }

  @override
  String toString() {
    return 'StrideTo{from: $from, to: $to, by: $by}';
  }
}
