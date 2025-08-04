extension PaddedStringFormatting on int {
  String get fourDigits => _fourDigits(this);
  String get twoDigits => _twoDigits(this);
  String get threeDigits => _threeDigits(this);
  String get sixDigits => _sixDigits(this);
}

String _sixDigits(int n) {
  assert(n < -9999 || n > 9999);
  int absN = n.abs();
  String sign = n < 0 ? '-' : '+';
  if (absN >= 100000) return '$sign$absN';
  return '${sign}0$absN';
}

String _fourDigits(int n) {
  int absN = n.abs();
  String sign = n < 0 ? '-' : '';
  if (absN >= 1000) return '$n';
  if (absN >= 100) return '${sign}0$absN';
  if (absN >= 10) return '${sign}00$absN';
  return '${sign}000$absN';
}

String _twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

String _threeDigits(int n) {
  if (n >= 100) return '$n';
  if (n >= 10) return '0$n';
  return '00$n';
}
