import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:order_process_app1/Screens/home_screen.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();
  TextEditingController clientMobileController = TextEditingController();
  TextEditingController originPriceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController saleDateController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Order'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
          child: Column(
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 1800),
                child: TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    hintText: "Product Name",
                    label: Text('Product Name'),
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
                  controller: clientNameController,
                  decoration: const InputDecoration(
                    hintText: "Client Name",
                    label: Text('Client Name'),
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
                  controller: clientAddressController,
                  decoration: const InputDecoration(
                    hintText: "Client Address",
                    label: Text('Client Address'),
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
                  controller: clientMobileController,
                  decoration: const InputDecoration(
                    hintText: "Client Mobile",
                    label: Text('Client Mobile'),
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
                  controller:originPriceController,
                  decoration: const InputDecoration(
                    hintText: "Origin Price",
                    label: Text('Origin Price'),
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
                  controller: salePriceController,
                  decoration: const InputDecoration(
                    hintText: "Sale Price",
                    label: Text('Sale Price'),
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
                  controller: saleDateController,
                  decoration: const InputDecoration(
                    hintText: "Sale Date",
                    label: Text('Sale Date'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(onPressed: () async {
                EasyLoading.show();
                var profit = int.parse(salePriceController.text) - int.parse(originPriceController.text);

                Map<String, dynamic> userData = {
                  'userID': user?.uid,
                  'productName': productNameController.text.trim() ,
                  'clientName': clientNameController.text.trim(),
                  'clientAddress': clientAddressController.text.trim() ,
                  'clientMobile': clientMobileController.text.trim() ,
                  'originPrice':  originPriceController.text.trim(),
                  'salePrice': salePriceController.text.trim() ,
                  'saleDate': saleDateController.text.trim(),
                  'profit' : profit,
                  'CreatedAt' : DateTime.now(),
                  'productStatus' : 'Pending'
                };

                await FirebaseFirestore.instance.collection('orders').doc().set(userData);

                EasyLoading.dismiss();
                print("Data added");
                Get.off(()=> const HomeScreen());

              }, child: const Text('Create Order'))
            ],
          ),
        ),
      ),
    );
  }
}
