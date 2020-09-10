import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  String get message;
}

class SuccessUpload implements Success {
  final successMessage;

  SuccessUpload({this.successMessage});
  @override
  String get message => successMessage;

  @override
  List<Object> get props => [successMessage];

  @override
  bool get stringify => null;
}

class SuccessDownload implements Success {
  final String successMessage;

  SuccessDownload({this.successMessage});
  @override
  // TODO: implement message
  String get message => successMessage;

  @override
  // TODO: implement props
  List<Object> get props => [successMessage];

  @override
  // TODO: implement stringify
  bool get stringify => null;
}
