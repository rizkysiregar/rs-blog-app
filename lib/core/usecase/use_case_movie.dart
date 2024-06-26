import 'package:fpdart/fpdart.dart';
import 'package:rs_blog_app/core/error/failures.dart';

abstract interface class UseCaseMovie<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> callNowPlaying(Params params);
  Future<Either<Failure, SuccessType>> callPopular(Params params);
  Future<Either<Failure, SuccessType>> callUpComing(Params params);
}

abstract interface class UseCaseDetailMovie<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
