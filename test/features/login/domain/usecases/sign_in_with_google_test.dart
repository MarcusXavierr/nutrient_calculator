import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/domain/repositories/auth_repository.dart';
import 'package:nutrients/features/login/domain/usecases/create_account_with_email.dart';
import 'package:nutrients/features/login/domain/usecases/sign_in_with_google.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  SignInWithGoogle usecase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInWithGoogle(mockAuthRepository);
  });

  final LoggedUserData tLoggedUserData = LoggedUserData(uid: 'ksksksks10');
  test(
    'should return LoggedUserData from repository',
    () async {
      // Arrange
      when(mockAuthRepository.signInWithGoogle())
          .thenAnswer((_) async => Right(tLoggedUserData));
      //Act
      final response = await usecase.call();
      //Assert
      expect(response, Right(tLoggedUserData));
    },
  );
}
