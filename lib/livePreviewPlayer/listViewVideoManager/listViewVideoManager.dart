import 'package:flutter/material.dart';
import 'package:livepreview/livePreviewPlayer/livePreviewPlayerController.dart';

class ListViewVideoManager {
  List<LivePreviewPlayerController> _livePreviewPlayerController = [];
  LivePreviewPlayerController? _activeLivePreviewController;
  bool _isMute = false;

  init(LivePreviewPlayerController livePreviewPlayerController) {
    _livePreviewPlayerController.add(livePreviewPlayerController);
    if (_isMute) {
      livePreviewPlayerController.videoPlayerController.setVolume(0);
    } else {
      livePreviewPlayerController.videoPlayerController.setVolume(0.5);
    }
    if (_livePreviewPlayerController.length == 1) {
      play(livePreviewPlayerController);
    }
  }

  remove(LivePreviewPlayerController livePreviewPlayerController) {
    if (_activeLivePreviewController == livePreviewPlayerController) {
      _activeLivePreviewController = null;
    }
    livePreviewPlayerController.dispose();
    _livePreviewPlayerController.remove(livePreviewPlayerController);
  }

  togglePlay(LivePreviewPlayerController livePreviewPlayerController) {
    if (_activeLivePreviewController?.videoPlayerController.value.isPlaying ==
            true &&
        livePreviewPlayerController == _activeLivePreviewController) {
      pause();
    } else {
      play(livePreviewPlayerController);
    }
  }

  pause() {
    _activeLivePreviewController?.videoPlayerController.pause();
  }

  play([LivePreviewPlayerController? livePreviewPlayerController]) {
    if (livePreviewPlayerController != null) {
      _activeLivePreviewController?.videoPlayerController.pause();
      _activeLivePreviewController = livePreviewPlayerController;
    }

    if (_isMute) {
      _activeLivePreviewController?.videoPlayerController.setVolume(0);
    } else {
      _activeLivePreviewController?.videoPlayerController.setVolume(0.5);
    }

    _activeLivePreviewController?.videoPlayerController.play();
  }

  toggleMute() {
    _activeLivePreviewController?.videoPlayerController.setVolume(
      _activeLivePreviewController!.videoPlayerController.value.volume > 0 ? 0 : 0.5
    );
    
    _isMute =
        _activeLivePreviewController?.videoPlayerController.value.volume == 0;
    if (_isMute) {
      _livePreviewPlayerController
          .forEach((manager) => manager.videoPlayerController.setVolume(0));
    } else {
      _livePreviewPlayerController
          .forEach((manager) => manager.videoPlayerController.setVolume(0.5));
    }
  }
}
