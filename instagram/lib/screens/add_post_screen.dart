import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPstScreenState();
}

class _AddPstScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    // return Center(child: Container(
    //   child: IconButton(
    //     icon: const Icon(Icons.upload),
    //     onPressed: () {},
    //   ),
    // ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () {},
          ),
        title: Text('Post to'),
        actions: [
          TextButton(onPressed: (){}, child: const Text('Post', style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),) )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.vexels.com/media/users/3/147101/isolated/preview/b4a49d4b864c74bb73de63f080ad7930-instagram-profile-button-by-vexels.png'
              ),
            ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextField(

                ),
              )
            ],
          )
        ],
      ),
    );
  }
}




