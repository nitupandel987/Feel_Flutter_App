
import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController{
   static AuthenticationController instanceAuth = Get.find();
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
}