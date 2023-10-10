
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feel/Home/home_screen.dart';
import 'package:feel/authentication/login_screen.dart';
import 'package:feel/authentication/registration_screen.dart';
import 'package:feel/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'user.dart' as userModel ;

class AuthenticationController extends GetxController{
  static AuthenticationController instanceAuth = Get.find();
  late Rx<User?> _currentUser;
  late Rx<File?> _pickedFile;
  File? get profileImage => _pickedFile.value;
  void chooseImageFromGallery() async{
    //if you want from camera then write ImageSource.camera
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImageFile != null){
      Get.snackbar(
          "ProfileImage",
          "You Have Successfully selected your profile"
      );

    }
     _pickedFile =  Rx<File?>(File(pickedImageFile!.path));
  }
  void captureImageWithCamera() async{
    //if you want from camera then write ImageSource.camera
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pickedImageFile != null){
      Get.snackbar("ProfileImage", "You Have Successfully Captured the image");

    }
    _pickedFile =  Rx<File?>(File(pickedImageFile!.path));
  }

  void createAccountForNewUser(File imageFile, String userName, String userEmail, String userPassword, String userdescription,String userGender, String userdob) async{
    // Define your password requirements here
    final RegExp passwordRegExp = RegExp(r'^(?=.[0-9])(?=.[!@#$%^&])(?=.[a-zA-Z]).{8,}$');

    if (!passwordRegExp.hasMatch(userPassword)) {
      Get.snackbar("Password Requirements",
          "Password must contain at least 8 characters, including numbers, special characters, and uppercase letters.");
      return; // Return without creating the account
    }


    try{

      //1.create user in the firebase authentication
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );
      //2.Save the user profile image to firebase storage
      String imageDownloadUrl = await uploadImageToStorage(imageFile);


      //3. Save user data to firestore database
      userModel.User user = userModel.User(
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
        uid: credential.user!.uid,
        description: userdescription,
        gender: userGender,
        dob: userdob

      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());
      Get.snackbar("Account Created Successfully",
          "Congratulations! Account has been created!");
      showProgressBar = false;
      Get.to(LoginScreen());

    }
    catch(error){
      Get.snackbar("Account Creation UnSuccessfull",
          "Error Occurred while creating account. Try Again");
      showProgressBar = false;
      // Get.to(LoginScreen());
    }
  }
  Future<String> uploadImageToStorage(File imageFile) async{
    Reference reference = FirebaseStorage.instance.ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);
     UploadTask uploadTask = reference.putFile(imageFile);
     TaskSnapshot taskSnapshot = await uploadTask;
     String downloadUrlOfUploadedImage =  await taskSnapshot.ref.getDownloadURL();
     return downloadUrlOfUploadedImage;
   }
  void loginUserNow(String userEmail, String userPassword) async{
    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword);
      Get.snackbar("Logged in Successfully",
          "You are in!");
      showProgressBar = false;
      // Get.to(HomeScreen());

    }

    catch(error){
      Get.snackbar("Login UnSuccessfull",
          "Error Occurred during Authentication");
      showProgressBar = false;
      Get.to(LoginScreen());
    }
  }

  // Maintain the state of user, when the app is opened
  goToScreen(User? currentUser){
    //when user is not already logged in
    if(currentUser == null){
      Get.offAll(LoginScreen());
    }
    //when user is already logged in
    else{
      Get.offAll(HomeScreen());
    }
  }

  void onReady(){
   super.onReady();
   _currentUser=Rx<User?>(FirebaseAuth.instance.currentUser);
   _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
   ever(_currentUser,goToScreen);

  }
}