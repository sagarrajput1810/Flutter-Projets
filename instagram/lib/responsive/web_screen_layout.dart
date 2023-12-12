import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../provider/user_provider.dart';
class WebScreenLayout extends StatefulWidget {

  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page =0;
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }
  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {

    Users user =Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: false,
        title: SvgPicture.asset("assets/images/ic_instagram.svg",
          color: Colors.white,height: 40,),
        actions: [
          IconButton(onPressed: (){}, icon:  Icon(Icons.home,
          color: _page == 0? Colors.white70:Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.search,
            color: _page == 1? Colors.white70:Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo,
            color: _page == 2? Colors.white70:Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite,
            color: _page == 3? Colors.white70:Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.person,
            color: _page == 4? Colors.white70:Colors.white,)),
        ],
      ),
      body: Center(
        child: Text(user.username),
      ),
    );
  }
}
