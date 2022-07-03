// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:livepreview/livePreviewPlayer/livePreviewPlayerController.dart';
// import 'frostedGlassIcon.dart';
// import 'package:video_player/video_player.dart';

// class VideoMiniPlayer extends StatefulWidget {
//   late String thumbnail;
//   late String videoUrl;
//   VideoMiniPlayer(
//       {Key? key,
//       required this.thumbnail,
//       required this.videoUrl})
//       : super(key: key);

//   @override
//   State<VideoMiniPlayer> createState() => _VideoMiniPlayerState();
// }

// class _VideoMiniPlayerState extends State<VideoMiniPlayer> {
//   late VideoPlayerController videoPlayerController;
//   Image _image;
//   @override
//   void initState() {
//     super.initState();
//     _image = Image.network(
//       widget.thumbnail,
//     );
//     videoPlayerController = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((value) => setState(() {}));
//     _livePreviewPlayerController = LivePreviewPlayerController(
//         context: context, videoPlayerController: videoPlayerController);
//   }

//   @override
//   Widget build(BuildContext context) {}
// }
