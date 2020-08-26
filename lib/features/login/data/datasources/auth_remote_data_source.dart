import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:meta/meta.dart';
import 'package:nutrients/features/login/data/models/user_data_model.dart';

abstract class AuthRemoteDataSource {
  ///Call the firebase to log in with email and password
  ///
  ///Throwns a [ServerException] for all error codes.
  Future<LoggedUserData> loginWithEmail({
    @required String email,
    @required String password,
  });

  ///Call the firebase to create a account with email and password
  ///
  ///Throws a [ServerException] for all error codes
  Future<LoggedUserData> createAccountWithEmail({
    @required String email,
    @required String password,
  });

  ///Call the firebase to Sign in with Google
  ///
  ///Throwns a [ServerException] for all error codes
  Future<LoggedUserData> signInWithGoogle();

  ///Listen for auth Changes
  Stream<LoggedUserData> get user;
}

// FirebaseAuth auth = FirebaseAuth.instance;
// get user {
//   return auth
//       .authStateChanges()
//       .map((User user) => UserDataModel.fromFirebase(user));
// }
