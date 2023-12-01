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
          IconButton(onPressed: (){}, icon: Icon(Icons.message_sharp))
        ],
      ),
      body: PostCard(),
    );
  }
}
