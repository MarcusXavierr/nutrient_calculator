// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_data_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UploadDataController on _UploadDataControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_UploadDataControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$messageAtom = Atom(name: '_UploadDataControllerBase.message');

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$isLoadedAtom = Atom(name: '_UploadDataControllerBase.isLoaded');

  @override
  bool get isLoaded {
    _$isLoadedAtom.reportRead();
    return super.isLoaded;
  }

  @override
  set isLoaded(bool value) {
    _$isLoadedAtom.reportWrite(value, super.isLoaded, () {
      super.isLoaded = value;
    });
  }

  final _$colorAtom = Atom(name: '_UploadDataControllerBase.color');

  @override
  Color get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(Color value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$_UploadDataControllerBaseActionController =
      ActionController(name: '_UploadDataControllerBase');

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo = _$_UploadDataControllerBaseActionController
        .startAction(name: '_UploadDataControllerBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_UploadDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMessage(String value) {
    final _$actionInfo = _$_UploadDataControllerBaseActionController
        .startAction(name: '_UploadDataControllerBase.setMessage');
    try {
      return super.setMessage(value);
    } finally {
      _$_UploadDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoaded(bool value) {
    final _$actionInfo = _$_UploadDataControllerBaseActionController
        .startAction(name: '_UploadDataControllerBase.setIsLoaded');
    try {
      return super.setIsLoaded(value);
    } finally {
      _$_UploadDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setColor(Color value) {
    final _$actionInfo = _$_UploadDataControllerBaseActionController
        .startAction(name: '_UploadDataControllerBase.setColor');
    try {
      return super.setColor(value);
    } finally {
      _$_UploadDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
message: ${message},
isLoaded: ${isLoaded},
color: ${color}
    ''';
  }
}
