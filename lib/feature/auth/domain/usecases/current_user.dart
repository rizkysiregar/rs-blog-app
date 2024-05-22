import 'package:fpdart/fpdart.dart';
import 'package:rs_blog_app/core/error/failures.dart';
import 'package:rs_blog_app/core/usecase/usecase.dart';
import 'package:rs_blog_app/core/common/entities/user.dart';
import 'package:rs_blog_app/feature/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.currentUser();
  }
}
