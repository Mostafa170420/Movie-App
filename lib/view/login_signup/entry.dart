import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/view/login_signup/lets_in.dart';
import 'package:movie1/view/login_signup/widgets/button.dart';

class EntryScrean extends StatelessWidget {
  const EntryScrean({super.key});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darkTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Image.asset(
            "assets/welcomeimage.png",
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "Welcome to Mova",
                    style: GoogleFonts.urbanist(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "The best movie streaming app of the century \nto make your days great!",
                    style: GoogleFonts.urbanist(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DelayedWidget(
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    animationDuration: const Duration(seconds: 1),
                    child: InkWell(
                      child: Button(
                        title: "Get Started",
                        shadow: true,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LetsIn(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
