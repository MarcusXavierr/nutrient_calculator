import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/domain/repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository authRepository;

  LoginWithEmail(this.authRepository);

  Future<Either<Failure, LoggedUserData>> call({
    String email,
    String password,
  }) async {
    return await authRepository.loginWithEmail(
      email: email,
      password: password,
    );
  }
}
