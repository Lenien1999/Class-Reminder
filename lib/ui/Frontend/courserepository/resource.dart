// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/material.dart';


class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Container(
  decoration:const BoxDecoration(
                color:Color(0xFF202328),
               borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              ),
        child: ListView.separated(
          separatorBuilder: (context, child) => Divider(
            height: 1,
          ),
          padding: EdgeInsets.all(0.0),
          itemCount: 10,
          itemBuilder: (context, i) {
            return Container(
              margin:EdgeInsets.symmetric(horizontal: 30,vertical: 20  ),
              height: 100,
              width: double.infinity,
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(12),
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
           
            child:   Padding(
              padding: EdgeInsets.all(13.0),
              child: ListTile(
                
                title: Row(
                  children:const [
                   Image(image: AssetImage("assets/images/learning3.png"  ), width:50, height:40 ) ,
                    SizedBox(width:30),
                    Text("CSE409",style:TextStyle(fontSize:16,
                    fontWeight:FontWeight.w500,color:Colors.black )),
                  ],
                ),
                subtitle: Container(
                  margin:const EdgeInsets.symmetric(horizontal: 84),
                  child: Text("Lecture 3",style:TextStyle(fontSize:18,
                  fontWeight:FontWeight.w500,color:Colors.white )),
                ),
                trailing:Icon(Icons.file_download_rounded,color:Colors.white ,),
              ),
            ));
          },
        ),
      ),
    );
  }
}
