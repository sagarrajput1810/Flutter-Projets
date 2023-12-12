import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  bool isShowUser = true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search for user'
          ),
          onFieldSubmitted: (String _){
            isShowUser = true;
          },
        ),
      ),
      body: isShowUser?
      FutureBuilder(
        future: FirebaseFirestore.instance.collection('users')
            .where('username', isGreaterThanOrEqualTo: searchController.text)
            .get(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    ProfileScreen(uid: (snapshot.data! as dynamic).docs[index]['uid']))),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['photo']
                    ),
                  ),
                  title: Text((snapshot.data! as dynamic).docs[index]['username']),
                ),
              );
            }
          );
        },
      ): FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }

            return StaggeredGridView.countBuilder(
              crossAxisCount: 3,
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context,index) =>Image.network(
                  (snapshot.data! as dynamic).docs[index]['postUrl']),
              staggeredTileBuilder: (index) => StaggeredTile.count(
                  (index %7 == 0) ? 2:1,
                  (index %7 == 0) ? 2:1,
              ),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            );
      })
    );
  }
}
