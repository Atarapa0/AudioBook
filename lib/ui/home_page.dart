import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ebook/ui/colorfile.dart' as colorfile;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List? populerBooks;
  ScrollController scrollController = ScrollController();
  late TabController tabController;

  readData() async {
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
    readData();
    tabController =
        TabController(length: 3, vsync: this);
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorfile.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
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
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Populer Books",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                          itemCount: populerBooks?.length ?? 0,
                          itemBuilder: (_, index) {
                            return Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: AssetImage(
                                    populerBooks![index]["img"],
                                  ),
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
              ),
              Expanded(
                child: NestedScrollView(
                  controller: scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: colorfile.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(30),
                          child: Container(
                            padding: const EdgeInsets.only(bottom:20),
                            alignment: Alignment
                                .center,
                            child: TabBar(
                              indicatorColor: Colors.transparent,
                              indicatorPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              indicatorSize: TabBarIndicatorSize.label,
                              controller: tabController,
                              isScrollable:
                                  false,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                              ),
                              tabs: [
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      3.5,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorfile.menu1Color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withAlpha(51),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "New",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      3.5,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorfile.menu2Color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withAlpha(51),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "Popular",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      3.5, 
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorfile.menu3Color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withAlpha(51),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "Trending",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(controller: tabController, children: [
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                        title: Text("Context"),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                        title: Text("Contextee"),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                        title: Text("Contextaaa"),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
