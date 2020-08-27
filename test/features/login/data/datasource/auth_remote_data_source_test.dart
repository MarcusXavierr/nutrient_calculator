import 'package:firebase_auth/firebase_auth.dart';
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

void main() {
  AuthRemoteDataSourceImpl dataSource;
  MockFirebaseAuth mockFirebaseAuth;
  MockUserCredential mockUserCredential;
  MockUser mockUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthRemoteDataSourceImpl(auth: mockFirebaseAuth);
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
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

  gr
}
