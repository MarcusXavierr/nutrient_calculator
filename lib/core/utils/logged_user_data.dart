import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoggedUserData extends Equatable {
  final String uid;

  LoggedUserData({this.uid});

  @override
  List<Object> get props => [uid];

  ///Create [LoggedUserData] object based on Firebase User
  factory LoggedUserData.fromFirebase(User user) {
    return user != null ? LoggedUserData(uid: user.uid) : null;
  }
}
