import 'package:flutter/material.dart';

import '../livePreviewPlayer/livePreviewPlayerController.dart';
import 'frostedGlassIcon.dart';

class VideoPlayerMini extends StatefulWidget {
  final LivePreviewPlayerController livePreviewPlayerController;
  final String thumbnailUrl;
  VideoPlayerMini(
      {Key? key,
      required this.livePreviewPlayerController,
      this.thumbnailUrl = "https://picsum.photos/200/200"})
      : super(key: key);

  @override
  State<VideoPlayerMini> createState() => _VideoPlayerMiniState();
}

class _VideoPlayerMiniState extends State<VideoPlayerMini> {
  Widget? _child;

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.transparent,
        child: Center(
          child: _child ??
              Image.network(
                widget.thumbnailUrl,
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
