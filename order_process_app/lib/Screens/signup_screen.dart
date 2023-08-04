import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:order_process_app1/Screens/login_screen.dart';
import 'package:order_process_app1/Services/signup_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  bool obscureText = true;

  User? currentUser =FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            children: [
              SizedBox(
                  height: 150.0,
                  width: 500.0,
                  child: LottieBuilder.asset('assets/animations/Signup.json')
              ),
              FadeInLeft(
                duration: const Duration(milliseconds: 1800),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: userFirstNameController,
                        decoration: const InputDecoration(
                          hintText: "FirstName",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: userLastNameController,
                        decoration: const InputDecoration(
                          hintText: 'LastName',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              FadeInLeft(
                duration: const Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: userEmailController,
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
                  controller: userPasswordController,
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
              FadeInLeft(
                duration: const Duration(milliseconds: 1800),
                child: TextFormField(
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    hintText: "Confirm Password",
                    label: const Text('Confirm Password'),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: obscureText? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.visibility_off),
                      ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              FadeInUp(
                  duration: const Duration(milliseconds: 2400),
                  child:
                  ElevatedButton(onPressed: ()async {
                    EasyLoading.show();
                    var userFirstName = userFirstNameController.text.trim();
                    var userLastName = userLastNameController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();

                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: userEmail, password: userPassword).then((value) => {
                      SignUpUser(
                          userFirstName,
                          userLastName,
                          userEmail,
                          userPassword
                      ),

                    },
                    );
                    Get.off(()=> const LoginScreen());
                    EasyLoading.dismiss();
                  },
                      child: const Text('SignUp')
                  )
              ),
              const SizedBox(height: 10.0,),
              GestureDetector(
                onTap: (){
                  Get.to(()=> const LoginScreen());
                },
                child: FadeInUp(
                  duration: const Duration(milliseconds: 2600),
                  child: const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Already have an account LogIn"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
