import 'package:flutter/material.dart';
import '../widgets/frostedGlassIcon.dart';
import '../livePreviewPlayer/livePreviewPlayer.dart';
import '../livePreviewPlayer/livePreviewPlayerController.dart';
import 'package:video_player/video_player.dart';
import '../constants.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  late VideoPlayerController videoPlayerController;
  late LivePreviewPlayerController _livePreviewPlayerController;
  Widget? _child;
  String videoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  String thumbnailUrl = "https://picsum.photos/200/200";
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) => setState(() {}));
    _livePreviewPlayerController = LivePreviewPlayerController(
        context: context, videoPlayerController: videoPlayerController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          _child = LivePreviewPlayer(
              livePreviewPlayerController: _livePreviewPlayerController);
          // _livePreviewPlayerController.videoPlayerController.play();
        });
      });
    });
  }

  @override
  void dispose() {
    _livePreviewPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.transparent,
        child: Center(
          child: _child ??
              Image.network(
                thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
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
                        child: child);
                  }
                  return Container(
                    constraints: BoxConstraints.tight(Size(50, 50)),
                    child: FrostedGlassIcon(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  );
                },
              ),
        ));
  }
}
