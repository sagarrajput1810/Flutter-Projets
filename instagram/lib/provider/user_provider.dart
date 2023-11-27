
import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
  // final List<dynamic>ls=[];
  Users? _users;
  final Authmethods _authmethods = Authmethods();
  Users get getUser {
    // if(_users==null){
    //   return Users(email: "email", uid: "id", photoUrl: "photoUrl", username: "username", bio: "bio", followers: ls, following: ls);
    // }
    return _users!;
  }
  
  Future<void> refreshUser() async {

    _users = await _authmethods.getUserDetails();

    notifyListeners();


  }

}










