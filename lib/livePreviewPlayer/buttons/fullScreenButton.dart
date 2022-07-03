import 'package:flutter/material.dart';

import '../livePreviewPlayerController.dart';

class FullScreenButton extends StatelessWidget {
  final LivePreviewPlayerController livePreviewPlayerController;
  final bool? isFullScreen;
  const FullScreenButton(
      {Key? key, required this.livePreviewPlayerController, this.isFullScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (livePreviewPlayerController.isFullscreen) {
          await livePreviewPlayerController.setFullscreen(false);
        } else {
          await livePreviewPlayerController.setFullscreen(true);
        }
      },
      child: Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.all(20.0),
          child: Icon(!livePreviewPlayerController.isFullscreen
              ? Icons.crop_free_rounded
              : Icons.fullscreen_exit)),
    );
  }
}
