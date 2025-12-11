class SearchResult {
  final String w;
  final String text;
  final String pron;
  final String? brief;
  final List<String>? refs;

  SearchResult({
    required this.w,
    required this.text,
    required this.pron,
    this.brief,
    this.refs,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      w: json['w'] ?? '',
      text: json['text'] ?? '',
      pron: json['pron'] ?? '',
      brief: json['brief'],
      refs: json['refs'] != null ? List<String>.from(json['refs']) : null,
    );
  }
}

class SearchResponse {
  final List<String> queries;
  final List<SearchResult> results;
  final String? nextCursor;
  final bool hasMore;

  SearchResponse({
    required this.queries,
    required this.results,
    this.nextCursor,
    this.hasMore = false,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return SearchResponse(
      queries:
          data['queries'] != null ? List<String>.from(data['queries']) : [],
      results: data['results'] != null
          ? (data['results'] as List)
              .map((item) => SearchResult.fromJson(item))
              .toList()
          : [],
      nextCursor: data['nextCursor'],
      hasMore: data['hasMore'] ?? false,
    );
  }
}
