import 'dart:async';
import 'dart:io';

//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoRecording extends StatefulWidget {
  VideoRecording({Key? key}) : super(key: key);

  @override
  _VideoRecordingState createState() => _VideoRecordingState();
}

class _VideoRecordingState extends State<VideoRecording> {
  late File _storedVideo;
  final videoPicker = ImagePicker();
  VideoPlayerController? videoPlayerController;
  Future<void> _takeVideo() async {
    final vedioFile = await videoPicker.pickVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 10));
    if (vedioFile == null) {
      return;
    }
    setState(() {
      _storedVideo = File(vedioFile.path);
    });
    videoPlayerController = VideoPlayerController.file(_storedVideo)
      ..initialize().then((_) {
        setState(() {});
        videoPlayerController!.play(); //.pause() for pausing
        videoPlayerController!.setVolume(0.0);
      });
  }

// void _recordVideo() async {
//       var videoPath=_storedVideo.path;
//      videoPlayerController =
//         VideoPlayerController.file(_storedVideo)
//         ..initialize().then((_) {
//            setState(() {});
//              videoPlayerController.play(); //.pause() for pausing
//              videoPlayerController.setVolume(0.0);
//         });
//    setState(() { });
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: _takeVideo,
        child: Container(
            height: 500,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
                aspectRatio: videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(videoPlayerController!))),
      ),
    );
  }
}
