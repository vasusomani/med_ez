import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../Constants/colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    super.key,
    required this.url,
    required this.exerciseName,
  });
  final String url;
  final String exerciseName;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future _initializeVideoPlayerFuture;
  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {});
    });
    super.initState();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appBarColor,
              title: Text(widget.exerciseName),
            ),
            body: Center(
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(
                  _videoPlayerController,
                ),
              ),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: appBarColor,
            // valueColor: AlwaysStoppedAnimation(primaryColor),
          ));
        }
      },
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.exerciseName, overflow: TextOverflow.ellipsis),
  //     ),
  //     body: Stack(
  //       children: [
  //         VideoPlayer(
  //           initialUrl: widget.url,
  //           javascriptMode: JavascriptMode.unrestricted,
  //           onPageFinished: (_) {
  //             setState(() {
  //               isLoading = false;
  //             });
  //           },
  //         ),
  //         if (isLoading)
  //           const Center(
  //             child: CircularProgressIndicator(color: appBarColor),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
