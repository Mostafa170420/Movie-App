import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EndText extends StatelessWidget {
   EndText({required this.text,required this.textButton,required this.onPressed});
   Widget onPressed;
   String text;
   String textButton;
  @override
  Widget build(BuildContext context) {
    return  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey),
                ),
                SizedBox(
                  width: 1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => onPressed,
                        ),
                      );
                    },
                    child: Text(
                      textButton,
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Color(0xffe21221)),
                    )),
              ],
            );
  }
}