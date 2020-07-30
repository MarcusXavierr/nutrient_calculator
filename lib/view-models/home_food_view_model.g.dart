// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_food_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeFoodViewModel on _HomeFoodViewModelBase, Store {
  final _$_proteinAtom = Atom(name: '_HomeFoodViewModelBase._protein');

  @override
  int get _protein {
    _$_proteinAtom.reportRead();
    return super._protein;
  }

  @override
  set _protein(int value) {
    _$_proteinAtom.reportWrite(value, super._protein, () {
      super._protein = value;
    });
  }

  final _$_carboAtom = Atom(name: '_HomeFoodViewModelBase._carbo');

  @override
  int get _carbo {
    _$_carboAtom.reportRead();
    return super._carbo;
  }

  @override
  set _carbo(int value) {
    _$_carboAtom.reportWrite(value, super._carbo, () {
      super._carbo = value;
    });
  }

  final _$_fatAtom = Atom(name: '_HomeFoodViewModelBase._fat');

  @override
  int get _fat {
    _$_fatAtom.reportRead();
    return super._fat;
  }

  @override
  set _fat(int value) {
    _$_fatAtom.reportWrite(value, super._fat, () {
      super._fat = value;
    });
  }

  final _$_HomeFoodViewModelBaseActionController =
      ActionController(name: '_HomeFoodViewModelBase');

  @override
  dynamic setProtein(double value) {
    final _$actionInfo = _$_HomeFoodViewModelBaseActionController.startAction(
        name: '_HomeFoodViewModelBase.setProtein');
    try {
      return super.setProtein(value);
    } finally {
      _$_HomeFoodViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCarbo(double value) {
    final _$actionInfo = _$_HomeFoodViewModelBaseActionController.startAction(
        name: '_HomeFoodViewModelBase.setCarbo');
    try {
      return super.setCarbo(value);
    } finally {
      _$_HomeFoodViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFat(double value) {
    final _$actionInfo = _$_HomeFoodViewModelBaseActionController.startAction(
        name: '_HomeFoodViewModelBase.setFat');
    try {
      return super.setFat(value);
    } finally {
      _$_HomeFoodViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
