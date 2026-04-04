import '../utils/import.dart';
class Result<T> {
  final T? data;
  final String? error;
  final int? statusCode;
  const Result._({this.data, this.error, this.statusCode});
  factory Result.success(T data, [int? statusCode]) =>
      Result._(data: data, statusCode: statusCode);
  factory Result.error(String error, [int? statusCode]) {
    Get.find<ToastService>().show(message: error, type: ToastType.error);
    return Result._(error: error, statusCode: statusCode);
  }
  bool get isSuccess => data != null;
  bool get isError => error != null;
  void when({
    required void Function(T data) success,
    required void Function(String error, int? statusCode) error,
  }) {
    final value = data;
    if (value != null) {
      success(value);
    } else {
      error(this.error ?? 'Unknown error', statusCode);
    }
  }
  Result<R> map<R>(R Function(T data) transform) {
    final value = data;
    if (value != null) {
      return Result.success(transform(value), statusCode);
    } else {
      return Result.error(error ?? 'Unknown error', statusCode);
    }
  }
  @override
  String toString() =>
      isSuccess ? '✅ Success: $data' : '❌ Error ($statusCode): $error';
}
