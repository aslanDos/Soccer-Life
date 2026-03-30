/// Generic wrapper for the Football API response envelope:
/// { "response": [...], "results": N, "errors": [], "paging": {...} }
///
/// Usage:
///   final res = ApiResponse.fromJson(response.data, CountryModel.fromJson);
///   final countries = res.data; // List of T
class ApiResponse<T> {
  final List<T> data;
  final int results;

  const ApiResponse({required this.data, required this.results});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final list = json['response'] as List? ?? [];
    return ApiResponse(
      data: list.map((e) => fromJson(e as Map<String, dynamic>)).toList(),
      results: json['results'] as int? ?? list.length,
    );
  }
}
