import 'package:audioplayers/audioplayers.dart';
import 'package:ebook/ui/Audio_File.dart';
import 'package:flutter/material.dart';
import 'package:ebook/ui/colorfile.dart' as colorfile;

class AudioPage extends StatefulWidget {
  final Map<String, dynamic> bookData;

  const AudioPage({
    super.key,
    required this.bookData,
  });

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorfile.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              color: colorfile.audioBlueBackground,
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    audioPlayer.stop();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new)
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search)
                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.20,
            height: screenHeight * 0.45,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Text(
                    widget.bookData["title"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Avenir',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.bookData["text"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: colorfile.subTitleText,
                      fontFamily: 'Avenir',
                    ),
                  ),
                  SizedBox(height: 20),
                  AudioFile(
                    audioPlayer: audioPlayer,
                    bookData: widget.bookData,
                  ),
                ],
              ),
            ),
          ),


          Positioned(
            left: screenWidth / 2 - 75,
            right: screenWidth / 2 - 75,
            top: screenHeight * 0.12,
            height: screenHeight * 0.18,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
                color: colorfile.audioGreyBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                        image: AssetImage(widget.bookData["img"]),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}