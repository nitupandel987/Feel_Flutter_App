import 'package:feel/Home/home_screen.dart';
import 'package:feel/authentication/authentication_controller.dart';
import 'package:feel/authentication/registration_screen.dart';
import 'package:feel/phone.dart';
import 'package:feel/verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'authentication/login_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify(),
      'home':(context)=> RegistrationScreen(),
    },
  ));
}

// void main() async{
//
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp().then((value){
//     Get.put(AuthenticationController());
//   });
//   // try {
//   //   WidgetsFlutterBinding.ensureInitialized();
//   //   await Firebase.initializeApp();
//   //   Get.put(AuthenticationController());
//   // } catch (error) {
//   //   print('Error initializing Firebase: $error');
//   // }
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Learning From Shiva',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData().copyWith(
//         scaffoldBackgroundColor: Colors.white,
//
//
//       ),
//       home: LoginScreen(),
//     );
//
//   }
// }
