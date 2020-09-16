import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';

final Color kPrimaryColor = Colors.blue.shade700;

final Color kErrorColor = Colors.red;

const TextStyle kCarouselValueTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 80.0,
);

const TextStyle kCarouselGTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25.0,
);

const TextStyle kCarouselTextTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 28.0,
);

const TextStyle kLargeButtonTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  hintText: 'Forgot .copyWith()',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const double kSizedBoxHeight = 10;

final CarouselOptions kCarouselSliderOptions = CarouselOptions(
  disableCenter: false,
  height: 200,
  aspectRatio: 2.0,
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 3),
  autoPlayAnimationDuration: Duration(milliseconds: 800),
  autoPlayCurve: Curves.fastOutSlowIn,
);

const String DatabaseName = 'food_database.db';

const String HasuraUrl =
    'https://hasura-on-postgresql.herokuapp.com/v1/graphql';

const String KQueryFoodTracker = '''
  query FoodTrackerQuery(\$userId: String!) {
    food_tracker(where: {user_id: {_eq: \$userId}}){
      food_fat
      food_carbo
      food_protein
      datetime
    }
  }
''';

const String KQueryFoodList = '''
    query MyQuery(\$userId: String!) {
                food_list(where: {user_id: {_eq: \$userId}}){
                  carbo
                  protein
                  name
                  fat
                  
                }
              }
  ''';

const String KMutationInsertFoodList = '''
    mutation InsertFood(\$carbo: float8!, \$fat: float8!, \$name: String!, \$protein: float8!, \$user_id: String!) {
      insert_food_list(objects: {carbo: \$carbo, fat: \$fat, name: \$name, protein: \$protein, user_id: \$user_id}) {
        affected_rows
      }
    }

''';

const String KMutationDeleteFoodList = '''
  mutation Delete(\$userId: String!) {
    delete_food_list(where: {user_id: {_eq: \$userId}}){
      affected_rows
    }
  }

''';

const String KMutationDeleteFoodTracker = '''
      mutation DeleteFoodTracker(\$userId: String!) {
        delete_food_tracker(where: {user_id: {_eq: \$userId}}){
          affected_rows
        }
      }
''';

const String KMutationInsertFoodTracker = '''
    mutation InsertFoodTracker(\$datetime: String!, \$food_carbo: float8!, \$food_fat: float8!, \$food_protein: float8!, \$user_id: String!) {
      insert_food_tracker(objects: {datetime: \$datetime, food_carbo: \$food_carbo, food_fat: \$food_fat, food_protein: \$food_protein, user_id: \$user_id}){
        affected_rows
      }
    }

''';
