library models;

/// Represents a single
/// Statistic in the Reading App
class Statistic {
  const Statistic({
    required this.title,
    required this.data,
  });

  /// The Title of the Statistic
  final String title;

  /// The Data of the Statistic.
  /// This is the Content / the
  /// actual Statistic.
  final String data;
}
