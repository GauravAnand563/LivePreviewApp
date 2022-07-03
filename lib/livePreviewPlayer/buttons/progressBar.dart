import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../livePreviewPlayerController.dart';
import 'package:video_player/video_player.dart';

class LivePlayerProgressBar extends StatefulWidget {
  final LivePreviewPlayerController livePreviewPlayerController;

  const LivePlayerProgressBar({
    Key? key,
    required this.livePreviewPlayerController,
  }) : super(key: key);

  @override
  _VideoProgressIndicatorState createState() => _VideoProgressIndicatorState();
}

class _VideoProgressIndicatorState extends State<LivePlayerProgressBar> {
  @override
  void initState() {
    super.initState();
    widget.livePreviewPlayerController.videoPlayerController
        .addListener(updateWidgetListener);
  }

  @override
  void deactivate() {
    widget.livePreviewPlayerController.videoPlayerController
        .removeListener(updateWidgetListener);
    super.deactivate();
  }

  void updateWidgetListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget progressIndicator;
    if (widget.livePreviewPlayerController.videoPlayerController.value
        .isInitialized) {
      final int duration = widget.livePreviewPlayerController
          .videoPlayerController.value.duration.inMilliseconds;

      int maxBuffering = 0;
      for (DurationRange range in widget
          .livePreviewPlayerController.videoPlayerController.value.buffered) {
        final int end = range.end.inMilliseconds;
        if (end > maxBuffering) {
          maxBuffering = end;
        }
      }

      progressIndicator = ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            LivePreviewPlayerProgressIndicator(
              livePreviewPlayerController: widget.livePreviewPlayerController,
              progress: maxBuffering / duration,
              progressColor: Colors.green.withOpacity(0.6),
              backgroundColor: Colors.transparent,
            ),
            ValueListenableBuilder<Duration>(
              valueListenable:
                  widget.livePreviewPlayerController.videoProgressNotifier,
              builder: (context, progress, child) {
                return LivePreviewPlayerProgressIndicator(
                  livePreviewPlayerController:
                      widget.livePreviewPlayerController,
                  progress: progress.inMilliseconds / duration,
                  progressColor: Colors.white,
                  backgroundColor: Colors.transparent,
                );
              },
            ),
          ],
        ),
      );
    } else {
      progressIndicator = LinearProgressIndicator(
        value: null,
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.blue,
        ),
        backgroundColor: Colors.purple,
      );
    }
    final Widget paddedProgressIndicator = Padding(
      padding: const EdgeInsets.all(5),
      child: progressIndicator,
    );

    return CustomVideoPlayerSeeker(
      child: paddedProgressIndicator,
      livePreviewPlayerController: widget.livePreviewPlayerController,
    );
  }
}

class LivePreviewPlayerProgressIndicator extends StatefulWidget {
  final double progress;
  final LivePreviewPlayerController livePreviewPlayerController;
  final Color progressColor;
  final Color backgroundColor;

  const LivePreviewPlayerProgressIndicator({
    Key? key,
    required this.livePreviewPlayerController,
    required this.progressColor,
    required this.backgroundColor,
    required this.progress,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LivePreviewPlayerProgressIndicator> {
  Size mySize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return WidgetSize(
      onChange: (size) {
        setState(() {
          mySize = size;
        });
      },
      child: _getProgressBar(),
    );
  }

  Widget _getProgressBar() {
    return Container(
      width: double.infinity,
      height: 3,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          width: _getProgressValue(mySize.width, widget.progress),
          decoration: BoxDecoration(
            color: widget.progressColor,
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        ),
      ),
    );
  }

  double _getProgressValue(double maxValue, double? progress) {
    if (!(maxValue > 0) || progress == null || !(progress > 0)) {
      return 0;
    }
    return maxValue * progress;
  }
}

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  T? _ambiguate<T>(T? value) => value; // to support older flutter versions

  @override
  Widget build(BuildContext context) {
    _ambiguate(SchedulerBinding.instance)!
        .addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  GlobalKey widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(_) {
    BuildContext? context = widgetKey.currentContext;
    if (context == null) return;

    Size newSize = context.size!;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

class CustomVideoPlayerSeeker extends StatefulWidget {
  final Widget child;
  final LivePreviewPlayerController livePreviewPlayerController;
  const CustomVideoPlayerSeeker({
    Key? key,
    required this.child,
    required this.livePreviewPlayerController,
  }) : super(key: key);

  @override
  _CustomVideoPlayerSeekerState createState() =>
      _CustomVideoPlayerSeekerState();
}

class _CustomVideoPlayerSeekerState extends State<CustomVideoPlayerSeeker> {
  bool _videoPlaying = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.child,
      onHorizontalDragStart: (DragStartDetails details) {
        if (!widget.livePreviewPlayerController.videoPlayerController.value
            .isInitialized) {
          return;
        }
        _videoPlaying = widget
            .livePreviewPlayerController.videoPlayerController.value.isPlaying;
        if (_videoPlaying) {
          widget.livePreviewPlayerController.videoPlayerController.pause();
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!widget.livePreviewPlayerController.videoPlayerController.value
            .isInitialized) {
          return;
        }
        changeCurrentVideoPosition(details.globalPosition);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_videoPlaying) {
          widget.livePreviewPlayerController.videoPlayerController.play();
        }
      },
      onTapDown: (TapDownDetails details) {
        if (!widget.livePreviewPlayerController.videoPlayerController.value
            .isInitialized) {
          return;
        }
        changeCurrentVideoPosition(details.globalPosition);
      },
    );
  }

  void changeCurrentVideoPosition(Offset globalPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset tapPos = box.globalToLocal(globalPosition);
    final double relative = tapPos.dx / box.size.width;
    final Duration position = widget
            .livePreviewPlayerController.videoPlayerController.value.duration *
        relative;
    widget.livePreviewPlayerController.videoPlayerController.seekTo(position);
    widget.livePreviewPlayerController.videoProgressNotifier.value = position;
  }
}
