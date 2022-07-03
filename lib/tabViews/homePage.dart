import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../livePreviewPlayer/listViewVideoManager/listViewVideoPlayer.dart';
import '../models/data.dart';
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
            return (index == 0)
                ? Container(
                    margin: EdgeInsets.only(top: 50, left: 20, bottom: 50),
                    child: Text(
                      'Live Preview',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  )
                : Container(
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
                                    // color: Theme.of(context)
                                    //     .backgroundColor
                                    //     .withOpacity(0.2),
                                    gradient: LinearGradient(
                                      colors: [
                                        (themeProvider.isDarkMode)
                                            ? Colors.greenAccent
                                                .withOpacity(0.3)
                                            : Colors.lightBlueAccent.shade100
                                                .withOpacity(0.2),
                                        Colors.white,
                                      ],
                                    ),
                                  ),
                                  height: 80,
                                  width: double.infinity,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index]['title'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Sonali Ma'am | ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                            Text(
                                              '2 days ago',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .overline,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Mathematics | Pre-School Algebra, Mensuration, Mental Maths',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          ListViewVideoPlayer(
                            // url: items[index]['videoUrl'],
                            url:
                                "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                            listViewVideoManager: listViewVideoManager,
                            // image: items[index]['coverPicture'],
                            image: "https://picsum.photos/200/200",
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
