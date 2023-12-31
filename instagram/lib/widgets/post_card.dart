import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/resources/firestore_method.dart';
import 'package:instagram/screens/comments_screen.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  bool isLikeAnimating =false;
  int commentLen = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }
  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance.collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    }catch(e){
      showSnackBar(context, e.toString());
        }
  }
  @override
  Widget build(BuildContext context) {

    final Users user = Provider.of<UserProvider>(context).getUser;
    // String profImage  = snap['profImage'];
    return Container(
       padding: const EdgeInsets.symmetric(
         vertical: 10,
       ),
      child: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                 CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.snap['username'], style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                ),
                ),
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context) => Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: [
                        'delete',
                      ].map((e) => InkWell(
                        onTap: () async{
                          FirestoreMethods().deletePost(widget.snap['postId']);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical:12, horizontal: 16 ),
                          child: Text(e),
                        ),
                      )
                      ).toList(),
                    ),
                  ) );
                }, icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
        //   Image Section:
          GestureDetector(
            onDoubleTap: () async{
              await FirestoreMethods().likePost(widget.snap['postId'],
                  user.uid, widget.snap['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.35,
                  width: double.infinity,
                  child: Image.network(widget.snap['postUrl'],
                  fit: BoxFit.cover,),
                ),
                AnimatedOpacity(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  opacity: isLikeAnimating? 1:0,
                  child: LikeAnimation(
                    child: Icon(Icons.favorite,
                      color: Colors.white,
                        size: 120,),
                    isAnimating: isLikeAnimating,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                    onEnd: (){
                        setState(() {
                          isLikeAnimating = false;
                        });
                    }, smallLike: isLikeAnimating,
                  ),
                ),
              ],
            ),
          ),
        //   Like , Share section:
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid!),
                smallLike: true,
                child: IconButton(onPressed: ()async{
                    await FirestoreMethods().likePost(widget.snap['postId'],
                        user.uid, widget.snap['likes']);},
                    icon: widget.snap['likes'].contains(user.uid)?
                    Icon(Icons.favorite, color: Colors.red,):
                      Icon(Icons.favorite_border, color: Colors.white,)),
              ),
              IconButton(onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                  builder: (context) => CommentsScreen(snap: widget.snap))),
                  icon: Icon(Icons.comment_outlined, color: Colors.white,)),
              IconButton(onPressed: (){},
                  icon: Icon(Icons.send, color: Colors.white,)),
              Expanded(child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(onPressed: (){},
                    icon: Icon(Icons.bookmark_border) ),
              ))
            ],
          ),
        //   Description Section:
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w800),
                  child: Text("${widget.snap['likes'].length} likes",
                  style: Theme.of(context).textTheme.bodyLarge,),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle( color: Colors.white),
                      children: [
                        TextSpan(
                            text: widget.snap['username']+"  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.snap['description'],

                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => CommentsScreen(snap: widget.snap))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child:  Text('view all $commentLen comments', style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ), ) ,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ), ) ,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}