import 'package:feel/authentication/authentication_controller.dart';
import 'package:feel/authentication/login_screen.dart';
import 'package:feel/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:intl/intl.dart';
import '../global.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController desTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController dobController = TextEditingController();
  var authenticationController = AuthenticationController.instanceAuth;
  String dropdownValue = "Male";

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         children:[
    //      Container(
    //          decoration: BoxDecoration(
    //          image: DecorationImage(
    //            image: AssetImage( "images/bg.png"),fit: BoxFit.fill,
    // ),
    // ),
    //  // yhan
    // ),
         SingleChildScrollView(

         child: Center(
           child: Column(
             children: [

               const SizedBox(
                 height: 50,
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

               Container(
                 width:  MediaQuery.of(context).size.width,
                 margin: const EdgeInsets.symmetric(horizontal: 20) ,
                 child: TextField(
                   controller: dobController,
                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.person),
                     labelText: 'Select DateofBirth',
                     labelStyle: const TextStyle(
                       fontSize: 18,
                     ),
                     enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(6),
                         borderSide: const BorderSide(
                           color: Colors.grey,
                         )
                     ),
                     focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(6),
                         borderSide: const BorderSide(
                           color: Colors.grey,
                         )
                     ),

                   ),
                   style: TextStyle(fontSize: 16, color: Colors.black),
                         onTap: () async{
                     DateTime? pickeddate=await showDatePicker(
                         context: context,
                         initialDate: DateTime.now(),
                         firstDate: DateTime(1990),
                         lastDate: DateTime.now());
                     if(pickeddate!=null){
                       setState(() {
                         dobController.text=DateFormat('yyyy-MM-dd').format(pickeddate);
                       });
                     }
                   },


               const SizedBox(
                 height: 15,
               ),
                     Container(
                 width:  MediaQuery.of(context).size.width,
                 margin: const EdgeInsets.symmetric(horizontal: 20) ,
                 child: DropdownButtonFormField<String>(

                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.person),
                     labelText: 'Select Gender',
                     labelStyle: const TextStyle(
                       fontSize: 18,
                     ),
                     enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(6),
                         borderSide: const BorderSide(
                           color: Colors.grey,
                         )
                     ),
                     focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(6),
                         borderSide: const BorderSide(
                           color: Colors.grey,
                         )
                     ),

                   ),
                   value: dropdownValue,
                   items: <String>["Male", "Female", "Others"]
                       .map<DropdownMenuItem<String>>((String value) {
                     return DropdownMenuItem<String>(
                       value: value,
                       child: Text(
                         value,
                         style: TextStyle(fontSize: 16, color: Colors.black),
                       ),
                     );
                   }).toList(),
                   // Step 5.
                   onChanged: (String? newValue) {
                     setState(() {
                       dropdownValue = newValue!;
                     });
                   },
                 ),
         ),

               const SizedBox(
                 height: 15,
               ),

               Container(
                 width:  MediaQuery.of(context).size.width,
                 margin: const EdgeInsets.symmetric(horizontal: 20) ,
                 child: TextField(
                   controller: desTextEditingController,
                   maxLines: 2,
                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.description),
                     labelText: 'Description',
                     labelStyle: const TextStyle(
                       fontSize: 18,
                     ),
                     enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(6),
                         borderSide: const BorderSide(
                           color: Colors.grey,
                         )
                     ),
                     focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(6),
                         borderSide: const BorderSide(
                           color: Colors.grey,
                         )
                     ),

                   ),
                   style: TextStyle(fontSize: 16, color: Colors.black),
                 ),
               ),


               const SizedBox(

                 height: 15,
               ),

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
                 height: 15,
               ),
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
                 height: 15,
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

                                desTextEditingController.text,
                                dropdownValue,
                               dobController.text,

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

                       const SizedBox(
                         height: 30,
                       ),

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
                   const SizedBox(
                     height: 80,
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

               ),
             ],
           ),
         ),
       ),
    ],
     ),
     );
  }
}
