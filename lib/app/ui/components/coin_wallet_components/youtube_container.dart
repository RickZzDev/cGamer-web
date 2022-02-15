import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

class YoutubeContainer extends StatelessWidget {
  final String videoId;
  const YoutubeContainer({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24, left: 24),
      height: 200,
      child: FlutterYoutubeView(
          scaleMode: YoutubeScaleMode.fitHeight, // <option> fitWidth, fitHeight
          params: YoutubeParam(
            videoId: videoId,
            showUI: true,
            startSeconds: 0.0, // <option>
            autoPlay: false,
          ) // <option>
          ),
    );
  }
}
