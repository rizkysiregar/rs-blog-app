part of 'movie_bloc.dart';

@immutable
sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

// movie
final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieSuccess extends MovieState {
  final MovieResponse nowPlaying;
  final MovieResponse popular;

  const MovieSuccess({
    required this.nowPlaying,
    required this.popular,
  });

  @override
  List<Object?> get props => [nowPlaying, popular];
}

final class MovieFailure extends MovieState {
  final String message;
  const MovieFailure(this.message);

  @override
  List<Object?> get props => [message];
}
