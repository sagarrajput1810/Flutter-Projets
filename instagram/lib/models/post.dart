import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String description;
  final String uid;
  final datePublished;
  final String username;
  final String postId;
  final String postUrl;
  final String profImage;
  final likes;

  const Posts(
      {required this.description,
        required this.uid,
        required this.username,
        required this.postId,
        required this.datePublished,
        required this.postUrl,
        required this.profImage,
        required this.likes
      });

  Map<String, dynamic> toJson() => {
    'description' : description,
    'uid' : uid,
    'username' : username,
    'postId' : postId,
    'postUrl' : postUrl,
   'datePublished' : datePublished,
   'profImage' : profImage,
   'likes' : likes,
  };
  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Posts(
        description: snapshot['description'],
        uid: snapshot['uid'],
        postUrl: snapshot['postUrl'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes']
    );
  }
}
