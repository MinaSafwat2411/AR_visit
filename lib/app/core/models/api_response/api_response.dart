class ApiResponse<T> {
  final String status;
  final String message;
  final T? data;

  ApiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) create) {
    return ApiResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] != null ? create(json['data']) : null,
    );
  }
}