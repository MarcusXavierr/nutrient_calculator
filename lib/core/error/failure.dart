import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Failure extends Equatable {
  String get message;
}

// * General Failures
class ServerFailure extends Failure {
  final String _message = 'Server error, please try again later';
  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class AuthFailure extends Failure {
  final String myMessage;

  AuthFailure({@required this.myMessage});
  @override
  String get message => myMessage;

  @override
  List<Object> get props => [myMessage];
}

// ! Call if device is offline and need to be online
class NetworkFailure extends Failure {
  final String _message = 'You are not connected to the internet';

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class SQLiteFailure extends Failure {
  final String _message = 'Error in local database';

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class EmptyDataFailure extends Failure {
  final String systemMessage;

  EmptyDataFailure(this.systemMessage);

  @override
  String get message => systemMessage;

  @override
  List<Object> get props => [systemMessage];
}
