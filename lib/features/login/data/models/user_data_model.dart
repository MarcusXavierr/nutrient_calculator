import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrients/core/utils/logged_user_data.dart';
import 'package:nutrients/features/login/domain/entities/userData.dart';
import 'package:meta/meta.dart';

class UserDataModel extends LoggedUserData {
  ///Create [LoggedUserData] object based on Firebase User
  factory UserDataModel.fromFirebase(User user) {
    return user != null ? LoggedUserData(uid: user.uid) : null;
  }

  //auth change user stream
  // Stream<UserData> get user {
  //   return _auth.onAuthStateChanged.map((User user) {
  //     return _userFromFirebaseUser(user);
  //   });
  // }
}
