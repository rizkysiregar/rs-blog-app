import 'package:dio/dio.dart';
import 'package:rs_blog_app/core/error/exceptions.dart';
import 'package:rs_blog_app/feature/movie/data/model/movie.dart';
import 'package:rs_blog_app/init_dependencies.dart';

abstract interface class MovieRemoteDataSource {
  Future<MovieResponse> getNowPlayingMovie();
  Future<MovieResponse> getPopularMovie();
  Future<MovieResponse> getTopRatedMovie();
  Future<MovieResponse> getUpComingMovie();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio _dio = serviceLocator<Dio>();

  @override
  Future<MovieResponse> getNowPlayingMovie() async {
    // return _getMovies('movie/now_playing');
    try {
      final response = await _dio.get('movie/now_playing');
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<MovieResponse> getPopularMovie() async {
    //return _getMovies('movie/popular');
    try {
      print("popular masuk data source");
      final response = await _dio.get('movie/popular');
      print("popular: " + response.data.toString());
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MovieResponse> getTopRatedMovie() async {
    return _getMovies('movie/top_rated');
    // try {
    //   final response = await _dio.get('movie/top_rated');
    //   if (response.statusCode == 200) {
    //     return MovieResponse.fromJson(response.data);
    //   } else {
    //     throw Exception('Failed to load movie');
    //   }
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }

  @override
  Future<MovieResponse> getUpComingMovie() async {
    return _getMovies('movie/upcoming');
    // try {
    //   final response = await _dio.get('movie/upcoming');
    //   if (response.statusCode == 200) {
    //     return MovieResponse.fromJson(response.data);
    //   } else {
    //     throw Exception('Failed to load movie');
    //   }
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }

  Future<MovieResponse> _getMovies(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
