/// Represents a single SearchResult
/// List.
/// In this case the T is the Object,
/// so whether Wish, Book or Entry.
class SearchResults {
  const SearchResults({
    required this.results,
    required this.search,
  });

  /// The Results of the Search.
  final List<Object> results;

  /// The String the User searched with.
  final String search;
}
