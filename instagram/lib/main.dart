import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive.dart';
import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/login.dart';
import 'package:provider/provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAUUe6skzNHwcm2081hhlOxuZNpQ8hNbTo",
            projectId: "instagram-5dc77",
            storageBucket: "instagram-5dc77.appspot.com",
            messagingSenderId: "473279414740",
            appId: "1:473279414740:web:e2bb2e9f103b80df5b1641"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instagram',
          theme: ThemeData.dark(),
          // home: Scaffold(body: SafeArea(
          //     child: const ResponsiveLayout(
          //         webScreenLayout: WebScreenLayout(),
          //         mobileScreenLayout: MobileScreenLayout())
        //   ))
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges() ,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout()
                );
              }else if (snapshot.hasError){
                return Center(child: Text("${snapshot.error}"),);
              }
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),);
            }
            return LoginScreen();
          },
        )
      ),
    );
  }
}
