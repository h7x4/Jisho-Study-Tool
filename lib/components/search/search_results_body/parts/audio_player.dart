import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:unofficial_jisho_api/api.dart';

import '../../../../bloc/theme/theme_bloc.dart';

class AudioPlayer extends StatefulWidget {
  final AudioFile audio;

  const AudioPlayer({
    Key? key,
    required this.audio,
  }) : super(key: key);

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final ja.AudioPlayer player = ja.AudioPlayer();

  double _calculateRelativePlayerPosition(Duration? position) {
    if (position != null && player.duration != null)
      return position.inMilliseconds / player.duration!.inMilliseconds;
    return 0;
  }

  bool _isPlaying(ja.PlayerState? state) => state != null && state.playing;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final ColorSet colors = state.theme.menuGreyLight;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: colors.background,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => player.play().then((_) {
                  player.stop();
                  player.seek(Duration.zero);
                }),
                iconSize: 30,
                icon: StreamBuilder<ja.PlayerState>(
                  stream: player.playerStateStream,
                  builder: (_, snapshot) => Icon(
                    _isPlaying(snapshot.data) ? Icons.stop : Icons.play_arrow,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<Duration>(
                  stream: player.positionStream,
                  builder: (_, snapshot) => LinearProgressIndicator(
                    backgroundColor: colors.foreground,
                    value: _calculateRelativePlayerPosition(snapshot.data),
                  ),
                ),
              ),

              IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    player.setUrl(widget.audio.uri);
    super.initState();
  }
}
