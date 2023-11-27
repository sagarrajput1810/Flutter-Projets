import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/resources/storage_methods.dart';
class Authmethods{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Users> getUserDetails() async{
    User currentUser = auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection('users').
    doc(currentUser.uid).get();
    return Users.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email, required String password, required String username,
    required String bio, required Uint8List file}) async {
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty ||
          bio.isNotEmpty || Uint8List != null){

        //register user
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Upload profile picture
        String photoUrl = await StorageMethod()
            .uploadImageToStorage('profilePics', file, false);


        // add details of user in data base
          Users user = Users(email: email, uid: cred.user!.uid,
              photoUrl: photoUrl,
              username: username,
              bio: bio, followers: [], following: []);
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        res = "success";
      }
    } on FirebaseAuthException catch(err){
    if(err.code=='invalid-email'){
    res='You enter a wrong Email';
    }
    else if (err.code=='weak-password'){
    res='Your password at least of 6 words';
    }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
  // logging in user
   Future<String> loginUser({
     required String email, required String password
}) async{
    String res = "some error occurred";
    try{
        if(email.isNotEmpty || password.isNotEmpty){
         await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
        }else {
          res = "Please enter all the fields";
        }
    }on FirebaseAuthException catch(err){
      if(err.code=='invalid-email'){
        res='You enter a wrong Email';
      }
      else if (err.code=='weak-password'){
        res='Your password at least of 6 words';
      }
    }
    catch (err){
      res = err.toString();
    }
    return res;
   }
}






