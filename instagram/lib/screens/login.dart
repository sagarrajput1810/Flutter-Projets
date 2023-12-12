import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/responsive/global_varibles.dart';
import 'package:instagram/screens/signup.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void navigteToSignup(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SignupScreen()));
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authmethods().loginUser(
        email: emailController.text,
        password: passwordController.text);
    if(res == "success"){
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()
          ))
      );
      // this is not use because
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder:(context) => HomeScreen()));
    }else{
      showSnackBar(context, res);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:MediaQuery.of(context).size.width> webScreensize ?
          EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width)/3)
              :
          const EdgeInsets.symmetric(horizontal: 32),
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
                onTap: loginUser,
                child: Container(
                  child: _isLoading?Center(child: CircularProgressIndicator(
                    color: Colors.white,
                  ),) :Text('Log in'),
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
                    onTap: navigteToSignup,
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



