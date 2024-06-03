part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieEvent {}

class FetchDetailMovie extends MovieEvent {
  final int id;

  FetchDetailMovie({required this.id});
}
