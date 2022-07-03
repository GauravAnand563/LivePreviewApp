import 'dart:ui';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets/frostedGlassIcon.dart';
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

  const DefaultVideoPlayer({
    Key? key,
    required this.livePreviewPlayerController,
    this.isFullscreen = false,
  }) : super(key: key);

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
    if (widget.livePreviewPlayerController.videoPlayerController.value
        .isInitialized) {
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
        child: Stack(
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
        ),
      );
    } else {
      return const SizedBox();
    }
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
        padding: EdgeInsets.all(5),
        width: double.infinity,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),
          child: _controlsVisible
              ? Column(
                  // children: [
                  //   if (widget.livePreviewPlayerController
                  //       .customVideoPlayerSettings.settingsButtonAvailable)
                  //     Align(
                  //       alignment: Alignment.topLeft,
                  //       child: VideoSettingsButton(
                  //         livePreviewPlayerController:
                  //             widget.livePreviewPlayerController,
                  //         updateVideoState: widget.updateVideoState,
                  //       ),
                  //     ),
                  //   const Spacer(),
                  //   if (widget.livePreviewPlayerController
                  //       .customVideoPlayerSettings.controlBarAvailable)
                  //     CustomVideoPlayerControlBar(
                  //       livePreviewPlayerController:
                  //           widget.livePreviewPlayerController,
                  //       updateVideoState: widget.updateVideoState,
                  //       fadeOutOnPlay: _fadeOutControls,
                  //     ),
                  // ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(Icons.crop_free_rounded),
                    ),
                    FrostedGlassIcon(
                      child: Icon(CupertinoIcons.play),
                      // onTap: togglePlay,
                    ),
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2),
                          ),
                          height: 50,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LinearProgressIndicator(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Spacer(),
                                  Icon(CupertinoIcons.play),
                                  Spacer(),
                                  Text(
                                    '05:12 / 10:27',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Spacer(
                                    flex: 16,
                                  ),
                                  Icon(CupertinoIcons.bookmark),
                                  Spacer(),
                                  Icon(Icons.tune),
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
