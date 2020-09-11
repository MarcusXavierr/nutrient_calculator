import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mockito/mockito.dart';
import 'package:nutrients/core/error/exceptions.dart';
import 'package:nutrients/core/error/failure.dart';
import 'package:nutrients/core/utils/success.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/food_list_data_source.dart';
import 'package:nutrients/features/synchronize_data/data/datasource/local_storage/food_list_database_conn.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../fixtures/fixture_reader.dart';

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

  final tUserId = 'userId';
  final tVariables = {"userId": "$tUserId"};
  final tQuery = '''
    query MyQuery(\$userId: String!) {
                food_list(where: {user_id: {_eq: \$userId}}){
                  carbo
                  protein
                  name
                  fat
                  
                }
              }
  ''';

  group('downloadData', () {
    test(
      'should make a query to hasura successfully with the correct header',
      () async {
        // Arrange
        when(mockHasuraConnect.query(any, variables: {"userId": "$tUserId"}))
            .thenAnswer(
          (_) async => fixture('food_list.json'),
        );
        //Act
        dataSource.downloadData(tUserId);
        //Assert
        verify(
            mockHasuraConnect.query(tQuery, variables: {"userId": "$tUserId"}));
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
          (_) async => fixture('food_list.json'),
        );

        when(mockFoodListDatabaseConn.openDatabase(any)).thenAnswer((_) async {
          print('entrei no openDatabase');
          return mockDatabase;
        });
        when(mockFoodListDatabaseConn.insertNewData(
                db: anyNamed('db'), foods: anyNamed('foods')))
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
          (_) async => fixture('food_list.json'),
        );
        when(mockFoodListDatabaseConn.openDatabase(any))
            .thenAnswer((_) async => mockDatabase);
        when(mockFoodListDatabaseConn.clearDatabase(any))
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
        when(mockHasuraConnect.query(any, variables: tVariables))
            .thenAnswer((_) async => fixture('food_list_empty.json'));
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
  group('uploadData', () {});
}
