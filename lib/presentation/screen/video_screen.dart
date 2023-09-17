import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../data/models/api_res_model.dart';
import '../../Constants/colors.dart';
import '../../data/services/voice_assistant.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  const VideoPlayerScreen({
    super.key,
    required this.index,
    required this.data,
  });
  final int index;
  final ApiResponse? data;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late YoutubePlayerController _videoController;
  bool isFullScreen = false;
  @override
  void initState() {
    debugPrint(
        widget.data!.latestAssessment.exercises[widget.index].link.toString());
    // final videoID = YoutubePlayer.convertUrlToId(
    //     "https://www.youtube.com/watch?v=Hk5-7RFSsR0");
    debugPrint(
        widget.data!.latestAssessment.exercises[widget.index].link.toString());
    final videoID = YoutubePlayer.convertUrlToId(
        widget.data!.latestAssessment.exercises[widget.index].link.toString());
    if (videoID == null) {
      debugPrint("VIDEOID NULL");
    }
    _videoController = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          hideThumbnail: true,
          controlsVisibleAtStart: true,
        ));
    super.initState();
  }

  _VideoPlayerScreenState() {
    AlanVoice.onCommand.add((command) {
      debugPrint(command.data["command"]);
      switch (command.data["command"]) {
        case "play_video":
          debugPrint("PLAY VIDEO");
          VoiceAssistant().playVideo(context, controller: _videoController);
          break;
        case "pause_video":
          VoiceAssistant().pauseVideo(context, controller: _videoController);
          break;
        case "play_next_video":
          VoiceAssistant()
              .playNextVideo(context, widget.data!, currIndex: widget.index);
          break;
        case "play_previous_video":
          VoiceAssistant().playPreviousVideo(context, widget.data!,
              currIndex: widget.index);
          break;
        case "play_first_video":
          debugPrint("999666");
          VoiceAssistant().playFirstVideo(context, widget.data!);
          break;
        case "play_last_video":
          VoiceAssistant().playLastVideo(context, widget.data!);
          break;
        case "slow_down":
          VoiceAssistant().slowDownVideo(context, controller: _videoController);
          break;
        case "fast_forward":
          VoiceAssistant()
              .fastForwardVideo(context, controller: _videoController);
          break;
        case "navigate_back":
          VoiceAssistant().navigateBack(context);
          break;
        case "reset_video_speed":
          VoiceAssistant().resetSpeed(context, controller: _videoController);
          break;
        case "increase_volume":
          VoiceAssistant()
              .increaseVolume(context, controller: _videoController);
          break;
        case "decrease_volume":
          VoiceAssistant()
              .decreaseVolume(context, controller: _videoController);
          break;
        case "skip_next_seconds":
          VoiceAssistant().forwardVideo(context, controller: _videoController);
          break;
        case "rewind_seconds":
          VoiceAssistant().rewindVideo(context, controller: _videoController);
          break;
        case "skip_seconds_forward":
          VoiceAssistant().forwardVideo(context, controller: _videoController);
          break;
        case "skip_seconds_back":
          VoiceAssistant().rewindVideo(context, controller: _videoController);
          break;
        default:
          Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AlanVoice.setWakewordEnabled(true);
    AlanVoice.activate();
    AlanVoice.showButton();
    return Scaffold(
      appBar: (isFullScreen)
          ? null
          : AppBar(
              leading: IconButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(widget.data!.latestAssessment.exercises[widget.index]
                  .nameOfExercise)),
      body: Center(
        child: SafeArea(
          child: YoutubePlayer(
            width: MediaQuery.sizeOf(context).width,
            controller: _videoController,
            showVideoProgressIndicator: true,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                    playedColor: primaryColor,
                    bufferedColor: primaryColor,
                  )),
              RemainingDuration(),
              const PlaybackSpeedButton(
                  icon: Icon(Icons.speed, color: primaryColor)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isFullScreen = !isFullScreen;
                      _videoController.toggleFullScreenMode();
                      if (isFullScreen) {
                        AlanVoice.hideButton();
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.immersive);
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                            overlays: [SystemUiOverlay.bottom]);
                      } else {
                        AlanVoice.showButton();
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.edgeToEdge);
                      }
                    });
                  },
                  icon: (isFullScreen)
                      ? const Icon(Icons.fullscreen_exit, color: primaryColor)
                      : const Icon(Icons.fullscreen, color: primaryColor))
            ],
            liveUIColor: primaryColor,
            progressIndicatorColor: primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // AlanVoice.onCommand.remove((command) {});
    // _videoController.dispose();
    super.dispose();
  }
}
