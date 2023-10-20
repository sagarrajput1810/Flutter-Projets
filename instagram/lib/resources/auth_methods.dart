import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Authmethods{
  final FirebaseAuth auth = FirebaseAuth.instance;
   Future<String> signUpUser({
    required String email, required String password, required String username,
    required String bio, required Uint8List file,}) async {
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file != null){
        UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      }
    } catch(err){
      res = err.toString();
    }
  }
}










