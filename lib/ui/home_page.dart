import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ebook/ui/colorfile.dart' as colorfile;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? populerBooks; // Null güvenliği için nullable olarak tanımlandı.

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/populerbooks.json")
        .then((s) {
      setState(() {
        populerBooks = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorfile.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // Üst Menü
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageIcon(
                        AssetImage("assets/img/menu.png"),
                        size: 25,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 15),
                          Icon(Icons.notifications),
                        ],
                      )
                    ],
                  )),
              SizedBox(height: 20),
              // Başlık
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Populer Books",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              // Slider
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: populerBooks?.length ?? 0, // Null kontrolü
                          itemBuilder: (_, index) {
                            return Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: AssetImage(
                                      populerBooks![index]["img"]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
