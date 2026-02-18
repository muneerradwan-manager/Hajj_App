class ApiResponse<T> {
  final String status;
  final String message;
  final T data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) mapper,
  ) {
    return ApiResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: mapper(json['data']),
    );
  }
}
