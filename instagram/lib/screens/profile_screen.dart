import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/resources/firestore_method.dart';
import 'package:instagram/screens/login.dart';
import 'package:instagram/utils/utils.dart';

import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var userData = {};
  int postLen = 0;
  int followers =0;
  int following = 0;
  bool isFollowing = false;

  bool isLoding = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoding = true;
    });
    try{
     var userSnap = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();

      // get post Length:
     var postSnap = await FirebaseFirestore.instance.collection('posts')
         .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      postLen = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);

      userData = userSnap.data()!;
    }catch(e){
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoding? Center(child: const CircularProgressIndicator()) : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(userData['username']),
          centerTitle: false,
        ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(userData['photo']),
                        radius: 40,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildStateColumn(postLen, 'posts'),
                                buildStateColumn(followers, 'followers'),
                                buildStateColumn(following, 'following')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                  FirebaseAuth.instance.currentUser!.uid == widget.uid?
                                  FollowButton(text: 'signOut',
                                  backgroundColor: Colors.black12,
                                  textColor: Colors.white, borderColor: Colors.grey ,
                                  function: () async {
                                    await Authmethods().signOut();
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => const LoginScreen()));
                                  },

                                ): isFollowing? FollowButton(text: 'Unfollow',
                                  backgroundColor: Colors.black12,
                                  textColor: Colors.white, borderColor: Colors.grey ,
                                  function: () async {
                                    await FirestoreMethods().followUser(
                                        FirebaseAuth.instance.currentUser!.uid, userData['uid']);
                                    setState(() {
                                      isFollowing = false;
                                      followers--;
                                    });
                                  },

                                ): FollowButton(text: 'Follow',
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white, borderColor: Colors.blue,
                                  function: () async {
                                    await FirestoreMethods().followUser(
                                        FirebaseAuth.instance.currentUser!.uid, userData['uid']);
                                    setState(() {
                                      isFollowing = true;
                                      followers++;
                                    });
                                  },

                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    userData['username'], style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    userData['bio'],
                  ),
                )
              ],
            ),
          ),
          const Divider(),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts')
                    .where('uid', isEqualTo: widget.uid).get(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const  Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1
                      ),
                      itemBuilder: (context, index){
                      DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                      return Container(
                        child: Image(
                          image: NetworkImage(
                              snap['postUrl']
                          ),
                        ),
                      );
                      });
                }),
        ],
      ),
    );
  }
  Column buildStateColumn(int num, String lable)
  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(num.toString(), style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),),
        Text(lable, style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,

        ),)
      ],
    );
  }}
