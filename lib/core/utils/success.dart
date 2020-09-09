import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  String get message;
}

class SuccessUpload implements Success {
  final _message;

  SuccessUpload(this._message);
  @override
  // TODO: implement message
  String get message => _message;

  @override
  // TODO: implement props
  List<Object> get props => [_message];

  @override
  // TODO: implement stringify
  bool get stringify => null;
}
