import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff0E101D),
      body: Column(
        children: [
          SizedBox(height: height / 3.5),
          Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/logo.png",
                height: height / 5.5,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: height / 4,
          ),
          Image.asset("assets/loading.gif")
        ],
      ),
    );
  }
}
