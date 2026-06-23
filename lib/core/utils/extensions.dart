import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  String toTimeString() => DateFormat.jm().format(this);
  String toDateString() => DateFormat.yMMMd().format(this);
  String toDateTimeString() => DateFormat.yMMMd().add_jm().format(this);

  bool get isToday => isSameDay(DateTime.now());
  bool get isTomorrow => isSameDay(DateTime.now().add(const Duration(days: 1)));
}

extension DurationX on Duration {
  String toHumanReadable() {
    if (inMinutes < 60) return '$inMinutes min';
    final h = inHours;
    final m = inMinutes.remainder(60);
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }
}

extension StringX on String {
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  bool containsIgnoreCase(String other) =>
      toLowerCase().contains(other.toLowerCase());
}

extension ListX<T> on List<T> {
  T? firstOrNull(bool Function(T) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
