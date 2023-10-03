import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}


class _UploadVideoScreenState extends State<UploadVideoScreen> {
 displayDialogBox(){
   return showDialog(
       context: context,
       builder: (context) => SimpleDialog(
         children: [
           //For Gallery
           SimpleDialogOption(
             onPressed: (){

             },
             child: const Row(
               children: [
                 Icon(
                   Icons.image,
                 ),
                 Expanded(
                   child: Padding(
                       padding: EdgeInsets.all(8),
                       child: Text(
                           
                           "Get Video from Gallery",
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 14 ,

                            ),
                       ),),
                 ),
                 
               ],
             ),
           ),

           //For Camera
           SimpleDialogOption(
             onPressed: (){

             },
             child: const Row(
               children: [
                 Icon(
                   Icons.camera_alt,
                 ),
                 Expanded(
                   child: Padding(
                     padding: EdgeInsets.all(8),
                     child: Text(
                       "Make Video With Camera",
                       maxLines: 3,
                       style: TextStyle(
                         fontSize: 14,

                       ),
                     ),),
                 ),

               ],
             ),
           ),

           SimpleDialogOption(
             onPressed: (){
               Get.back();
             },
             child: const Row(
               children: [
                 Icon(
                   Icons.cancel,
                 ),
                 Padding(
                   padding: EdgeInsets.all(8),
                   child: Text(
                     "Cancel",
                     style: TextStyle(
                       fontSize: 13,

                     ),
                   ),),

               ],
             ),
           ),
         ],
       ));
 }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/upload.jpg",
              width: 260,

            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  displayDialogBox();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,

                ),
                child: const Text(
              "Upload New Video",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
