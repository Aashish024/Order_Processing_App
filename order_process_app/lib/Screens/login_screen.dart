// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:order_process_app1/Screens/forgot_password.dart';
import 'package:order_process_app1/Screens/home_screen.dart';
import 'package:order_process_app1/Screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 250.0,
                  width: 300.0,
                  child: LottieBuilder.asset('assets/animations/70640-floating-magic-link-login.json')
              ),
              FadeInLeft(
                duration: const Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: emailController,
                   decoration: const InputDecoration(
                     prefixIcon: Icon(Icons.email),
                     hintText: "Email",
                     label: Text('Email'),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                     ),
                   ),
                ),
              ),
              const SizedBox(height: 10.0),
              FadeInLeft(
                duration: const Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    label: const Text('Password'),
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: obscureText? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.visibility_off),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                    )
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              GestureDetector(
                onTap: (){
                  Get.to(()=> const ForgetPasswordScreen());
                },
                child: FadeInRight(
                  duration: const Duration(milliseconds: 2200),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: const Text('Forgot Password',style: TextStyle(color: Colors.green),),
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              FadeInUp(
                duration: const Duration(milliseconds: 2400),
                  child:
                  ElevatedButton(
                      onPressed: () async {
                        var loginEmail = emailController.text.trim();
                        var loginPassword = passwordController.text.trim();

                        EasyLoading.show();

                        try{
                          final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmail, password: loginPassword)).user;
                          if(firebaseUser != null){
                            Get.to(()=> const HomeScreen());
                            EasyLoading.dismiss();
                          }else {
                            print('Email or Password is invalid');
                            EasyLoading.dismiss();
                          }
                        }on FirebaseAuthException catch(e){
                          print('Error $e');
                          EasyLoading.dismiss();
                        }
                      },
                      child: const Text('Login')
                  )
              ),
              const SizedBox(height: 10.0,),
              GestureDetector(
                onTap: (){
                  Get.to(()=> const SignupScreen());
                },
                child: FadeInUp(
                  duration: const Duration(milliseconds: 2600),
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Don't have an account SignUp"),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              FadeInUp(
                duration: const Duration(milliseconds: 2800),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(height: 20.0,color: Colors.grey, thickness: 1.0,),
                      ),
                    ),
                    Text('Or'),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(height: 20.0,color: Colors.grey,thickness: 1.0,),
                      ),
                    ),
                  ],
                ),
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 2800),
                child: GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('These buttons are just for UI'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                            Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/Google-Symbol.png'),
                      ),
                      SizedBox(width: 25.0, ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/Facebook-logo.png'),
                      ),
                      SizedBox(width: 25.0,),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/twitter.jpg'),
                      ),
                      SizedBox(width: 25.0,),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/linkedin-icon-logo.png'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
