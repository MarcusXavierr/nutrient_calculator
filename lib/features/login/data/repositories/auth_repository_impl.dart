import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/network/network_info.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:nutrients/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:nutrients/features/login/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

typedef Future<LoggedUserData> _CreateOrLogin();

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.authRemoteDataSource,
    @required this.networkInfo,
  });

  Future<Either<Failure, LoggedUserData>> _authFunction(
      _CreateOrLogin createAccountOrLoginWithEmail) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      LoggedUserData response = await createAccountOrLoginWithEmail();
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(myMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, LoggedUserData>> createAccountWithEmail(
      {@required String email, @required String password}) async {
    return await _authFunction(
        () => authRemoteDataSource.createAccountWithEmail(
              email: email,
              password: password,
            ));
  }

  @override
  Future<Either<Failure, LoggedUserData>> loginWithEmail(
      {@required String email, @required String password}) async {
    return await _authFunction(() =>
        authRemoteDataSource.loginWithEmail(email: email, password: password));
  }

  @override
  Future<Either<Failure, LoggedUserData>> signInWithGoogle() async {
    return await _authFunction(() => authRemoteDataSource.signInWithGoogle());
  }
}
