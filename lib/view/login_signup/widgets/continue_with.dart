import 'package:flutter/material.dart';

class ContinueWith extends StatelessWidget {
   ContinueWith({required this.name});
  String name;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
          height: height/17,
          width: width/5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFF1F222A),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white10,width: 1)
          ),
          child: Image.asset(name,height: 20,width: 20,),
        );
  }
}