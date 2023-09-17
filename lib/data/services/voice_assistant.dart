import 'package:flutter/material.dart';
import 'package:med_ez/data/models/api_res_model.dart';
import 'package:med_ez/presentation/screen/video_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VoiceAssistant {
  //Play first video
  void playFirstVideo(BuildContext context, ApiResponse data) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(index: 0, data: data),
        ));
  }

  //Play last video
  void playLastVideo(BuildContext context, ApiResponse data) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(
              index: data.latestAssessment.exercises.length - 1, data: data),
        ));
  }

  //Play next video
  void playNextVideo(BuildContext context, ApiResponse data,
      {required int currIndex}) {
    if (currIndex == data.latestAssessment.exercises.length - 1) {
      currIndex = -1;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VideoPlayerScreen(index: currIndex + 1, data: data),
        ));
  }

  //Play previous video
  void playPreviousVideo(BuildContext context, ApiResponse data,
      {required int currIndex}) {
    if (currIndex == 0) {
      currIndex = data.latestAssessment.exercises.length - 1;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VideoPlayerScreen(index: currIndex - 1, data: data),
        ));
  }

  //Play the video
  void playVideo(BuildContext context,
      {required YoutubePlayerController controller}) {
    debugPrint("PLAYING VIDEO 9999");
    controller.play();
  }

  //Pause the video
  void pauseVideo(BuildContext context,
      {required YoutubePlayerController controller}) {
    controller.pause();
  }

  //Slow down video
  void slowDownVideo(BuildContext context,
      {required YoutubePlayerController controller}) {
    controller.setPlaybackRate(controller.value.playbackRate - 0.25);
  }

  //Fast forward video
  void fastForwardVideo(BuildContext context,
      {required YoutubePlayerController controller}) {
    controller.setPlaybackRate(controller.value.playbackRate + 0.25);
  }

  //Set video speed
  void setVideoSpeed(BuildContext context,
      {required YoutubePlayerController controller, required double speed}) {
    controller.setPlaybackRate(speed);
  }

  //Reset the speed
  void resetSpeed(BuildContext context,
      {required YoutubePlayerController controller}) {
    controller.setPlaybackRate(1.25);
  }

  //Skip duration
  void forwardVideo(BuildContext context,
      {required YoutubePlayerController controller, int seconds = 10}) {
    controller.seekTo(
        Duration(seconds: controller.value.position.inSeconds + seconds));
  }

  //Rewind duration
  void rewindVideo(BuildContext context,
      {required YoutubePlayerController controller, int seconds = 10}) {
    controller.seekTo(
        Duration(seconds: controller.value.position.inSeconds - seconds));
  }

  //Increase Volume
  void increaseVolume(BuildContext context,
      {required YoutubePlayerController controller}) {
    controller.setVolume(controller.value.volume + 1);
  }

  //Decrease Volume
  void decreaseVolume(BuildContext context,
      {required YoutubePlayerController controller}) {
    controller.setVolume(controller.value.volume - 1);
  }

  void navigateBack(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void handleCommands(
      {required String command,
      required BuildContext context,
      required YoutubePlayerController controller,
      required ApiResponse data,
      required int currIndex}) {
    switch (command) {
      case "play_video":
        debugPrint("PLAY VIDEO");
        playVideo(context, controller: controller);
        break;
      case "pause_video":
        pauseVideo(context, controller: controller);
        break;
      case "play_next_video":
        playNextVideo(context, data, currIndex: currIndex);
        break;
      case "play_previous_video":
        playPreviousVideo(context, data, currIndex: currIndex);
        break;
      case "play_first_video":
        debugPrint("999666");
        playFirstVideo(context, data);
        break;
      case "play_last_video":
        playLastVideo(context, data);
        break;
      case "slow_down":
        slowDownVideo(context, controller: controller);
        break;
      case "fast_forward":
        fastForwardVideo(context, controller: controller);
        break;
      // case "set_video_speed":
      //   setVideoSpeed(context, controller: controller, speed: );
      //   // const speedFactor = incomingCommandObject.speedFactor;
      //   // Implement logic to set video speed to the specified factor
      //   break;
      case "reset_video_speed":
        resetSpeed(context, controller: controller);
        break;
      case "increase_volume":
        increaseVolume(context, controller: controller);
        break;
      case "decrease_volume":
        decreaseVolume(context, controller: controller);
        break;
      case "skip_next_seconds":
        forwardVideo(context, controller: controller, seconds: 10);
        break;
      case "rewind_seconds":
        rewindVideo(context, controller: controller, seconds: 10);
        break;
      case "skip_seconds_forward":
        forwardVideo(context, controller: controller);
        break;
      case "skip_seconds_back":
        rewindVideo(context, controller: controller);
        break;
      case "navigate_back":
        navigateBack(context);
        break;

      default:
        Navigator.pushNamed(context, '/error');
    }
  }
}
