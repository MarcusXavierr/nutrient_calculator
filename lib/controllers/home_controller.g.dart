// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$foodsAtom = Atom(name: '_HomeControllerBase.foods');

  @override
  List<FoodModel> get foods {
    _$foodsAtom.reportRead();
    return super.foods;
  }

  @override
  set foods(List<FoodModel> value) {
    _$foodsAtom.reportWrite(value, super.foods, () {
      super.foods = value;
    });
  }

  final _$getFoodsAsyncAction = AsyncAction('_HomeControllerBase.getFoods');

  @override
  Future<void> getFoods() {
    return _$getFoodsAsyncAction.run(() => super.getFoods());
  }

  @override
  String toString() {
    return '''
foods: ${foods}
    ''';
  }
}