import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
              // text feild input for email:
              TextFieldInput(
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Enter your Email',
                  textEditingController: emailController),
              SizedBox(
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
              InkWell(
                child: Container(
                  child: Text('Log in'),
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



