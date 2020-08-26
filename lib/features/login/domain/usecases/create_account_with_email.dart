import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/domain/repositories/auth_repository.dart';

class CreateAccountWithEmail {
  final AuthRepository repository;

  CreateAccountWithEmail(this.repository);

  Future<Either<Failure, LoggedUserData>> call(
      {String email, String password}) async {
    return await repository.createAccountWithEmail(
        email: email, password: password);
  }
}
