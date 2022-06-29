import 'package:flutter/material.dart';
import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Authmethod _authmethod = Authmethod();

  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authmethod.getUserdetails();

    _user = user;
    notifyListeners();
  }
}
