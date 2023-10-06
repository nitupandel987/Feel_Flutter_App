import 'package:cloud_firestore/cloud_firestore.dart';

class Video
{
  String? userName;
  String? userID;
  String? userProfileImage;
  String? videoID;
  int? totalComments;
  List? likesList;
  //Share Feature
  int? totalShares;
  String? artistSongName;
  String? descriptionTags;
  String? videoUrl;
  String? thumbnailUrl;
  int? publishedDateTime;

  Video({
    this.userID,
    this.userName,
    this.userProfileImage,
    this.videoID,
    this.totalComments,
    this.totalShares,
    this.likesList,
    this.artistSongName,
    this.descriptionTags,
    this.videoUrl,
    this.thumbnailUrl,
    this.publishedDateTime,
});
Map<String, dynamic> toJson() => {
  "userID" : userName,
  "userName" : userName,
  "userProfileImage":userProfileImage,
  "videoID" : videoID,
  "totalComments" : totalComments,
  "totalShares" : totalShares,
  "likesList" : likesList,
  "artistSongName" : artistSongName,
  "descriptionTags" : descriptionTags,
  "videoUrl" : videoUrl,
  "thumbnailUrl":thumbnailUrl,
  "publishedDateTime":publishedDateTime
};
static Video fromDocumentSnapshot(DocumentSnapshot snapshot){
  var docSnapshot = snapshot.data() as Map<String, dynamic>;
  return Video(
    userID: docSnapshot["userID"],
    userName: docSnapshot["userName"],
    userProfileImage: docSnapshot["userProfileImage"],
    videoID: docSnapshot["videoID"],
    totalComments: docSnapshot["totalComments"],
    totalShares: docSnapshot["totalShares"],
    likesList: docSnapshot["likesList"],
    artistSongName: docSnapshot["artistSongName"],
    descriptionTags: docSnapshot["descriptionTags"],
    videoUrl: docSnapshot["videoUrl"],
    thumbnailUrl: docSnapshot["thumbnailUrl"],
    publishedDateTime: docSnapshot["publishedDateTime"],

  );
}
}