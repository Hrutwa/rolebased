import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:rolebased/timer.dart';
import 'package:rolebased/timer_homepage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';

var classSnap;
var classSnap2;

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
  
}

class _TeacherState extends State<Teacher> {
   final url = Uri.parse('https://bluetooth-app-eight.vercel.app');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 219, 134),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Owner"),
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
              launchUrl(url, mode: LaunchMode.externalApplication);
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
              getdata();
              getdata2();
            },
           child: Center(child: Text('Get Location',style: TextStyle(color: Colors.white,fontSize: 20 , fontWeight: FontWeight.bold),)),
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
                await _launchURL();
              },
           child: Center(child: Text('View Location',style: TextStyle(color: Colors.white,fontSize: 20 , fontWeight: FontWeight.bold),)),
          ),
          ),
       ),


        

       // Padding(
         // padding: const EdgeInsets.all(8.0),
         // child: Container(
          //  width: 220,
          //  height: 60,
           // decoration: BoxDecoration(
            //  color: Colors.blue,
             // borderRadius: BorderRadius.circular(20)
           // ),
           // child: Center(child: Text('data',style: TextStyle(color: Colors.white,fontSize: 20 , fontWeight: FontWeight.bold),)),
         // ),
        //)
        
          ],
        ),
        
    ));
  }
    
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

Future<void> _launchURL() async {
  final uri = Uri.parse(
      "http://maps.google.com/maps?q=${classSnap.data()!['New add'].toString()},${classSnap2.data()!['New add'].toString()}");
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw "Can not launch url";
  }
}

Future getdata() async {
  classSnap =
      await FirebaseFirestore.instance.collection('user1').doc("My file").get();
}

Future getdata2() async {
  classSnap2 = await FirebaseFirestore.instance
      .collection('user2')
      .doc("My file2")
      .get();
}
