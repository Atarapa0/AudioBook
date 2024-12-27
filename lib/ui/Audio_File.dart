import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final Map<String, dynamic> bookData;

  const AudioFile({
    Key? key,
    required this.audioPlayer,
    required this.bookData,
  }) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  bool isRepeated = false;
  double playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    widget.audioPlayer.onDurationChanged.listen((Duration d) {
      if (mounted) {
        setState(() => _duration = d);
      }
    });

    widget.audioPlayer.onPositionChanged.listen((Duration p) {
      if (mounted) {
        setState(() => _position = p);
      }
    });

    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      await widget.audioPlayer.setSourceAsset(widget.bookData["audio"]);
    } catch (e) {
      print("Error loading audio file: $e");
    }
  }

  void _togglePlay() async {
    if (isPlaying) {
      await widget.audioPlayer.pause();
    } else {
      await widget.audioPlayer.resume();
    }
  }

  void _toggleRepeat() {
    setState(() {
      isRepeated = !isRepeated;
      widget.audioPlayer.setReleaseMode(
          isRepeated ? ReleaseMode.loop : ReleaseMode.release
      );
    });
  }

  void _changeSpeed() {
    setState(() {
      if (playbackSpeed == 1.0) playbackSpeed = 1.5;
      else if (playbackSpeed == 1.5) playbackSpeed = 2.0;
      else if (playbackSpeed == 2.0) playbackSpeed = 0.5;
      else playbackSpeed = 1.0;

      widget.audioPlayer.setPlaybackRate(playbackSpeed);
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_position)),
              Text(_formatDuration(_duration)),
            ],
          ),
        ),

        Slider(
          value: _position.inSeconds.toDouble(),
          min: 0,
          max: _duration.inSeconds.toDouble(),
          onChanged: (value) async {
            await widget.audioPlayer.seek(Duration(seconds: value.toInt()));
          },
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Text("${playbackSpeed}x"),
              onPressed: _changeSpeed,
            ),

            IconButton(
              icon: Icon(Icons.replay_10),
              onPressed: () async {
                await widget.audioPlayer.seek(
                    Duration(seconds: _position.inSeconds - 10)
                );
              },
            ),

            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                size: 40,
              ),
              onPressed: _togglePlay,
            ),

            IconButton(
              icon: Icon(Icons.forward_10),
              onPressed: () async {
                await widget.audioPlayer.seek(
                    Duration(seconds: _position.inSeconds + 10)
                );
              },
            ),

            IconButton(
              icon: Icon(
                isRepeated ? Icons.repeat_one : Icons.repeat,
                color: isRepeated ? Colors.blue : null,
              ),
              onPressed: _toggleRepeat,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}