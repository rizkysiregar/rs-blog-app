import 'package:fpdart/fpdart.dart';
import 'package:rs_blog_app/core/error/exceptions.dart';
import 'package:rs_blog_app/core/error/failures.dart';
import 'package:rs_blog_app/feature/movie/data/datasources/movie_remote_data_source.dart';
import 'package:rs_blog_app/feature/movie/data/model/movie.dart';
import 'package:rs_blog_app/feature/movie/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, MovieResponse>> nowPlayingMovie() async {
    try {
      final movie = await remoteDataSource.getNowPlayingMovie();
      return right(movie);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, MovieResponse>> popularMovie() async {
    try {
      final movie = await remoteDataSource.getPopularMovie();
      return right(movie);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, MovieResponse>> topRatedMovie() async {
    try {
      final movie = await remoteDataSource.getTopRatedMovie();
      return right(movie);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, MovieResponse>> upComingMovie() async {
    try {
      final movie = await remoteDataSource.getUpComingMovie();
      return right(movie);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
