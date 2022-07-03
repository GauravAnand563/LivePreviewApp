import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../livePreviewPlayerController.dart';

import '../../widgets/frostedGlassIcon.dart';

class PlayPauseButton extends StatelessWidget {
  final LivePreviewPlayerController livePreviewPlayerController;
  final Function fadeOutOnPlay;
  const PlayPauseButton({
    Key? key,
    required this.livePreviewPlayerController,
    required this.fadeOutOnPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: livePreviewPlayerController.isPlayingNotifier,
        builder: (context, isPlaying, _) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _playPause(isPlaying),
            child: isPlaying ? LivePlayerPauseButton() : LivePlayerPlayButton(),
          );
        });
  }

  Future<void> _playPause(bool isPlaying) async {
    if (isPlaying) {
      await livePreviewPlayerController.videoPlayerController.pause();
    } else {
      await livePreviewPlayerController.videoPlayerController.play();
      fadeOutOnPlay();
    }
  }
}

class LivePlayerPlayButton extends StatelessWidget {
  const LivePlayerPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(23)),
            child: Icon(CupertinoIcons.play),
          ),
        ),
      ),
    );
  }
}

class LivePlayerPauseButton extends StatelessWidget {
  const LivePlayerPauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(23)),
            child: Icon(CupertinoIcons.pause),
          ),
        ),
      ),
    );
  }
}
