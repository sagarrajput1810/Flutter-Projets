import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: false,
        title: SvgPicture.asset("assets/images/ic_instagram.svg",
          color: Colors.white,height: 40,),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.message_outlined)),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder:(context, index) => PostCard(
                snap: snapshot.data!.docs[index].data(),
              ) );
        },
      ),
    );
  }
}
