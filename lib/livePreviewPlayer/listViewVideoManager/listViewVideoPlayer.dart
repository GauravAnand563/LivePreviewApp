import 'package:flutter/material.dart';
import '../livePreviewPlayer.dart';
import '../livePreviewPlayerController.dart';
import '../../widgets/videoMiniPlayer.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'listViewVideoManager.dart';

class ListViewVideoPlayer extends StatefulWidget {
  const ListViewVideoPlayer(
      {Key? key,
      required this.url,
      this.image,
      required this.listViewVideoManager})
      : super(key: key);

  final String url;
  final String? image;
  final ListViewVideoManager listViewVideoManager;

  @override
  _ListViewVideoPlayerState createState() => _ListViewVideoPlayerState();
}

class _ListViewVideoPlayerState extends State<ListViewVideoPlayer> {
  late LivePreviewPlayerController livePreviewPlayerController;
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((value) => setState(() {}));
    livePreviewPlayerController = LivePreviewPlayerController(
        context: context, videoPlayerController: videoPlayerController);
    widget.listViewVideoManager.init(livePreviewPlayerController);

    super.initState();
  }

  @override
  void dispose() {
    widget.listViewVideoManager.remove(livePreviewPlayerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(livePreviewPlayerController),
      onVisibilityChanged: (visiblityInfo) {
        if (visiblityInfo.visibleFraction > 0.9) {
          widget.listViewVideoManager.play(livePreviewPlayerController);
        }
      },
      child: Container(
        child: (livePreviewPlayerController
                .videoPlayerController.value.isInitialized)
            ? LivePreviewPlayer(
                livePreviewPlayerController: livePreviewPlayerController,
              )
            : AspectRatio(
              aspectRatio: 16/9,
              child: Image.network(
                  widget.image!,
                ),
            ),
        // child: VideoPlayerMini(livePreviewPlayerController: livePreviewPlayerController, thumbnailUrl: widget.image!,),
      ),
    );
  }
}
