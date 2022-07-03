import 'dart:ui';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livepreview/livePreviewPlayer/buttons/playPauseButton.dart';
import 'package:livepreview/livePreviewPlayer/buttons/progressBar.dart';
import 'package:video_player/video_player.dart';

import 'buttons/fullScreenButton.dart';
import 'livePreviewPlayerController.dart';

class LivePreviewPlayer extends StatelessWidget {
  final LivePreviewPlayerController livePreviewPlayerController;
  const LivePreviewPlayer({
    Key? key,
    required this.livePreviewPlayerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultVideoPlayer(
      isFullscreen: false,
      livePreviewPlayerController: livePreviewPlayerController,
    );
  }
}

class DefaultVideoPlayer extends StatefulWidget {
  final LivePreviewPlayerController livePreviewPlayerController;
  final bool isFullscreen;
  final String? thumbnail;
  const DefaultVideoPlayer(
      {Key? key,
      required this.livePreviewPlayerController,
      this.isFullscreen = false,
      this.thumbnail})
      : super(key: key);

  @override
  State<DefaultVideoPlayer> createState() => _DefaultVideoPlayerState();
}

class _DefaultVideoPlayerState extends State<DefaultVideoPlayer> {
  @override
  void initState() {
    super.initState();

    if (!widget.isFullscreen) {
      widget.livePreviewPlayerController.updateViewAfterFullscreen =
          _updateVideoState;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.livePreviewPlayerController.videoPlayerController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: widget.livePreviewPlayerController.videoPlayerController
            .value.aspectRatio,
        child: overlayStack(),
      );
    } else if (widget.thumbnail != null) {
      return Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                blurRadius: 20,
                offset: Offset(1, 1))
          ],
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Image.network(widget.thumbnail!),
      );
    } else {
      return Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                blurRadius: 20,
                offset: Offset(1, 1))
          ],
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.background,
        ),
      );
    }
  }

  Stack overlayStack() {
    return Stack(
      children: [
        Container(
          color: Colors.red,
        ),
        Center(
          child: AspectRatio(
            aspectRatio: widget.livePreviewPlayerController
                .videoPlayerController.value.aspectRatio,
            child: IgnorePointer(
              child: VideoPlayer(
                widget.livePreviewPlayerController.videoPlayerController,
              ),
            ),
          ),
        ),
        LivePreviewControlsOverlay(
          livePreviewPlayerController: widget.livePreviewPlayerController,
          updateVideoState: _updateVideoState,
        ),
      ],
    );
  }

  void _updateVideoState() {
    if (mounted) {
      setState(() {});
    }
  }
}

class DefaultVideoPlayerFullScreen extends StatefulWidget {
  final LivePreviewPlayerController livePreviewPlayerController;
  final bool isFullscreen;

  const DefaultVideoPlayerFullScreen({
    Key? key,
    required this.livePreviewPlayerController,
    this.isFullscreen = false,
  }) : super(key: key);

  @override
  State<DefaultVideoPlayerFullScreen> createState() =>
      _DefaultVideoPlayerFullScreenState();
}

class _DefaultVideoPlayerFullScreenState
    extends State<DefaultVideoPlayerFullScreen> {
  @override
  void initState() {
    super.initState();

    if (!widget.isFullscreen) {
      widget.livePreviewPlayerController.updateViewAfterFullscreen =
          _updateVideoState;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.livePreviewPlayerController.videoPlayerController.value
        .isInitialized) {
      return AspectRatio(
        aspectRatio: widget.livePreviewPlayerController.videoPlayerController
            .value.aspectRatio,
        child: overlayStack(),
      );
    } else {
      return const SizedBox();
    }
  }

  Stack overlayStack() {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Center(
          child: AspectRatio(
            aspectRatio: widget.livePreviewPlayerController
                .videoPlayerController.value.aspectRatio,
            child: IgnorePointer(
              child: VideoPlayer(
                widget.livePreviewPlayerController.videoPlayerController,
              ),
            ),
          ),
        ),
        LivePreviewControlsOverlay(
          livePreviewPlayerController: widget.livePreviewPlayerController,
          updateVideoState: _updateVideoState,
        ),
      ],
    );
  }

  void _updateVideoState() {
    if (mounted) {
      setState(() {});
    }
  }
}

class LivePreviewControlsOverlay extends StatefulWidget {
  final LivePreviewPlayerController livePreviewPlayerController;
  final Function updateVideoState;
  const LivePreviewControlsOverlay({
    Key? key,
    required this.livePreviewPlayerController,
    required this.updateVideoState,
  }) : super(key: key);

  @override
  State<LivePreviewControlsOverlay> createState() => _AllControlsOverlayState();
}

class _AllControlsOverlayState extends State<LivePreviewControlsOverlay> {
  bool _controlsVisible = true;
  int _visibilityToggleCounter = 0;

  @override
  void initState() {
    super.initState();
    _fadeOutControls();
    widget.livePreviewPlayerController.isPlayingNotifier
        .addListener(_listenToPlayStateChanges);
  }

  @override
  void dispose() {
    widget.livePreviewPlayerController.isPlayingNotifier
        .removeListener(_listenToPlayStateChanges);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _toggleControlsVisibility(context),
      child: Container(
        // padding: EdgeInsets.all(5),
        width: double.infinity,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          child: _controlsVisible
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FullScreenButton(
                      livePreviewPlayerController:
                          widget.livePreviewPlayerController,
                    ),
                    PlayPauseButton(
                      livePreviewPlayerController:
                          widget.livePreviewPlayerController,
                      fadeOutOnPlay: _fadeOutControls,
                    ),
                    ControlPanel(
                      livePreviewPlayerController:
                          widget.livePreviewPlayerController,
                      fadeOutOnPlay: _fadeOutControls,
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  void _listenToPlayStateChanges() {
    if (widget.livePreviewPlayerController.isPlayingNotifier.value) {
      _fadeOutControls();
    }
  }

  void _toggleControlsVisibility(BuildContext context) {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
    if (_controlsVisible) {
      _fadeOutControls();
    }
  }

  Future<void> _fadeOutControls() async {
    _visibilityToggleCounter++;
    await Future.delayed(const Duration(seconds: 3), () {
      _visibilityToggleCounter--;

      // only toggle visibility if the video is playing
      if (widget
          .livePreviewPlayerController.videoPlayerController.value.isPlaying) {
        if (_controlsVisible && _visibilityToggleCounter == 0) {
          if (mounted) {
            setState(() {
              _controlsVisible = false;
            });
          }
        }
      }
    });
  }
}

class ControlPanel extends StatelessWidget {
  final LivePreviewPlayerController livePreviewPlayerController;
  final Function fadeOutOnPlay;
  const ControlPanel(
      {Key? key,
      required this.livePreviewPlayerController,
      required this.fadeOutOnPlay})
      : super(key: key);

  String getDurationAsString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration > const Duration(hours: 1)) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          height: 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LivePlayerProgressBar(
                livePreviewPlayerController: livePreviewPlayerController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  // PlayPauseButton(
                  //     livePreviewPlayerController: livePreviewPlayerController,
                  //     fadeOutOnPlay: fadeOutOnPlay),
                  // Spacer(),
                  ValueListenableBuilder<Duration>(
                    valueListenable:
                        livePreviewPlayerController.videoProgressNotifier,
                    builder: ((context, progress, child) {
                      return Text(
                        getDurationAsString(progress),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      );
                    }),
                  ),
                  Text(
                    '  /  ${getDurationAsString(livePreviewPlayerController.videoPlayerController.value.duration)}',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white),
                  ),
                  Spacer(
                    flex: 12,
                  ),
                  Icon(CupertinoIcons.bookmark),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
