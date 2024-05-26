import 'package:fpdart/fpdart.dart';
import 'package:rs_blog_app/core/error/failures.dart';
import 'package:rs_blog_app/core/usecase/use_case_movie.dart';
import 'package:rs_blog_app/core/usecase/usecase.dart';
import 'package:rs_blog_app/feature/movie/data/model/movie.dart';
import 'package:rs_blog_app/feature/movie/domain/repository/movie_repository.dart';

class MovieUseCase implements UseCaseMovie<MovieResponse, NoParams> {
  final MovieRepository movieRepository;
  MovieUseCase(this.movieRepository);

  @override
  Future<Either<Failure, MovieResponse>> callNowPlaying(NoParams params) async {
    return await movieRepository.nowPlayingMovie();
  }

  @override
  Future<Either<Failure, MovieResponse>> callPopular(NoParams params) async {
    return await movieRepository.popularMovie();
  }
}
