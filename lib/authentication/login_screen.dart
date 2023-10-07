import 'package:feel/authentication/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../global.dart';
import '../widgets/input_text_widget.dart';
import 'authentication_controller.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();
  var authenticationController = AuthenticationController.instanceAuth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage( "images/back.png"),fit: BoxFit.cover
            ),
          ),

          child: Container(
          width:  MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20) ,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),


                Text(
                  "Learning",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 34,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ) ,
                ),


                const SizedBox(
                  height: 30,
                ),

                Text(
                  "From",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 34,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ) ,
                ),


                const SizedBox(
                  height: 30,
                ),

                Text(
                  "Shiva",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 34,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ) ,
                ),


                const SizedBox(
                  height: 50,
                ),

                //email
                Container(
                  width:  MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20) ,
                  child: InputTextWidget(
                    textEditingController:emailTextEditingController,
                    lableString: "Email",
                    iconData: Icons.email_outlined,
                    isObscure: false,

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
                    isObscure: true,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                //Login Button

                showProgressBar == false ?
                Column(
                  children: [

                    //login Button

                    Container(
                      width: MediaQuery.of(context).size.width - 38,
                      height: 54,
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                      ),
                      child: InkWell(
                        onTap: (){


                          //login user now
                          if(emailTextEditingController.text.isNotEmpty
                              && passTextEditingController.text.isNotEmpty){
                            setState(() {
                              showProgressBar = true;
                            });

                            authenticationController.loginUserNow(
                              emailTextEditingController.text,
                              passTextEditingController.text,
                            );

                          }
                        },

                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
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
                        const Text("Don't Have an account ? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),),
                        InkWell(
                          onTap: (){
                            //send user to signup screen
                             Get.to(RegistrationScreen());

                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                      ],
                    ),
                  ],
                ) : Container(
                  //show animation
                  child: const SimpleCircularProgressBar(
                    progressColors: [
                      Colors.green,
                      Colors.blueAccent,
                    ],
                    animationDuration: 2,
                    backColor: Colors.white30,

                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
