import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livepreview/livePreviewPlayer/listViewVideoManager/listViewVideoPlayer.dart';
import 'package:livepreview/models/data.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../livePreviewPlayer/listViewVideoManager/listViewVideoManager.dart';
import '../widgets/frostedGlassIcon.dart';
import '../widgets/videoMiniPlayer.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late ScrollController _scrollController;
  List items = data['items'];

  late ListViewVideoManager listViewVideoManager;

  @override
  void initState() {
    super.initState();
    listViewVideoManager = ListViewVideoManager();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return VisibilityDetector(
      key: ObjectKey(listViewVideoManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          listViewVideoManager.pause();
        }
      },
      child: Container(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 60,
          ),
          itemCount: data["items"].length,
          // controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
                // height: 400,
                margin: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Column(
                    children: [
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
                              child: Text(
                                items[index]['title'],
                                style: Theme.of(context).textTheme.subtitle1,
                              )),
                        ),
                      ),
                      ListViewVideoPlayer(
                        url: items[index]['videoUrl'],
                        // url:
                        //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                        listViewVideoManager: listViewVideoManager,
                        image: items[index]['coverPicture'],
                        // image: "https://picsum.photos/200/200",
                      ),
                    ],
                  ),
                ));
            ;
          },
        ),
      ),
    );
  }
}
