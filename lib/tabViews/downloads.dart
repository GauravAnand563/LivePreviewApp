import 'package:flutter/material.dart';
import 'package:livepreview/livePreviewPlayer/livePreviewPlayer.dart';
import 'package:livepreview/livePreviewPlayer/livePreviewPlayerController.dart';
import 'package:video_player/video_player.dart';
import '../appinio_video_player.dart';
import '../constants.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  late LivePreviewPlayerController _livePreviewPlayerController;

  String videoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) => setState(() {}));

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );

    _livePreviewPlayerController = LivePreviewPlayerController(
        context: context, videoPlayerController: videoPlayerController);
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // CustomVideoPlayer(
            //     customVideoPlayerController: _customVideoPlayerController),
            LivePreviewPlayer(
                livePreviewPlayerController: _livePreviewPlayerController)
          ],
        ),
      ),
    );
  }
}
