import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feel/Home/home_screen.dart';
import 'package:feel/Home/upload_video/video.dart';
import 'package:feel/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadController extends GetxController {

  compressVideoFile(String videoFilePath) async
  {
       final compressedVideoFile = await VideoCompress.compressVideo(videoFilePath, quality: VideoQuality.LowQuality);

       return compressedVideoFile!.file;

  }

  uploadCompressedVideoFileToFirebaseStorage(String videoID, String videoFilePath) async{
    UploadTask videoUploadTask = FirebaseStorage.instance.ref()
        .child("All Videos")
        .child(videoID)
        .putFile(await compressVideoFile(videoFilePath));

     TaskSnapshot snapshot = await videoUploadTask;
     String downloadUrlOfUploadedVideo = await snapshot.ref.getDownloadURL();

     return downloadUrlOfUploadedVideo;


  }

  getThumbnailImage(String videoFilePath) async
  {
    final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);

    return thumbnailImage;
  }

  uploadThumbnailImageFileToFirebaseStorage(String videoID, String videoFilePath) async{
    UploadTask thumbnailUploadTask = FirebaseStorage.instance.ref()
        .child("All Thumbnails")
        .child(videoID)
        .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailUploadTask;
    String downloadUrlOfUploadedVideo = await snapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedVideo;
  }
  
  saveVideoInformationToFirestoreDatabase(String artistSongName, String descriptionTags, String videoFilePath, BuildContext context) async
  {
    try{

      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      String videoId = DateTime.now().millisecondsSinceEpoch.toString();

      //1. Upload video to storage
      String videoDownloadUrl = await uploadCompressedVideoFileToFirebaseStorage(videoId, videoFilePath);

      //2. Upload thumbnail to Storage
      String thumbnailDownloadUrl = await uploadThumbnailImageFileToFirebaseStorage(videoId, videoFilePath);

      //3. Save Overall video Info to firebase database

      Video videoObject = Video(
        userID: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        userProfileImage: (userDocumentSnapshot.data() as Map<String, dynamic>)["image"],
        videoID: videoId,
        totalComments: 0,
        totalShares: 0,
        likesList: [],
        artistSongName: artistSongName,
        descriptionTags: descriptionTags,
        videoUrl: videoDownloadUrl,
        thumbnailUrl: thumbnailDownloadUrl,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch


      );

      await FirebaseFirestore.instance.collection("videos").doc(videoId).set(videoObject.toJson());

      Get.to(HomeScreen());
      Get.snackbar("New Video", "You have Successfully uploaded your new video");
       showProgressBar = false;

    } 
    catch(errorMsg){
      Get.snackbar("Video Upload Unsuccessfull", "Your video is not uploaded due to error occurred");

    }
    
  }


}