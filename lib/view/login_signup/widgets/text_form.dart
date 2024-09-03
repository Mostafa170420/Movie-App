import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForm extends StatelessWidget {
   TextForm(
      {super.key,
      required this.hint,
      required this.prefix,
      this.suffix,
      this.obscureText,
      this.onPressed,
      required this.controller});
  final String hint;
  final IconData prefix;
  final IconData? suffix;
  final bool? obscureText;
  final void Function()? onPressed;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 15,
      width: width / 1.1,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        mouseCursor: SystemMouseCursors.alias,
        cursorOpacityAnimates: true,
        obscureText: obscureText??false,
        cursorColor: Colors.white,
        style: GoogleFonts.urbanist(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.urbanist(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
          prefixIcon: Icon(
            prefix,
            color: Colors.white,
            size: 22,
          ),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(
            suffix,
            color: Colors.white,
            size: 22,
          ),),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
