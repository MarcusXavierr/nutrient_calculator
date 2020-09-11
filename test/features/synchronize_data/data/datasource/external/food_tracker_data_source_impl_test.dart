import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/external/food_tracker_data_source_impl.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_list_database_conn.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockFoodDatabaseConn extends Mock implements FoodDatabaseConn {}

class MockDatabase extends Mock implements Database {}

class MockHasuraConnect extends Mock implements HasuraConnect {}

void main() {
  FoodTrackerDataSourceImpl dataSource;
  MockFoodDatabaseConn mockFoodDatabaseConn;
  MockDatabase mockDatabase;
  MockHasuraConnect mockHasuraConnect;

  setUp(() {
    mockDatabase = MockDatabase();
    mockHasuraConnect = MockHasuraConnect();
    mockFoodDatabaseConn = MockFoodDatabaseConn();
    dataSource = FoodTrackerDataSourceImpl(
      hasuraConnect: mockHasuraConnect,
      foodDatabaseConn: mockFoodDatabaseConn,
    );
  });

  final tUserId = 'userId';
  final tVariables = {"userId": "$tUserId"};
  group('downloadData', () {
    test(
      'should make a request',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenAnswer((_) async => fixture('food_tracker.json'));
        //Act
        dataSource.downloadData(tUserId);
        //Assert
        verify(mockHasuraConnect
            .query(KQueryFoodTracker, variables: {"userId": "$tUserId"}));
      },
    );

    test(
      'should throw a ServerException if happens an error during the connection with hasura',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenThrow(ServerFailure());
        //Act
        final call = dataSource.downloadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<ServerException>()));
      },
    );

    test(
      'should return Success if everything is ok',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenAnswer((_) async => fixture('food_tracker.json'));

        when(mockFoodDatabaseConn.openDatabase(DatabaseName))
            .thenAnswer((_) async => mockDatabase);

        when(mockFoodDatabaseConn.insertNewData(
          db: anyNamed('db'),
          foods: anyNamed('foods'),
        )).thenAnswer((_) async => SuccessDownload());

        //Act
        final result = await dataSource.downloadData(tUserId);

        //Assert
        expect(result, isA<Success>());
      },
    );

    test(
      'Should throw an SQLiteException if any errors happen with the local database',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenAnswer(
          (_) async => fixture('food_tracker.json'),
        );
        when(mockFoodDatabaseConn.openDatabase(any))
            .thenAnswer((_) async => mockDatabase);

        when(mockFoodDatabaseConn.clearDatabase(any)).thenThrow(Exception());
        //Act
        final call = dataSource.downloadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<SQLiteException>()));
      },
    );

    test(
      'Should throw an EmptyDataException if the data that was taken from the hasura is null ',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: tVariables))
            .thenAnswer((_) async => fixture('food_tracker_empty.json'));
        //Act
        final call = dataSource.downloadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<EmptyDataException>()));
      },
    );
  });
}
