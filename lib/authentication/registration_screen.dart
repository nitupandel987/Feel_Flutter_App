import 'package:feel/authentication/authentication_controller.dart';
import 'package:feel/authentication/login_screen.dart';
import 'package:feel/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../global.dart';

class RegistrationScreen extends StatefulWidget {

    const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();

  var authenticationController = AuthenticationController.instanceAuth;
  String? selectedGender;


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SingleChildScrollView(
         child: Center(
           child: Column(
             children: [

               const SizedBox(
                 height: 100,
               ),



               Text(
                 "Create Account",
                 style: GoogleFonts.aBeeZee(
                   fontSize: 34,
                   color: Colors.grey,
                    fontWeight: FontWeight.bold,
                 ) ,
               ),


               Text(
                 "To get Started Now",
                 style: GoogleFonts.aBeeZee(
                   fontSize: 34,
                   color: Colors.grey,
                 ) ,
               ),


               const SizedBox(
                 height: 100,
               ),

               //profile avatar
               GestureDetector(
                 onTap: (){
                 //Allow User to choose image
                  authenticationController.chooseImageFromGallery();
                 },
                 child: const CircleAvatar(
                   radius: 80,
                   backgroundImage: AssetImage(
                     "images/profile.png"
                   ),
                   backgroundColor: Colors.black,
                 ),
               ),

               const SizedBox(
                 height: 25,
               ),

                //User Name
               Container(
                 width:  MediaQuery.of(context).size.width,
                 margin: const EdgeInsets.symmetric(horizontal: 20) ,
                 child: InputTextWidget(
                   textEditingController:userNameTextEditingController,
                   lableString: "UserName",
                   iconData: Icons.person_outlined,
                   isObscure: false,

                   assetRefrence: '',

                 ),

               ),

               const SizedBox(
                 height: 25,
               ),


// Gender dropdown menu
               Container(
                 width: MediaQuery.of(context).size.width,
                 margin: const EdgeInsets.symmetric(horizontal: 20),
                 child: DropdownButtonFormField<String>(
                   value: selectedGender,
                   onChanged: (value) {
                     setState(() {
                       selectedGender = value;
                     });
                   },
                   items: ['Male', 'Female', 'Other']
                       .map<DropdownMenuItem<String>>((String value) {
                     return DropdownMenuItem<String>(
                       value: value,
                       child: Text(value),
                     );
                   }).toList(),
                   decoration: InputDecoration(
                     labelText: 'Gender',
                     hintText: 'Select Gender',
                     prefixIcon: Icon(Icons.person_outline),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10.0),
                     ),
                   ),
                 ),
               ),
               //Email
               Container(
                 width:  MediaQuery.of(context).size.width,
                 margin: const EdgeInsets.symmetric(horizontal: 20) ,
                 child: InputTextWidget(
                   textEditingController:emailTextEditingController,
                   lableString: "Email",
                   iconData: Icons.email_outlined,
                   isObscure: false,
                   assetRefrence: '',
                 ),
               ),


               const SizedBox(
                 height: 25,
               ),

               //password
               Container(
                 width:  MediaQuery.of(context).size.width,
                 margin: const EdgeInsets.symmetric(horizontal: 20),
                 child: InputTextWidget(
                   textEditingController:passTextEditingController,
                   lableString: "Password",
                   iconData: Icons.password_outlined,
                   isObscure: true, assetRefrence: '',
                 ),
               ),

               const SizedBox(
                 height: 25,
               ),

               //Login Button
               //Not have an account, signup now button
               showProgressBar == false ?
               Column(
                 children: [
                   //SignUp Button
                   Container(
                     width: MediaQuery.of(context).size.width - 38,
                     height: 54,
                     decoration: const BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.all(
                             Radius.circular(10)
                         )
                     ),
                     child: InkWell(
                       onTap: (){

                         if(authenticationController.profileImage!=null
                             && userNameTextEditingController.text.isNotEmpty
                             && emailTextEditingController.text.isNotEmpty
                             && passTextEditingController.text.isNotEmpty)
                         {
                           setState(() {
                             showProgressBar = true;
                           });
                           //create a new account for user
                           authenticationController.createAccountForNewUser(
                               authenticationController.profileImage!,
                               userNameTextEditingController.text,
                               emailTextEditingController.text,
                               passTextEditingController.text,
                             selectedGender ?? '',
                           );

                         }

                       },
                       child: const Center(
                         child: Text(
                           "Sign Up",
                           style: TextStyle(
                             fontSize: 20,
                             color: Colors.black,
                             fontWeight: FontWeight.w700,
                           ),
                         ),
                       ) ,
                     ),
                   ),

                   const SizedBox(
                     height: 15,
                   ),

                   //Not have an account, signup now button
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,

                     children: [
                       const Text("Already Have an Account? ",
                         style: TextStyle(
                           color: Colors.grey,
                           fontSize: 16,
                         ),),
                       InkWell(
                         onTap: (){
                           //send user to signup screen
                           Get.to(LoginScreen());
                         },
                         child: const Text("Login Now",
                           style: TextStyle(
                               fontSize: 18,
                               color: Colors.white,
                               fontWeight: FontWeight.bold
                           ),),
                       )
                     ],
                   ),
                 ],
               ) : Container(
                 //show animation
                 child: const SimpleCircularProgressBar(
                   progressColors: [
                     Colors.green,
                     Colors.blueAccent,
                     Colors.red,
                     Colors.amber,
                     Colors.purpleAccent
                   ],
                   animationDuration: 3,
                   backColor: Colors.white30,

                 ),
               )
             ],
           ),
         ),
       ),
     );
  }
}
