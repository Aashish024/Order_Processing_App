import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:order_process_app1/Screens/create_order.dart';
import 'package:order_process_app1/Screens/info_screen.dart';
import 'package:order_process_app1/Screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user= FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        elevation: 0.0,
        actions:  [
          GestureDetector(
            child:  SpeedDial(
              animatedIcon: AnimatedIcons.ellipsis_search,
              direction: SpeedDialDirection.down,
              elevation: 0.0,
              closeManually: false,
              childMargin: const EdgeInsets.only(left: 60.0),
              children: [
                SpeedDialChild(
                    child: const Icon(Icons.logout),
                    label: 'SignOut',
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => const LoginScreen());
                    }
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(child: Icon(Icons.person),),
              accountName: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
                  builder: (BuildContext context, snapshot ){
                  var userName = snapshot.data!.get('UserFirstName');

                  if (snapshot.data != null && snapshot.hasData){
                    return Text('$userName');
                  }
                  else{
                    return const Text("Error Finding Name");
                  }
                  }
              ),
              accountEmail: Text('${user!.email}'),
            ),
            GestureDetector(
              onTap: (){
                Get.back(result: ()=> HomeScreen());
              },
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                trailing: Icon(Icons.arrow_forward_outlined),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=> const InfoScreen());
              },
              child: const ListTile(
                leading: Icon(Icons.info),
                title: Text('Info'),
                trailing: Icon(Icons.arrow_forward_outlined),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=> const CreateOrderScreen());
              },
              child: const ListTile(
                leading: Icon(Icons.border_color),
                title: Text('Create Order'),
                trailing: Icon(Icons.arrow_forward_outlined),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child:
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('orders').where('userID', isEqualTo: user!.uid).snapshots(),
                builder: (BuildContext context, snapshot){
                  if(snapshot.hasError){
                    return const Center(child: Text('Some Error'),);
                  }

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  if(snapshot.data == null){
                    return const Center(child: Text("Error Data not found"),);
                  }

                  if(snapshot != null && snapshot.data != null){
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          String status = snapshot.data!.docs[index]['productStatus'];
                          var docID =snapshot.data!.docs[index].id;
                          return Card(
                            elevation: 4.0,
                            child: FadeInLeft(
                              child: ListTile(
                                leading: CircleAvatar(child: Text(index.toString())),
                                title: Text(snapshot.data!.docs[index]['productName']),
                                subtitle: status == 'Pending' ?
                                Text(
                                  'Status: ${snapshot.data!.docs[index]['productStatus']}',
                                  style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                                ) :
                                Text(
                                  'Status: ${snapshot.data!.docs[index]['productStatus']}',
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                                trailing: InkWell(
                                  onTap: (){
                                    Get.defaultDialog(
                                      title: 'Do you want to update status to Sold?',
                                      content: const Text(''),
                                      onCancel: (){},
                                      onConfirm: () async {
                                        EasyLoading.show();
                                        await FirebaseFirestore.instance.collection('orders').doc(docID).update({'productStatus' : 'Sold'});
                                        EasyLoading.dismiss();
                                        Get.back();
                                      }
                                    );
                                  },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.cyan[200],
                                      child: const Icon(Icons.edit),
                                    )
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }
                  return Container();
                }
            )
        ),
      ),
    );
  }
}
