import 'package:flutter/material.dart';
import 'package:ebook/ui/colorfile.dart' as colorfile;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                child:
                Row(
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
                        SizedBox(width: 15,),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                )
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text("Populer Books", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 180,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: 5,
                    itemBuilder: (_, index){
                  return Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage("assets/img/slider-1.png")),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
3
4
5
6
7
8
9



# Git add ile eklemiş olduğunuz değişikliği eklemeye yarar.
# NOT eğer commit mesajını da değiştirmek istiyorsanız --no-edit kısmını kaldırmalısınız.
$ git commit --all --amend --no-edit

# HEAD'i eski pozisyonuna geri taşır
$ git rebase --continue