import 'package:soccer_life/core/errors/exceptions.dart';
import 'package:soccer_life/core/errors/failures.dart';

Failure mapExceptionToFailure(Exception e) {
  if (e is ServerException) {
    return ServerFailure(e.message, code: e.code);
  }

  if (e is CacheException) {
    return CacheFailure(e.message);
  }

  if (e is NetworkException) {
    return NetworkFailure(e.message);
  }

  if (e is UnauthorizedException) {
    return UnauthorizedFailure(e.message);
  }

  if (e is NotFoundException) {
    return ServerFailure(e.message);
  }

  return ServerFailure('Unexpected error');
}
