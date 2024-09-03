import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie1/Theme/dark_theme.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: darkTheme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 170),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                SizedBox(height: height / 9),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF1F222A),
                    radius: width / 6,
                    child: Icon(
                      Icons.person,
                      size: width / 5,
                      color: darkTheme.primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email!,
                  style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: height / 40,
                ),
                InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, "entry");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width / 30),
                      height: height / 14.5,
                      width: width / 1.2,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F222A),
                        border: Border.all(color: Colors.white12),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/sign-out .png",
                            width: width / 10,
                          ),
                          SizedBox(
                            width: width / 20,
                          ),
                          Text("LogOut",
                              style: GoogleFonts.urbanist(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          const Spacer(),
                          Icon(
                            Iconsax.arrow_right_3,
                            color: Colors.white,
                            size: width / 15,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
//const LetsOption(icon: "assets/sign-out .png", title: "LogOut")),