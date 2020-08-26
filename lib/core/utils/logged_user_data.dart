import 'package:equatable/equatable.dart';

class LoggedUserData extends Equatable {
  final String uid;

  LoggedUserData({this.uid});

  @override
  List<Object> get props => [uid];
}
