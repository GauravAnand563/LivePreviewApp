import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:livepreview/widgets/frostedGlassIcon.dart';
import 'package:video_player/video_player.dart';

class VideoMiniPlayer extends StatefulWidget {
  const VideoMiniPlayer({Key? key}) : super(key: key);

  @override
  State<VideoMiniPlayer> createState() => _VideoMiniPlayerState();
}

class _VideoMiniPlayerState extends State<VideoMiniPlayer> {
  // late VideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.network(
  //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  bool isPlayed = false;
  void togglePlay() {
    setState(() {
      isPlayed = !isPlayed;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _controller.play();
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
          InkWell(
            onTap: togglePlay,
            child: Container(
              child: Image.network(
                "https://picsum.photos/1200/800",
                fit: BoxFit.fill,
              ),
            ),
          ),
          isPlayed
              ? Container()
              : Container(
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Icons.crop_free_rounded),
                      ),
                      FrostedGlassIcon(
                        child: Icon(CupertinoIcons.play),
                        onTap: togglePlay,
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
                                      style:
                                          Theme.of(context).textTheme.caption,
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
                  ),
                )
        ],
      ),
    );
  }
}
