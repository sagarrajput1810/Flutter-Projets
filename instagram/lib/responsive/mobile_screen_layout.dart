import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/global_varibles.dart';
import 'package:instagram/screens/home.dart';
// import 'package:instagram/models/user.dart';
// import 'package:instagram/provider/user_provider.dart';
// import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

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
    // Users user =Provider.of<UserProvider>(context).getUser;
    // print(user);
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar:CupertinoTabBar(
        backgroundColor: Colors.black54,
        onTap: navigationTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 40,),
          label: '', backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 40),
              label: '', backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 40),
              label: '', backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, size: 40),
              label: '', backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 40),
              label: '', backgroundColor: Colors.white),

        ],

      ) ,
    );
  }
}






