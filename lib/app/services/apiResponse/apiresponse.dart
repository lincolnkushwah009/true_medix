class ApiResponse<T> {
  T data;
  int statusCode;
  ApiResponse({required this.data, required this.statusCode});
}
