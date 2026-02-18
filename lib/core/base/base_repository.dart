import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../network/api_error_handler.dart';
import '../network/api_response.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> execute<T>({
    required Future<Map<String, dynamic>> Function() request,
    required T Function(Object? json) mapper,
  }) async {
    try {
      final rawResponse = await request();
      final apiResponse = ApiResponse<T>.fromJson(rawResponse, mapper);
      if (apiResponse.status.toLowerCase() != 'success') {
        return left(ServerFailure(apiResponse.message));
      }
      return right(apiResponse.data);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }
}
