import 'package:flutter/material.dart';
import 'package:instg_clone/model/user.dart';
import 'package:instg_clone/services/auth.dart';

class UserProvider with ChangeNotifier {
  User _user = const User(email: "", bio: "", username: "", photoUrl: "", uid: "", followers: [], following: []);
  User get getUser => _user;
  final Authentication _auth = Authentication();

  Future<void> refreshUser() async {
    User user = await _auth.getUserDetails();
    _user = user;
    print("User fetched: $user");
    notifyListeners();
  }
}