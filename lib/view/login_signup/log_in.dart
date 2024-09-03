import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/password_cubit.dart';
import 'package:movie1/cubit/Password_states.dart';
import 'package:movie1/error_message.dart';
import 'package:movie1/login_signup/widgets/button.dart';
import 'package:movie1/login_signup/widgets/continue_with.dart';
import 'package:movie1/login_signup/widgets/dvider.dart';
import 'package:movie1/login_signup/widgets/end_text.dart';
import 'package:movie1/login_signup/sign_up.dart';
import 'package:movie1/login_signup/widgets/text_form.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    PasswordCubit passwordCubit = PasswordCubit();
    return BlocProvider(
        create: (context) => passwordCubit,
        child: Scaffold(
          backgroundColor: darkTheme.scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 200),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  SizedBox(height: height / 7),
                  Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/logo.png",
                        height: height / 5.5,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: height / 40,
                  ),
                  Text(
                    "Login to Your Account",
                    style: GoogleFonts.urbanist(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  TextForm(
                    hint: "Email",
                    prefix: Icons.email_rounded,
                    controller: email,
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  BlocBuilder<PasswordCubit, PasswordStates>(
                      builder: (context, state) {
                    return TextForm(
                      hint: "Password",
                      prefix: Icons.lock_rounded,
                      suffix: passwordCubit.visible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      controller: password,
                      obscureText: passwordCubit.isPassword,
                      onPressed: () {
                        passwordCubit.changeState();
                      },
                    );
                  }),
                  SizedBox(
                    height: height / 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        side: const BorderSide(
                            color: Color(0xffe21221), width: 2),
                      ),
                      Text("Remember me",
                          style: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  InkWell(
                    child: Button(title: "Sign in"),
                    onTap: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: ErrorMessage(
                            message: "Login Successfully",
                            title: "Well done!",
                            color: const Color(0xff0C7040),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ));
                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.pushReplacementNamed(context, "home");
                      } on FirebaseAuthException catch (e) {
                        print(e.code);
                        if (e.code == 'invalid-credential') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: ErrorMessage(
                              message: "Invalid Username or Password",
                              title: "Oh snap!",
                              color: const Color(0xffBA1421),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: ErrorMessage(
                              message: "Invalid email format",
                              title: "Oh snap!",
                              color: const Color(0xffBA1421),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ));
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot the password?",
                      style: GoogleFonts.urbanist(
                        color: const Color(0xffE21221),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 115,
                  ),
                  Dvider(content: "or continue with"),
                  SizedBox(
                    height: height / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContinueWith(
                        name: "assets/facebooklogo.png",
                      ),
                      SizedBox(
                        width: width / 24,
                      ),
                      ContinueWith(
                        name: "assets/googlelogo.png",
                      ),
                      SizedBox(
                        width: width / 24,
                      ),
                      ContinueWith(
                        name: "assets/icons8-apple-26.png",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                  EndText(
                    text: "Don't have an account?",
                    textButton: "Sign up",
                    onPressed: SignUp(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
