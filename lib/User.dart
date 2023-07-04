import 'dart:async';
// import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolebased/timer_homepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolebased/timer.dart';
import 'package:geolocator/geolocator.dart';

import 'login.dart';

var lat;
var long;

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {

  final url = Uri.parse('https://bluetooth-app-eight.vercel.app');



//   Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }
// }

  @override
  Widget build(BuildContext context) {
    void getlocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print('NEW NEW NEW NEW NEW');
    print(position);
    lat = position.latitude;
    long = position.longitude;
  }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 219, 134),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("User"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
          
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
Padding(
          padding: const EdgeInsets.all(8.0),
        
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => timerScreen(),)),
            child: Container(
              width: 220,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(child: Text('timer',style: TextStyle(color: Colors.white,fontSize: 20 , fontWeight: FontWeight.bold),)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              launchUrl(url,
              mode: LaunchMode.externalApplication);
            },
            
            child: Container(
              width: 220,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(child: Text('bluetooth',style: TextStyle(color: Colors.white,fontSize: 20 , fontWeight: FontWeight.bold),)),
              
            ),
          ),
        ),

        Padding(
         padding: const EdgeInsets.all(8.0),
          child: Container(
           width: 220,
           height: 60,
           decoration: BoxDecoration(
             color: Colors.orange,
             borderRadius: BorderRadius.circular(20)
            ),
           child:  InkWell(
            onTap: () {
            getlocation();
            },
           child: Center(child: Text('Get Loccation',style: TextStyle(color: Colors.white,fontSize: 20 , fontWeight: FontWeight.bold),)),
          ),
          ),
       ),

       Padding(
         padding: const EdgeInsets.all(8.0),
          child: Container(
           width: 220,
           height: 60,
           decoration: BoxDecoration(
             color: Colors.orange,
             borderRadius: BorderRadius.circular(20)
            ),
           child:  InkWell(
            onTap: () async {
              await addUserDetails(lat.toString());
              await addUserDetails2(long.toString());
            },
           child: Center(child: Text('Update location',style: TextStyle(color: Colors.white,fontSize: 20 , fontWeight: FontWeight.bold),)),
          ),
          ),
       ),
        

        //Padding(
        //  padding: const EdgeInsets.all(8.0),
         // child: Container(
           // width: 220,
           // height: 60,
           // decoration: BoxDecoration(
             // color: Colors.orange,
              //borderRadius: BorderRadius.circular(20)
           // ),
           // child: Center(child: Text('data',style: TextStyle(color: Colors.white,fontSize: 20 , fontWeight: FontWeight.bold),)),
         // ),
       // )
        
          ],
        ),
        
    ));
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}


Future addUserDetails(String Newadd) async {
  await FirebaseFirestore.instance.collection('user1').doc("My file").set({
    'New add': Newadd,
  });
}

Future addUserDetails2(String Newadd) async {
  await FirebaseFirestore.instance.collection('user2').doc("My file2").set({
    'New add': Newadd,
  });
}