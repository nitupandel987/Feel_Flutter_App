import 'package:feel/Home/following/followings_video_screen.dart';
import 'package:feel/Home/for_you/for_you_video_screen.dart';
import 'package:feel/Home/profile/profile_screen.dart';
import 'package:feel/Home/search/search_screen.dart';
import 'package:feel/Home/upload_video/upload_custom_icon.dart';
import 'package:feel/Home/upload_video/upload_video_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int screenIndex = 0;
  List screensList = [
    ForYouVideoScreen(),
    SearchScreen(),
    UploadVideoScreen(),
    FollowingVideoScreen(),
    ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    // Add a debug statement to check if the build method is called.

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            icon: UploadCustomIcon(),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_sharp, size: 30),
            label: "Following",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "Profile",
          ),

        ],
      ),
      body: screensList[screenIndex],
    );
  }
  }
