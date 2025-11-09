import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoExample extends StatefulWidget {
  @override
  _VideoExampleState createState() => _VideoExampleState();
}

class _VideoExampleState extends State<VideoExample> {
  late VideoPlayerController _controller;
  @override
  void initState(){
    super.initState();
      _controller = VideoPlayerController.networkUrl(
        Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
        )..initialize().then((_){
          setState(() {});
          _controller.play();
        });
      }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return _controller.value.isInitialized 
      ? Column(
        children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        ElevatedButton(
          onPressed: () => _controller.play(), 
          child: Text("Play")
        ),
        ElevatedButton(
          onPressed: () => _controller.pause(), 
          child: Text("Pause")
        ),
      ],
    ) : CircularProgressIndicator();
  }
}