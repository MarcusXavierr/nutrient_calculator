import 'package:dartz/dartz.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';

abstract class AuthRepository {
  //Login with email
  Future<Either<Failure, LoggedUserData>> loginWithEmail(
      {String email, String password});
  //Create account with email
  Future<Either<Failure, LoggedUserData>> createAccountWithEmail(
      {String email, String password});
  //Sign in with google
  Future<Either<Failure, LoggedUserData>> signInWithGoogle();
}
