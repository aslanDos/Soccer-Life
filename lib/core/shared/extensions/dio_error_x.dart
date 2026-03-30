import 'package:dio/dio.dart';
import 'package:soccer_life/core/errors/exceptions.dart';

extension DioErrorX on DioException {
  AppException toAppException() {
    return _handleDioError(this);
  }
}

AppException _handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkException('Connection timeout');

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;

      if (statusCode == 401) {
        return const UnauthorizedException('Unauthorized');
      }

      if (statusCode == 404) {
        return const NotFoundException('Not found');
      }

      return ServerException('Server error', code: statusCode);

    case DioExceptionType.unknown:
      return const NetworkException('No internet connection');

    default:
      return const ServerException('Unexpected error');
  }
}
