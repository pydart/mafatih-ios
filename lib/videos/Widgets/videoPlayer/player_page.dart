import 'package:flutter/material.dart';
import 'package:mafatih/videos/Widgets/videoPlayer/top_button_widgets.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import 'mytext.dart';


class PydartVideoPlayer extends StatefulWidget {
  const PydartVideoPlayer({
    Key? key,
    // required this.title,
    required this.url,
    this.waterMarkAssetsPath,
  }) : super(key: key);
  // final String title;
  final String url;
  final String? waterMarkAssetsPath;

  @override
  State<PydartVideoPlayer> createState() => _PydartVideoPlayerState();
}

class _PydartVideoPlayerState extends State<PydartVideoPlayer> {
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    player.open(Media(widget.url));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SizedBox(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.width * 9.0 / 16.0,
              // Use [Video] widget to display video output.

              child: MaterialVideoControlsTheme(
                normal: MaterialVideoControlsThemeData(
                  seekBarMargin:
                  const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                  bottomButtonBarMargin:
                  const EdgeInsets.only(bottom: 40, left: 20, right: 20),
                  brightnessGesture: true,
                  volumeGesture: true,
                  // topButtonBar:
                  // TopButtonBar().topButtonBar(widget.title, "", context),
                ),
                fullscreen: MaterialVideoControlsThemeData(
                  brightnessGesture: true,
                  volumeGesture: true,
                  seekBarMargin:
                  const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                  bottomButtonBarMargin:
                  const EdgeInsets.only(bottom: 40, left: 20, right: 20),
                  // topButtonBar:
                  // TopButtonBar().topButtonBar(widget.title, "", context),
                  // topButtonBar: TopButtonBar().topButtonBar,
                ),
                child: Video(
                  controller: controller,
                  wakelock: true,
                  subtitleViewConfiguration: SubtitleViewConfiguration(
                    textScaleFactor: 1.1,
                    style: faTextTheme(context),
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.all(24.0),
                  ),
                  pauseUponEnteringBackgroundMode: false,
                  resumeUponEnteringForegroundMode: true,
                  controls: (state) {
                    return Stack(
                      children: [
                        AdaptiveVideoControls(state),
                        // cont.showWaterMark

                        if (widget.waterMarkAssetsPath != null)
                          Positioned(
                            bottom: 80,
                            right: 20,
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Image.asset(
                                      widget.waterMarkAssetsPath!,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    const MyText(
                                      txt: 'اربعین تیوی',
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}