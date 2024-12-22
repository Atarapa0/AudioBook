import 'dart:convert';
import 'package:ebook/ui/tabs.dart';
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
  List? books;
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
  readBooks() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
    readBooks();
    tabController = TabController(length: 3, vsync: this);
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
                            padding: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            child: TabBar(
                              indicatorColor:
                                  Colors.transparent, // Zaten eklemişsiniz
                              dividerColor: Colors
                                  .transparent, // Çizgiyi kaldırmak için bunu ekleyin
                              indicatorPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              indicatorSize: TabBarIndicatorSize.label,
                              controller: tabController,
                              isScrollable: false,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent,
                              ),
                              tabs: [
                                AppTabs(
                                  color: colorfile.menu1Color,
                                  text: "New",
                                ),
                                AppTabs(
                                    color: colorfile.menu2Color,
                                    text: "Populer"),
                                AppTabs(
                                  color: colorfile.menu3Color,
                                  text: "Trend",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(controller: tabController, children: [
                    ListView.builder(
                      itemCount: books?.length ?? 0,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 10,
                            top: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorfile.tabVarViewColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withAlpha(51),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(books?[index]["img"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: colorfile.starColor, size: 24,),
                                          SizedBox(width: 5),
                                          Text(books?[index]["rating"],style: TextStyle(
                                            color: colorfile.menu2Color,
                                          ),),
                                        ],
                                      ),
                                      Text(books?[index]["title"],style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Text(books?[index]["text"],style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Avenir",
                                        color: colorfile.subTitleText,
                                      ),),
                                      Container(
                                        width: 50,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: colorfile.loveColor,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Love",style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Avenir",
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),


                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: (books?.length ?? 0),
                      itemBuilder: (_, index) {
                        int reverseIndex = (books!.length - 1) - index;
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 10,
                            top: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorfile.tabVarViewColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withAlpha(51),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(books?[reverseIndex]["img"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: colorfile.starColor, size: 24,),
                                          SizedBox(width: 5),
                                          Text(books?[reverseIndex]["rating"],style: TextStyle(
                                            color: colorfile.menu2Color,
                                          ),),
                                        ],
                                      ),
                                      Text(books?[reverseIndex]["title"],style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Text(books?[reverseIndex]["text"],style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Avenir",
                                        color: colorfile.subTitleText,
                                      ),),
                                      Container(
                                        width: 50,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: colorfile.loveColor,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Love",style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Avenir",
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),


                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: (books?.length ?? 0),
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 10,
                            top: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorfile.tabVarViewColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withAlpha(51),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(books?[index]["img"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: colorfile.starColor, size: 24,),
                                          SizedBox(width: 5),
                                          Text(books?[index]["rating"],style: TextStyle(
                                            color: colorfile.menu2Color,
                                          ),),
                                        ],
                                      ),
                                      Text(books?[index]["title"],style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Text(books?[index]["text"],style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Avenir",
                                        color: colorfile.subTitleText,
                                      ),),
                                      Container(
                                        width: 50,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: colorfile.loveColor,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Love",style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Avenir",
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),


                          ),
                        );
                      },
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
