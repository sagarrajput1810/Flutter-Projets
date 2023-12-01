import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post

Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
    ) async {
  String res = "some error occured in post";
  try{
    String postUrl =await  StorageMethod().uploadImageToStorage("posts", file, true);
    String postId = const Uuid().v1();
    Posts post = Posts(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        profImage: profImage,
        likes: []
    );
    _firestore.collection('posts').doc(postId).set(post.toJson(),);
    res = "success";
  } catch(e){
    res = e.toString();
  }
  return res;
}
}