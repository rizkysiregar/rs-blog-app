import 'package:get_it/get_it.dart';
import 'package:rs_blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:rs_blog_app/core/secrets/app_secrets.dart';
import 'package:rs_blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rs_blog_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:rs_blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:rs_blog_app/feature/auth/domain/usecases/current_user.dart';
import 'package:rs_blog_app/feature/auth/domain/usecases/user_login.dart';
import 'package:rs_blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:rs_blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
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
