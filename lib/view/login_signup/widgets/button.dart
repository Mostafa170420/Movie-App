import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
   Button({required this.title,this.shadow=false});
   String title;
   bool shadow;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
                      height: 47,
                      width: width / 1.1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow:shadow? const [
                          BoxShadow(
                            color: Color(0xffE21221),
                            blurRadius: 24,
                            offset: Offset(4, 8),
                          ),
                        ]:null,
                        color: Color(0xffE21221),
                      ),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    );
  }
}