import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive.dart';
import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/login.dart';
import 'package:instagram/screens/signup.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAUUe6skzNHwcm2081hhlOxuZNpQ8hNbTo",
            projectId: "instagram-5dc77",
            storageBucket: "instagram-5dc77.appspot.com",
            messagingSenderId: "473279414740",
            appId: "1:473279414740:web:e2bb2e9f103b80df5b1641"));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        theme: ThemeData.dark(),
        // home: Scaffold(body: SafeArea(
        //     child: const ResponsiveLayout(
        //         webScreenLayout: WebScreenLayout(),
        //         mobileScreenLayout: MobileScreenLayout())
      //   ))
      home: LoginScreen(),
    );
  }
}
