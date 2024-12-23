import 'package:flutter/material.dart';
import 'package:ebook/ui/colorfile.dart' as colorfile;

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    final double sceenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorfile.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: sceenHeight / 3,
              child: Container(
                color: colorfile.audioBlueBackground,
              )),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new)),
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.search))
                ],
                backgroundColor: Colors.transparent,
                elevation: 0,
          )),
          Positioned(
            left: 0,
            right: 0,
            top: sceenHeight *0.20,
            height: sceenHeight *0.35,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Column(
                children: [
                  Text("Books name")
                ],
              ),

            ),),
        ],
      ),
    );
  }
}
