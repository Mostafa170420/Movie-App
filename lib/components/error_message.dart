import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorMessage extends StatelessWidget {
  ErrorMessage(
      {super.key,
      required this.message,
      required this.title,
      required this.color});
  String message;
  String title;
  Color color;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 1.3,
      height: height / 14,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500)),
            Text(message,
                style: GoogleFonts.urbanist(
                    color: Colors.grey[200],
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
