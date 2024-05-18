import 'package:get_it/get_it.dart';
import 'package:rs_blog_app/core/secrets/app_secrets.dart';
import 'package:rs_blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rs_blog_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:rs_blog_app/feature/auth/domain/repository/auth_repository.dart';
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
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
