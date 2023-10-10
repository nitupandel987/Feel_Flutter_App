
import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  String? name;
  String? uid;
  String? image;
  String? email;
  String? description;
  String? youtube;
  String? instagram;
  String? twitter;
  String? facebook;
  String? gender;
  String? dob;


  User({
    this.name,
    this.uid,
    this.image,
    this.email,
    this.youtube,
    this.facebook,
    this.description,
    this.twitter,
    this.instagram,
    this.gender,
    this.dob

  });

  Map<String, dynamic> toJson()=>{
    "name" : name,
    "uid" : uid,
    "image" : image,
    "email" : email,
    "youtube" : youtube,
    "facebook" : facebook,
    "twitter" : twitter,
    "description":description,
    "instagram" : instagram,
    "gender":gender,
    "dob": dob
  };

  static User fromSnap(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return User(
      name: dataSnapshot["name"],
      uid: dataSnapshot["uid"],
      email: dataSnapshot["email"],
      image: dataSnapshot["image"],
      youtube: dataSnapshot["youtube"],
      twitter: dataSnapshot["twitter"],
      instagram: dataSnapshot["instagram"],
      facebook: dataSnapshot["facebook"],
        description: dataSnapshot["description"],
      gender: dataSnapshot["gender"],
        dob: dataSnapshot["dob"]
    );
  }

}