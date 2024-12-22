 import 'package:flutter/material.dart';

class AppTabs extends StatefulWidget {
  final Color color;
  final String text;
   const AppTabs({super.key, required this.color, required this.text});

   @override
   State<AppTabs> createState() => _AppTabsState();
 }

 class _AppTabsState extends State<AppTabs> {
   @override
   Widget build(BuildContext context) {
     return Container(
       width: MediaQuery.of(context).size.width /
           3.5,
       height: 50,
       alignment: Alignment.center,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         color: widget.color,
         boxShadow: [
           BoxShadow(
             color: Colors.grey.withAlpha(51),
             blurRadius: 7,
             offset: Offset(0, 0),
           ),
         ],
       ),
       child: Text(
         widget.text,
         style: TextStyle(color: Colors.white,fontSize: 15 ),
       ),
     );
   }
 }
