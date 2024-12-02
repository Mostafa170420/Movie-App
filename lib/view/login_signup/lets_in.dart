import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/view/login_signup/log_in.dart';
import 'package:movie1/view/login_signup/sign_up.dart';
import 'package:movie1/view/login_signup/widgets/button.dart';
import 'package:movie1/view/login_signup/widgets/dvider.dart';
import 'package:movie1/view/login_signup/widgets/end_text.dart';
import 'package:movie1/view/login_signup/widgets/lets_option.dart';

class LetsIn extends StatelessWidget {
  const LetsIn({super.key});

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
              duration: const Duration(milliseconds: 250),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                SizedBox(height: height / 5.5),
                Container(
                  alignment: Alignment.center,
                  height: height / 4.5,
                  child: Image.asset("assets/lets_dark.png"),
                ),
                SizedBox(
                  height: height / 35,
                ),
                Text(
                  "Let's you in",
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height / 35,
                ),
                LetsOption(icon: "assets/facebooklogo.png", title: "Facebook"),
                LetsOption(icon: "assets/googlelogo.png", title: "Google"),
                LetsOption(icon: "assets/icons8-apple-26.png", title: "Apple"),
                SizedBox(
                  height: height / 100,
                ),
                Dvider(content: "or"),
                SizedBox(
                  height: height / 50,
                ),
                InkWell(
                  child: Button(
                    title: "Sign in with password",
                    shadow: true,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LogIn(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: height / 30,
                ),
                EndText(
                  text: "Don't have an account?",
                  textButton: "Sign up",
                  onPressed: SignUp(),
                ),
              ],
            ),
          ),
        ));
  }
}
