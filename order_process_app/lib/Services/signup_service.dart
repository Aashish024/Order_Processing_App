import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:order_process_app1/Screens/login_screen.dart';

SignUpUser(
    String userFirstName,
    String userLastName,
    String userEmail,
    String userPassword) async {
  User? userid= FirebaseAuth.instance.currentUser;

  try{
    FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'UserFirstName': userFirstName,
      'UserLastName': userLastName,
      'UserEmail': userEmail,
      'Created At': DateTime.now(),
      'User ID': userid!.uid,
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(()=> const LoginScreen()),
    });
  }on FirebaseAuthException catch (e){
    print("error $e");
  }
}