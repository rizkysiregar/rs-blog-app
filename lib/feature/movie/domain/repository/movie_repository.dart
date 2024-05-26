import 'package:fpdart/fpdart.dart';
import 'package:rs_blog_app/core/error/failures.dart';
import 'package:rs_blog_app/feature/movie/data/model/movie.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, MovieResponse>> nowPlayingMovie();
  Future<Either<Failure, MovieResponse>> popularMovie();
  Future<Either<Failure, MovieResponse>> topRatedMovie();
  Future<Either<Failure, MovieResponse>> upComingMovie();
}
