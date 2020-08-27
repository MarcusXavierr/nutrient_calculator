import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:nutrients/features/login/data/repositories/auth_repository_impl.dart';

final String uid = 'ksksksk';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

// ! Mocks of Google sign in

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockGoogleAuthProvider extends Mock implements GoogleAuthProvider {}

class MockGoogleAuthCredential extends Mock implements GoogleAuthCredential {}

class MockMockei extends Mock implements Mockei {}

void main() {
  AuthRemoteDataSourceImpl dataSource;
  MockFirebaseAuth mockFirebaseAuth;
  MockUserCredential mockUserCredential;
  MockUser mockUser;

  // ! Mocks of Google sign in
  MockGoogleSignIn mockGoogleSignIn;
  MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
  MockGoogleAuthCredential mockGoogleAuthCredential;
  MockGoogleSignInAccount mockGoogleSignInAccount;
  MockMockei mockMockei;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthRemoteDataSourceImpl(auth: mockFirebaseAuth);
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();

    // ! Mocks of Google sign in
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    mockGoogleAuthCredential = MockGoogleAuthCredential();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockMockei = MockMockei();
    //mockGoogleAuthProvider = MockGoogleAuthProvider;
  });
  final String tEmail = 'marcusxavierr123@gmail.com';
  final String tPassword = '123456';
  final LoggedUserData tLoggedUserData = LoggedUserData(uid: uid);
  group('createAccountWithEmail', () {
    test(
      'should make a request to create account in firebase auth, with correct fields',
      () async {
        // Arrange
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
                email: tEmail, password: tPassword))
            .thenAnswer((_) async => mockUserCredential);
        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockUser.uid).thenReturn(uid);
        //Act
        final result = await dataSource.createAccountWithEmail(
            email: tEmail, password: tPassword);
        //Assert
        verify(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tEmail, password: tPassword));
        expect(result, tLoggedUserData);
      },
    );

    test(
      'should return ServerFailure if occurs a error',
      () async {
        // Arrange
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
                email: tEmail, password: tPassword))
            .thenThrow(ServerException());

        //Act
        final call = dataSource.createAccountWithEmail;
        //Assert
        expect(() => call(email: tEmail, password: tPassword),
            throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  //!
  //!
  //!
  //!
  //! NEW GROUP

  group('createAccountWithEmail', () {
    test(
      'should make a request to login in firebase auth, with correct fields',
      () async {
        // Arrange
        when(mockFirebaseAuth.signInWithEmailAndPassword(
                email: tEmail, password: tPassword))
            .thenAnswer((_) async => mockUserCredential);
        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockUser.uid).thenReturn(uid);
        //Act
        final result =
            await dataSource.loginWithEmail(email: tEmail, password: tPassword);
        //Assert
        verify(mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail, password: tPassword));
        expect(result, tLoggedUserData);
      },
    );

    test(
      'should return ServerFailure if occurs a error',
      () async {
        // Arrange
        when(mockFirebaseAuth.signInWithEmailAndPassword(
                email: tEmail, password: tPassword))
            .thenThrow(ServerException());

        //Act
        final call = dataSource.loginWithEmail;
        //Assert
        expect(() => call(email: tEmail, password: tPassword),
            throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  //!
  //!
  //!
  //!
  //! NEW GROUP

  group('signInWithGoogle', () {
    //final tIdToken = 'id';
    //final tAccesToken = 'access';
    // test(
    //   'should make a request to sign in with google and return an credential',
    //   () async {
    //     // Arrange
    //     when(mockGoogleSignIn.signIn())
    //         .thenAnswer((_) async => mockGoogleSignInAccount);
    //     when(mockGoogleSignInAccount.authentication)
    //         .thenAnswer((_) async => mockGoogleSignInAuthentication);
    //     when(mockGoogleSignInAuthentication.accessToken)
    //         .thenReturn(tAccesToken);
    //     when(mockGoogleSignInAuthentication.idToken).thenReturn(tIdToken);
    //     when(mockMockei.meuMetodo()).thenReturn(mockGoogleAuthCredential);

    //     when(mockFirebaseAuth.signInWithCredential(mockGoogleAuthCredential))
    //         .thenAnswer((_) async => mockUserCredential);
    //     //Act
    //     final result = await dataSource.signInWithGoogle();
    //     //Assert
    //     expect(result, tLoggedUserData);
    //   },
    // );

    test(
      'should return ServerFailure if occurs a error',
      () async {
        // Arrange
        when(mockFirebaseAuth.signInWithCredential(any))
            .thenThrow(ServerException());

        //Act
        final call = dataSource.signInWithGoogle;
        //Assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
