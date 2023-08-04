import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:order_process_app1/Screens/login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController forgotPasswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:
      SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 250.0,
                  child: Lottie.asset('assets/animations/Forgot.json')
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: forgotPasswordController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              FadeInUp(
                  duration: const Duration(milliseconds: 2400),
                  child:
                  ElevatedButton(onPressed: (){
                    var forgotEmail= forgotPasswordController.text.trim();

                    try{
                      FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail).then((value) => Get.off(()=> const LoginScreen()));
                    }on FirebaseAuthException catch(e){
                      print("Error $e");
                    }
                  },
                      child: const Text('Send Email')
                  )
              ),

            ],
          ),
        ),
      ),

    );
  }
}
