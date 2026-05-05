class ApiResponse<T> {
  final int httpStatusCode;
  final String httpStatusCodeName;
  final String message;
  final T? data;

  ApiResponse({
    required this.httpStatusCode,
    required this.httpStatusCodeName,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromData,
  ) {
    return ApiResponse(
      httpStatusCode: json['httpStatusCode'] as int? ?? 200,
      httpStatusCodeName: json['httpStatusCodeName'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: json['data'] != null ? fromData(json['data']) : null,
    );
  }

  bool get isSuccess => httpStatusCode >= 200 && httpStatusCode < 300;
}

class Paginated<T> {
  final int currentPage;
  final int pageCount;
  final int pageSize;
  final int rowCount;
  final List<T> results;

  Paginated({
    required this.currentPage,
    required this.pageCount,
    required this.pageSize,
    required this.rowCount,
    required this.results,
  });

  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromItem,
  ) {
    final list = (json['results'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(fromItem)
        .toList();
    return Paginated(
      currentPage: json['currentPage'] as int? ?? 1,
      pageCount: json['pageCount'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? list.length,
      rowCount: json['rowCount'] as int? ?? list.length,
      results: list,
    );
  }

  bool get hasMore => currentPage < pageCount;
}
