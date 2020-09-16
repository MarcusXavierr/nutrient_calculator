import 'dart:convert';

import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/external/food_tracker_data_source_impl.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_database_conn.dart';
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

  final tUserId = 'Meu Id';
  final tVariables = {"userId": "$tUserId"};
  group('downloadData', () {
    test(
      'should make a request',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenAnswer((_) async => json.decode(fixture('food_tracker.json')));
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
            .thenAnswer((_) async => json.decode(fixture('food_tracker.json')));

        when(mockFoodDatabaseConn.open(DatabaseName))
            .thenAnswer((_) async => mockDatabase);

        when(mockFoodDatabaseConn.insertNewData(
          db: anyNamed('db'),
          foods: anyNamed('foods'),
          tableName: anyNamed('tableName'),
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
          (_) async => json.decode(fixture('food_tracker.json')),
        );
        when(mockFoodDatabaseConn.open(any))
            .thenAnswer((_) async => mockDatabase);

        when(mockFoodDatabaseConn.clearDatabase(
                db: anyNamed('db'), tableName: anyNamed('tableName')))
            .thenThrow(Exception());
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
        when(mockHasuraConnect.query(any, variables: tVariables)).thenAnswer(
            (_) async => json.decode(fixture('food_tracker_empty.json')));
        //Act
        final call = dataSource.downloadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<EmptyDataException>()));
      },
    );
  });

  //!
//!
//!
//!
//!
//!
//! NEW GROUP OF TESTS
  group('uploadData', () {
    final List<Map<String, dynamic>> tMapOfFoods = [
      {
        "datetime": "2020-20-12",
        "food_carbo": 15.6,
        "food_fat": 8,
        "food_protein": 10.5,
        "id": 5
      },
      {
        "datetime": "2020-20-12",
        "food_carbo": 15.6,
        "food_fat": 8,
        "food_protein": 10.5,
        "id": 1
      }
    ];

    _connectWithDbAndReturnList() {
      when(mockFoodDatabaseConn.open(DatabaseName)).thenAnswer((_) async {
        print('Open database ok');
        return mockDatabase;
      });
      when(mockFoodDatabaseConn.queryAllData(
              db: mockDatabase, tableName: anyNamed('tableName')))
          .thenAnswer((_) async {
        print('query all data ok');
        return tMapOfFoods;
      });
    }

    test(
      'should get data from database',
      () async {
        // Arrange
        _connectWithDbAndReturnList();
        //Act
        dataSource.uploadData(tUserId);
        //Assert
      },
    );

    test(
      'Should return an SQLiteException if an error occurs when fetching the data',
      () async {
        // Arrange
        when(mockFoodDatabaseConn.open(DatabaseName))
            .thenAnswer((realInvocation) async => mockDatabase);
        when(mockFoodDatabaseConn.queryAllData(
                db: mockDatabase, tableName: anyNamed('tableName')))
            .thenThrow(ServerFailure());
        //Act
        final call = dataSource.uploadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<SQLiteException>()));
      },
    );

    test(
      'should throw EmptyDataException when data from the local database is null',
      () async {
        // Arrange
        when(mockFoodDatabaseConn.open(DatabaseName))
            .thenAnswer((realInvocation) async => mockDatabase);
        when(mockFoodDatabaseConn.queryAllData(
                db: mockDatabase, tableName: anyNamed('tableName')))
            .thenAnswer((_) async => []);
        //Act
        final call = dataSource.uploadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<EmptyDataException>()));
      },
    );

    test(
      'should return Success if the call to HasuraConnect is successful',
      () async {
        // Arrange
        _connectWithDbAndReturnList();
        when(mockHasuraConnect.mutation(KMutationInsertFoodList,
                variables: anyNamed('variables')))
            .thenAnswer((_) async =>
                json.decode(fixture('success_mutation_food_list.json')));
        //Act
        final result = await dataSource.uploadData(tUserId);
        //Assert
        verify(mockHasuraConnect.mutation(KMutationInsertFoodTracker,
            variables: anyNamed('variables')));
        expect(result, isA<SuccessUpload>());
      },
    );

    test(
      'should throw a ServerException if there is a problem with Hasura\'s connection',
      () async {
        // Arrange
        _connectWithDbAndReturnList();
        when(mockHasuraConnect.mutation(KMutationDeleteFoodTracker,
                variables: anyNamed('variables')))
            .thenThrow(ServerFailure());

        //Act
        final call = dataSource.uploadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
