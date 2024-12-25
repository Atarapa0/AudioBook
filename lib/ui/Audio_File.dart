import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const AudioFile({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  late AudioPlayer audioPlayer;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  String? audioFileName;
  final String audioPath = "audio/";

  @override
  void initState() {
    super.initState();
    audioPlayer = widget.audioPlayer;

    // Süre ve konum dinleyicileri
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });
  }

  void playAudio(String fileName) async {
    try {
      String fullPath = audioPath + fileName;
      await audioPlayer.setSourceAsset(fullPath);
      await audioPlayer.resume();
      setState(() {
        audioFileName = fileName;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }
  Widget btnStart(String fileName) {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: Icon(
          audioPlayer.state == PlayerState.playing ? Icons.pause_circle_filled : Icons.play_circle_filled,
        size: 40,
        color: Colors.blue,
      ),
      onPressed: () async {
        if (audioPlayer.state == PlayerState.playing) {
          await audioPlayer.pause();
        } else {
          playAudio(fileName);
        }
      },
    );
  }
  Widget slider(){
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value){
        setState(() {
          audioPlayer.seek(Duration(seconds: value.toInt()));
          value=value;
        });
      },
    );
  }
  void changeToSeconds(int seconds){
    Duration newDuration = Duration(seconds: seconds);
    audioPlayer.seek(newDuration);
  }

  Widget loadAssets(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        btnStart('alice-chapter1.mp3'),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _position.toString().split('.').first,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                _duration.toString().split('.').first,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          )
        ),
        slider(),
        loadAssets(),
      ],
    );
  }
}
