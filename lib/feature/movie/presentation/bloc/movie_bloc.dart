import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_blog_app/core/usecase/usecase.dart';
import 'package:rs_blog_app/feature/movie/data/model/movie.dart';
import 'package:rs_blog_app/feature/movie/domain/usecases/movie_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieUseCase _movieUseCase;

  MovieBloc({required MovieUseCase movieUseCase})
      : _movieUseCase = movieUseCase,
        super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      final nowPlayingResult = await _movieUseCase.callNowPlaying(NoParams());
      final popularResult = await _movieUseCase.callPopular(NoParams());

      nowPlayingResult.fold(
        (failure) =>
            emit(const MovieFailure('Failure to fetch Now Playing movies')),
        (nowPlaying) => popularResult.fold(
          (failure) =>
              emit(const MovieFailure('Failure to fetch Popular movies')),
          (popular) => emit(
            MovieSuccess(
              nowPlaying: nowPlaying,
              popular: popular,
            ),
          ),
        ),
      );
    });

    // on<MovieEvent>((_, emit) => emit(MovieLoading()));

    // on<NowPlayingMovieEvent>(_nowPlaying);
    // on<PopularMovieEvent>(_popular);
    // on<TopRatedMovieEvent>(_topRated);
    // on<UpComingMovieEvent>(_upComing);
  }

  // void _nowPlaying(NowPlayingMovieEvent event, Emitter<MovieState> emit) async {
  //   emit(NowPlayingLoading());
  //   final res = await _nowPlayingMovie.call(NoParams());

  //   res.fold(
  //     (l) => emit(NowPlayingFailure(l.message)),
  //     (r) => emit(NowPlayingSuccess(r)),
  //   );
  // }

  // void _popular(PopularMovieEvent event, Emitter<MovieState> emit) async {
  //   emit(PopularLoading());
  //   final res = await _popularMovie.call(NoParams());

  //   res.fold(
  //     (l) => emit(PopularFailure(l.message)),
  //     (r) => emit(PopularSuccess(r)),
  //   );
  // }

  // void _topRated(TopRatedMovieEvent event, Emitter<MovieState> emit) async {
  //   final res = await _topRatedMovie.call(NoParams());

  //   res.fold(
  //     (l) => emit(MovieFailure(l.message)),
  //     (r) => emit(MovieSuccess(r)),
  //   );
  // }

  // void _upComing(UpComingMovieEvent event, Emitter<MovieState> emit) async {
  //   final res = await _upCommingMovie.call(NoParams());

  //   res.fold(
  //     (l) => emit(MovieFailure(l.message)),
  //     (r) => emit(MovieSuccess(r)),
  //   );
  // }
}
