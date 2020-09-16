import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:meta/meta.dart';

typedef Future<UserCredential> _CreateOrLoginWithEmail();
enum Functions {
  createAccount,
  login,
}

abstract class AuthRemoteDataSource {
  ///Call the firebase to log in with email and password
  ///
  ///Throwns a [ServerException] for all error codes.
  ///but Throwns a [FirebaseAuthException] if pass or email are incorrect
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
  ///but Throwns a [FirebaseAuthException] if pass or email are incorrect
  Future<LoggedUserData> signInWithGoogle();

  ///Listen for auth Changes
  Stream<LoggedUserData> get user;
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth auth;

  AuthRemoteDataSourceImpl({@required this.auth});

  Future<LoggedUserData> _authWithEmail(
      _CreateOrLoginWithEmail createOrLogin, Functions type) async {
    try {
      final response = await createOrLogin();
      return LoggedUserData.fromFirebase(response.user);
    } catch (e) {
      if (e.runtimeType == FirebaseAuthException) {
        print(e.toString());
        if (e.toString().contains('too-many-requests')) {
          throw FirebaseAuthException(
              message:
                  ' We have blocked all requests from this device due to unusual activity. Try again later.');
        }
        if (0 == type.index) {
          throw FirebaseAuthException(message: 'This account already exists');
        } else {
          throw FirebaseAuthException(message: 'Wrong email or password');
        }
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<LoggedUserData> createAccountWithEmail(
      {String email, String password}) async {
    return await _authWithEmail(
      () =>
          auth.createUserWithEmailAndPassword(email: email, password: password),
      Functions.createAccount,
    );
  }

  @override
  Future<LoggedUserData> loginWithEmail({String email, String password}) async {
    return await _authWithEmail(
      () => auth.signInWithEmailAndPassword(email: email, password: password),
      Functions.login,
    );
  }

  @override
  Future<LoggedUserData> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential response =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return LoggedUserData.fromFirebase(response.user);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Stream<LoggedUserData> get user => auth
      .authStateChanges()
      .map((User user) => LoggedUserData.fromFirebase(user));
}
