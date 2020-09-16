import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/constants.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/external/food_list_data_source_impl.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_database_conn.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockFoodListDatabaseConn extends Mock implements FoodDatabaseConn {}

class MockDatabase extends Mock implements Database {}

class MockHasuraConnect extends Mock implements HasuraConnect {}

void main() {
  FoodListDataSourceImpl dataSource;
  MockFoodListDatabaseConn mockFoodListDatabaseConn;
  MockHasuraConnect mockHasuraConnect;

  MockDatabase mockDatabase;

  setUp(() {
    mockHasuraConnect = MockHasuraConnect();

    mockFoodListDatabaseConn = MockFoodListDatabaseConn();
    dataSource = FoodListDataSourceImpl(
      foodListTableConn: mockFoodListDatabaseConn,
      hasuraConnect: mockHasuraConnect,
    );

    mockDatabase = MockDatabase();
  });

  final tUserId = 'Marcus';
  final tVariables = {"userId": "$tUserId"};

  group('downloadData', () {
    test(
      'should make a query to hasura successfully with the correct header',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenAnswer(
          (_) async => json.decode(fixture('food_list.json')),
        );
        //Act
        dataSource.downloadData(tUserId);
        //Assert
        verify(mockHasuraConnect
            .query(KQueryFoodList, variables: {"userId": "$tUserId"}));
      },
    );

    test(
      'should throw a ServerException if tha call has an error',
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
      'should return Success',
      () async {
        //Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenAnswer(
          (_) async => json.decode(fixture('food_list.json')),
        );

        when(mockFoodListDatabaseConn.open(any)).thenAnswer((_) async {
          print('entrei no openDatabase');
          return mockDatabase;
        });
        when(mockFoodListDatabaseConn.insertNewData(
                db: anyNamed('db'),
                foods: anyNamed('foods'),
                tableName: anyNamed('tableName')))
            .thenAnswer((_) async {
          print('entrei no insertNewData');
          return SuccessDownload();
        });
        //Act
        final result = await dataSource.downloadData(tUserId);

        //Assert
        expect(result, isA<Success>());
      },
    );

    test(
      'should throw an exception if any erro occur in database connection',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenAnswer(
          (_) async => json.decode(fixture('food_list.json')),
        );
        when(mockFoodListDatabaseConn.open(any))
            .thenAnswer((_) async => mockDatabase);
        when(mockFoodListDatabaseConn.clearDatabase(
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
            (_) async => json.decode(fixture('food_list_empty.json')));

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
      {"id": 1, "name": "seila", "carbo": 12.2, "protein": 12.0, "fat": 13.0},
      {"id": 2, "name": "alimento2", "carbo": 15.0, "protein": 12.0, "fat": 1.0}
    ];

    _connectWithDbAndReturnList() {
      when(mockFoodListDatabaseConn.open(DatabaseName)).thenAnswer((_) async {
        print('Open database ok');
        return mockDatabase;
      });
      when(mockFoodListDatabaseConn.queryAllData(
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
      'should throw EmptyDataException when data from the local database is null',
      () async {
        // Arrange
        when(mockFoodListDatabaseConn.open(DatabaseName))
            .thenAnswer((realInvocation) async => mockDatabase);
        when(mockFoodListDatabaseConn.queryAllData(
                db: mockDatabase, tableName: anyNamed('tableName')))
            .thenAnswer((_) async => []);
        //Act
        final call = dataSource.uploadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<EmptyDataException>()));
      },
    );

    test(
      'Should return an SQLiteException if an error occurs when fetching the data',
      () async {
        // Arrange
        when(mockFoodListDatabaseConn.open(DatabaseName))
            .thenAnswer((realInvocation) async => mockDatabase);
        when(mockFoodListDatabaseConn.queryAllData(
                db: mockDatabase, tableName: anyNamed('tableName')))
            .thenThrow(ServerFailure());
        //Act
        final call = dataSource.uploadData;
        //Assert
        expect(() => call(tUserId), throwsA(TypeMatcher<SQLiteException>()));
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
        verify(mockHasuraConnect.mutation(KMutationInsertFoodList,
            variables: anyNamed('variables')));
        expect(result, isA<SuccessUpload>());
      },
    );

    test(
      'should throw a ServerException if there is a problem with Hasura\'s connection',
      () async {
        // Arrange
        _connectWithDbAndReturnList();
        when(mockHasuraConnect.mutation(KMutationDeleteFoodList,
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
