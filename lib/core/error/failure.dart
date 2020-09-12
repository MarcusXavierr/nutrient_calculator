import 'package:equatable/equatable.dart';

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
  final String _message = 'Wrong email or password';
  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
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
