import 'dart:io';
import 'package:feel/Home/upload_video/upload_controller.dart';
import 'package:feel/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/input_text_widget.dart';


class UploadForm extends StatefulWidget {

  final File videoFile;
  final String videoPath;

  UploadForm({required this.videoFile,required this.videoPath});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {

  UploadController uploadVideoController = Get.put(UploadController());
  VideoPlayerController? playerController;
  TextEditingController artistSongTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);

    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //display video player
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height/1.6,
              child: VideoPlayer(playerController!),
            ),

            const SizedBox(
              height: 30,
            ),


            //if Upload Now - Circular Progress Bar display
            //else input fields
            showProgressBar == true
                ?  Container(
                 child: const SimpleCircularProgressBar(
                progressColors: [
                  Colors.green,
                  Colors.blueAccent,
                  Colors.red,
                  Colors.amber,
                  Colors.purpleAccent
                ],
                animationDuration: 20,
                backColor: Colors.white30,
              ),
            )
                : Column(
                children: [

                  //Artist Song
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20) ,
                    child: InputTextWidget(
                      textEditingController:artistSongTextEditingController,
                      lableString: "Artist - Songs",
                      iconData: Icons.music_video_sharp,
                      isObscure: false,
                      assetRefrence: '',
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),


                  //Description
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20) ,
                    child: InputTextWidget(
                      textEditingController:descriptionTextEditingController,
                      lableString: "Description",
                      iconData: Icons.slideshow_sharp,
                      isObscure: false,
                      assetRefrence: '',
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //upload now button
                  Container(
                    width: MediaQuery.of(context).size.width - 38,
                    height: 54,
                    decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        )
                    ),
                    child: InkWell(
                      onTap: (){

                        if(artistSongTextEditingController.text.isNotEmpty
                            && descriptionTextEditingController.text.isNotEmpty){
                          uploadVideoController.saveVideoInformationToFirestoreDatabase(
                              artistSongTextEditingController.text,
                              descriptionTextEditingController.text,
                              widget.videoPath,
                              context);
                        }
                         setState(() {
                           showProgressBar = true;
                         });
                      },
                      child: const Center(
                        child: Text(
                          "Upload Now",
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
                    height: 10,
                  ),
 
                ],

            ),

          ],
        ),
      ),
    );
  }
}
