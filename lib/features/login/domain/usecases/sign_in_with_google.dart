import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<Either<Failure, LoggedUserData>> call() async {
    return await repository.signInWithGoogle();
  }
}
