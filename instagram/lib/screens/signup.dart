import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
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
                    const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage('https://images.vexels.com/media/users/3/147101/isolated/preview/b4a49d4b864c74bb73de63f080ad7930-instagram-profile-button.png'),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(onPressed: (){}, icon: const Icon(Icons.add_a_photo),),)
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
                  child: Container(
                    child: Text('Sign up'),
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
                      child: Text("Don't have an account"),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () { },
                      child: Container(
                        child: Text("Sign up", style: TextStyle(
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

