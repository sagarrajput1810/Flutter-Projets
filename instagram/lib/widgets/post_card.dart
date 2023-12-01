import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       padding:  const EdgeInsets.symmetric(
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
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.3l2nfzcHhMemSZooiH3B3AHaFj?rs=1&pid=ImgDetMain'
                  ),
                ),
                const Expanded(child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('username', style: TextStyle(
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
          SizedBox(
            height: MediaQuery.of(context).size.height*0.35,
            width: double.infinity,
            child: Image.network("https://th.bing.com/th/id/R.e1707c345d5ac10c80a674030e606643?rik=pOsTg5KBoLuNvw&riu=http%3a%2f%2fwww.snut.fr%2fwp-content%2fuploads%2f2015%2f08%2fimage-de-paysage.jpg&ehk=1O5SWKkGpZ8yU%2b%2fAnLXG1v8k6BKxgyiXgHbOWBW1ir0%3d&risl=1&pid=ImgRaw&r=0",
            fit: BoxFit.cover,),
          ),
        //   Like , Share section:
          Row(
            children: [
              IconButton(onPressed: (){},
                  icon: Icon(Icons.favorite, color: Colors.red,)),
              IconButton(onPressed: (){},
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
                  child: Text("1,231 likes",
                  style: Theme.of(context).textTheme.bodyLarge,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}













