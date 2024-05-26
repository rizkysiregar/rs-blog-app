import 'package:get_it/get_it.dart';
import 'package:rs_blog_app/core/common/constants/constants.dart';
import 'package:rs_blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:rs_blog_app/core/secrets/app_secrets.dart';
import 'package:rs_blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rs_blog_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:rs_blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:rs_blog_app/feature/auth/domain/usecases/current_user.dart';
import 'package:rs_blog_app/feature/auth/domain/usecases/user_login.dart';
import 'package:rs_blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:rs_blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:rs_blog_app/feature/movie/data/datasources/movie_remote_data_source.dart';
import 'package:rs_blog_app/feature/movie/data/repositories/movie_repository_impl.dart';
import 'package:rs_blog_app/feature/movie/domain/repository/movie_repository.dart';
import 'package:rs_blog_app/feature/movie/domain/usecases/movie_usecase.dart';
import 'package:rs_blog_app/feature/movie/presentation/bloc/movie_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initMovie();
  _initAuth();
  _initDio();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    // Datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )

    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    //Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )

    //Block
    ..registerLazySingleton(
      () => AuthBloc(
        currentUser: serviceLocator(),
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initMovie() {
  serviceLocator
    // data source
    ..registerFactory<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl())

    // repo
    ..registerFactory<MovieRepository>(
        () => MovieRepositoryImpl(serviceLocator()))

    // usecase
    ..registerFactory(
      () => MovieUseCase(
        serviceLocator(),
      ),
    )

    //bloc
    ..registerLazySingleton(
      () => MovieBloc(
        movieUseCase: serviceLocator(),
      ),
    );
}

void _initDio() {
  serviceLocator.registerFactory<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = Constants.baseUrl;
    dio.options.connectTimeout = const Duration(minutes: 2);
    dio.options.receiveTimeout = const Duration(minutes: 2);

    dio.options.headers['Authorization'] = Constants.token;

    return dio;
  });
}
