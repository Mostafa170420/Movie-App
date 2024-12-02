import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieVideo extends StatelessWidget {
  const MovieVideo({super.key, required this.videoId});
  final String videoId;
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: YoutubePlayer(
            controller: controller,
            onEnded: (metaData) => Navigator.pop(context),
            showVideoProgressIndicator: true,
          ),
        ),
      ]),
    );
  }
}
