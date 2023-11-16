
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/login.dart';
import 'package:instagram/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/text_field_input.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? _image=null;
  bool _isloding = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }
  void navigteToLogin(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginScreen()));
  }

  void selectImage() async {
    Uint8List im =  await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isloding = true;
    });
    String res = await Authmethods().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        bio: bioController.text,
        file: _image!
    );
    if(res != 'success'){
      showSnackBar(context, res);
      setState(() {
        _isloding = false;
      });
    }else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout()
        ))
      );
    }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Container(),flex: 1,),
                // SVG Image of instagram
                SvgPicture.asset("assets/images/ic_instagram.svg",
                  color: Colors.white,height: 64,),
                SizedBox(height: 64,),
                Stack(
                  children: [
                    _image != null? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    ) : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.-rabTQfi3SEw62ITmi3KCAHaHa?pid=ImgDet&rs=1'),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(onPressed: selectImage, icon: const Icon(Icons.add_a_photo),),)
                  ],
                ),
                const SizedBox(height: 24,),
                //text feild for sign up:
                TextFieldInput(
                    textInputType: TextInputType.text,
                    hintText: 'Enter your username',
                    textEditingController: usernameController),
                const SizedBox(
                  height: 24,
                ),
                // text feild input for email:
                TextFieldInput(
                    textInputType: TextInputType.emailAddress,
                    hintText: 'Enter your Email',
                    textEditingController: emailController),
                const SizedBox(
                  height: 24,
                ),
                // text field input for password:
                TextFieldInput(
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Enter your Password',
                  textEditingController: passwordController,
                  isPass: true,
                ),
                SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    textInputType: TextInputType.text,
                    hintText: 'Enter your Bio',
                    textEditingController: bioController),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap:signUpUser ,
                  child: Container(
                    child: _isloding?const Center(child: CircularProgressIndicator(
                      color: Colors.white,
                    ),) :Text('Sign up'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        )),
                  ),
                ),
                const SizedBox( height: 12,),
                Flexible(child: Container(), flex: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Don't have an account "),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: navigteToLogin,
                      child: Container(
                        child: Text("Login", style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    )
                  ],

                )
              ],
            ),
          ),
        )
    );
  }
}

