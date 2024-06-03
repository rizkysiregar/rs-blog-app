import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_blog_app/core/usecase/usecase.dart';
import 'package:rs_blog_app/feature/movie/data/model/detail_movie.dart';
import 'package:rs_blog_app/feature/movie/data/model/movie.dart';
import 'package:rs_blog_app/feature/movie/domain/usecases/movie_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieUseCase _movieUseCase;
  final DetailMovieUseCase _detailMovieUseCase;

  MovieBloc({
    required MovieUseCase movieUseCase,
    required DetailMovieUseCase detailMovieUseCase,
  })  : _movieUseCase = movieUseCase,
        _detailMovieUseCase = detailMovieUseCase,
        super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      final nowPlayingResult = await _movieUseCase.callNowPlaying(NoParams());
      final popularResult = await _movieUseCase.callPopular(NoParams());
      final upComingResult = await _movieUseCase.callUpComing(NoParams());

      /*
        NOTE: !!
        so it hit the next api if the previous api is success
       */
      nowPlayingResult.fold(
        (failure) =>
            emit(const MovieFailure('Failure to fetch Now Playing movies')),
        (nowPlaying) => popularResult.fold(
          (failure) =>
              emit(const MovieFailure('Failure to fetch Popular movies')),
          (popular) => upComingResult.fold(
            (failure) =>
                emit(const MovieFailure('Failed to fetch upcoming movies')),
            (upcoming) => emit(
              // This will consume bu th block builder, base on movie state, movie state is
              // contains more than one success value
              MovieSuccess(
                nowPlaying: nowPlaying,
                popular: popular,
                upComing: upcoming,
              ),
            ),
          ),
        ),
      );
    });

    on<FetchDetailMovie>((event, emit) async {
      emit(MovieLoading());
      final res =
          await _detailMovieUseCase.call(DetailMovieParams(id: event.id));
      res.fold(
        (l) => emit(DetailMovieFailure(l.message)),
        (r) => emit(DetailMovieSuccess(r)),
      );
    });
  }
}
