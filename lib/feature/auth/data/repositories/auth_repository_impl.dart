import 'package:fpdart/fpdart.dart';
import 'package:rs_blog_app/core/error/exceptions.dart';
import 'package:rs_blog_app/core/error/failures.dart';
import 'package:rs_blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rs_blog_app/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
