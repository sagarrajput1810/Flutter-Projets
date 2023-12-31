
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/resources/firestore_method.dart';
import 'package:instagram/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPstScreenState();
}

class _AddPstScreenState extends State<AddPostScreen> {

  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading =false;

  void postImage(
      String uid,
      String username,
      String profImage,
      ) async {
        setState(() {
          _isLoading = true;
        });
        try{
            String res = await FirestoreMethods().uploadPost(
                _descriptionController.text, _file!, uid, username, profImage);
            if(res == "success"){
              setState(() {
                _isLoading = false;
              });
              showSnackBar(context, 'Posted');
              _file = null;

            }
        } catch (e){
          showSnackBar(context, e.toString());
          setState(() {
            _isLoading = false;
          });
        }
  }
  _selectImage( BuildContext context)async{
    return showDialog(context: context, builder: (contex){
      return SimpleDialog(
        title: const Text('Create a post'),
        children: [
          SimpleDialogOption(
            padding:  const EdgeInsets.all(20),
            child: Text('Take a photo'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding:  const EdgeInsets.all(20),
            child: Text('Take a gallery'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding:  const EdgeInsets.all(20),
            child: Text('Cancel'),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Users user = Provider.of<UserProvider>(context).getUser;
    return _file == null ? Center(child: Container(
      child: IconButton(
        icon: const Icon(Icons.upload),
        onPressed: () => _selectImage(context),
      ),
    )) :
     Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _file = null;
              });
            },
          ),
        title: Text('Post to'),
        actions: [
          TextButton(onPressed: () => postImage(
            user.uid,
            user.username,
            user.photoUrl
          ),
              child: const Text('Post', style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),) )
        ],
      ),
      body: Column(
        children: [
          _isLoading ? const LinearProgressIndicator() : 
          Padding(padding: EdgeInsets.only(top: 0),),
          SizedBox( height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CircleAvatar(
              backgroundImage: NetworkImage(
                user.photoUrl
              ),
            ),
              SizedBox(width: 10,),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Write a caption...',
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child:  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}




