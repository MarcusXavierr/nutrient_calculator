import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/network/network_info.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:nutrients/features/login/data/repositories/auth_repository_impl.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AuthRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    repository = AuthRepositoryImpl(
      authRemoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final String tEmail = 'marcusxavierr123@gmail.com';
  final String tPassword = '123456';
  final tLoggedUserData = LoggedUserData(uid: 'ksksksksk10');

  void runTestsOnline(Function body) {
    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group('createAccountWithEmail', () {
    test(
      'should check if device is online',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //Act
        repository.createAccountWithEmail(email: tEmail, password: tPassword);
        //Assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return Failure if device is offline',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        //Act
        final response = await repository.createAccountWithEmail(
            email: tEmail, password: tPassword);
        //Assert
        verify(mockNetworkInfo.isConnected);
        expect(response, equals(Left(NetworkFailure())));
      },
    );

    runTestsOnline(() {
      test(
        'should return LoggedUser when the call is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.createAccountWithEmail(
                  email: tEmail, password: tPassword))
              .thenAnswer((_) async => tLoggedUserData);
          //Act
          final result = await repository.createAccountWithEmail(
              email: tEmail, password: tPassword);
          //Assert
          verify(mockRemoteDataSource.createAccountWithEmail(
              email: tEmail, password: tPassword));
          expect(result, Right(tLoggedUserData));
        },
      );

      test(
        'should return ServerFailure when occur and error in server',
        () async {
          // Arrange
          when(mockRemoteDataSource.createAccountWithEmail(
                  email: tEmail, password: tPassword))
              .thenThrow(ServerException());
          //Act
          final result = await repository.createAccountWithEmail(
              email: tEmail, password: tPassword);
          //Assert
          verify(mockRemoteDataSource.createAccountWithEmail(
              email: tEmail, password: tPassword));
          expect(result, Left(ServerFailure()));
        },
      );
    });
  });

  //!
  //!
  //!
  //! New Group of tests

  group('loginWithEmail', () {
    test(
      'should check if device is online',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //Act
        repository.loginWithEmail(email: tEmail, password: tPassword);
        //Assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return Failure if device is offline',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        //Act
        final response =
            await repository.loginWithEmail(email: tEmail, password: tPassword);
        //Assert
        verify(mockNetworkInfo.isConnected);
        expect(response, equals(Left(NetworkFailure())));
      },
    );

    runTestsOnline(() {
      test(
        'should return LoggedUser when the call is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.loginWithEmail(
                  email: tEmail, password: tPassword))
              .thenAnswer((_) async => tLoggedUserData);
          //Act
          final result = await repository.loginWithEmail(
              email: tEmail, password: tPassword);
          //Assert
          verify(mockRemoteDataSource.loginWithEmail(
              email: tEmail, password: tPassword));
          expect(result, Right(tLoggedUserData));
        },
      );

      test(
        'should return ServerFailure when occur and error in server',
        () async {
          // Arrange
          when(mockRemoteDataSource.loginWithEmail(
                  email: tEmail, password: tPassword))
              .thenThrow(ServerException());
          //Act
          final result = await repository.loginWithEmail(
              email: tEmail, password: tPassword);
          //Assert
          verify(mockRemoteDataSource.loginWithEmail(
              email: tEmail, password: tPassword));
          expect(result, Left(ServerFailure()));
        },
      );
    });
  });

  //!
  //!
  //!
  //!
  //! New Group of tests

  group('signInWithGoogle', () {
    test(
      'should check if device is online',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //Act
        repository.signInWithGoogle();
        //Assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return Failure if device is offline',
      () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        //Act
        final response = await repository.signInWithGoogle();
        //Assert
        verify(mockNetworkInfo.isConnected);
        expect(response, equals(Left(NetworkFailure())));
      },
    );

    runTestsOnline(() {
      test(
        'should return LoggedUser when the call is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.signInWithGoogle())
              .thenAnswer((_) async => tLoggedUserData);
          //Act
          final result = await repository.signInWithGoogle();
          //Assert
          verify(mockRemoteDataSource.signInWithGoogle());
          expect(result, Right(tLoggedUserData));
        },
      );

      test(
        'should return ServerFailure when occur and error in server',
        () async {
          // Arrange
          when(mockRemoteDataSource.signInWithGoogle())
              .thenThrow(ServerException());
          //Act
          final result = await repository.signInWithGoogle();
          //Assert
          verify(mockRemoteDataSource.signInWithGoogle());
          expect(result, Left(ServerFailure()));
        },
      );
    });
  });
}
