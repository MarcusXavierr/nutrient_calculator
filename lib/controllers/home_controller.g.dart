// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$_foodsAtom = Atom(name: '_HomeControllerBase._foods');

  @override
  List<FoodModel> get _foods {
    _$_foodsAtom.reportRead();
    return super._foods;
  }

  @override
  set _foods(List<FoodModel> value) {
    _$_foodsAtom.reportWrite(value, super._foods, () {
      super._foods = value;
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

    ''';
  }
}
