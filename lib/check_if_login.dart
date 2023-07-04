
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rolebased/Owner.dart';
// import 'package:rolebased/User.dart';
// import 'package:rolebased/global_var.dart';
// import 'package:rolebased/login.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           var lenght  = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
//         print(lenght);
         
//           //is user logged in
//           if (snapshot.hasData) {
//             if(role=='User'){
//                 return Student();
//           }
//           else if(role=='owner'){
//                 return Teacher();
//           }
//           else{
//             return Student();
//           }
//         }//is user not logged in
//           else {
//             return  LoginPage();
//           }
//         }
//       )
//     );
//   }
// }