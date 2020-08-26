import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/domain/repositories/auth_repository.dart';
import 'package:nutrients/features/login/domain/usecases/create_account_with_email.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  CreateAccountWithEmail usecase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = CreateAccountWithEmail(mockAuthRepository);
  });

  final String tEmail = 'marcusxavierr123@gmail.com';
  final String tPassword = '123456';
  final LoggedUserData tLoggedUserData = LoggedUserData(uid: 'ksksksks10');

  test(
    'should return LoggedUserData from repository',
    () async {
      // Arrange
      when(mockAuthRepository.createAccountWithEmail(
              email: tEmail, password: tPassword))
          .thenAnswer((_) async => Right(tLoggedUserData));
      //Act
      final response = await usecase.call(email: tEmail, password: tPassword);
      //Assert
      expect(response, Right(tLoggedUserData));
    },
  );
}
