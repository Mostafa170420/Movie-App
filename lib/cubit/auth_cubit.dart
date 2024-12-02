import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie1/components/error_message.dart';
import 'package:movie1/cubit/auth_states.dart';
import 'package:movie1/remote/firestore_helper.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());
  static AuthCubit get(context) => BlocProvider.of(context);
  void signIn(
      {required String email,
      required String password,
      required context}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ErrorMessage(
        context: context,
        message: "Log in Successfully",
        title: "Well done!",
        color: const Color(0xff0C7040),
      );
      Navigator.pushNamed(context, "home");
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        ErrorMessage(
          context: context,
          message: "Invalid Username or Password",
          title: "Oh snap!",
          color: const Color(0xffBA1421),
        );
        emit(FailedState(errorMsg: "Invalid Username or Password"));
      } else {
        ErrorMessage(
          context: context,
          message: "Invalid email format",
          title: "Oh snap!",
          color: const Color(0xffBA1421),
        );
        emit(FailedState(errorMsg: "Invalid email format"));
      }
    }
  }

  void signUp(
      {required String email,
      required String password,
      required context}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirestoreHelper()
          .addUser("user", FirebaseAuth.instance.currentUser!.uid, {});
      ErrorMessage(
        context: context,
        message: "Sign up Successfully",
        title: "Well done!",
        color: const Color(0xff0C7040),
      );
      Navigator.pushNamed(context, "home");
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ErrorMessage(
          context: context,
          message: "The password provided is too weak",
          title: "Oh snap!",
          color: const Color(0xffBA1421),
        );
        emit(FailedState(errorMsg: "The password provided is too weak"));
      } else if (e.code == 'email-already-in-use') {
        ErrorMessage(
          context: context,
          message: "Account already exists for that email",
          title: "Oh snap!",
          color: const Color(0xffBA1421),
        );
        emit(FailedState(errorMsg: "Account already exists for that email"));
      } else if (e.code == "invalid-email") {
        ErrorMessage(
          context: context,
          message: "Invalid email format",
          title: "Oh snap!",
          color: const Color(0xffBA1421),
        );
        emit(FailedState(errorMsg: "Invalid email format"));
      }
    } catch (e) {
      print(e);
    }
  }

  void signInWithGoogle() async {
    print("ffff");
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("asdasd");
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("asdasd");

      if (authResult.additionalUserInfo!.isNewUser) {
        await FirestoreHelper()
            .addUser("user", FirebaseAuth.instance.currentUser!.uid, {});
      }
      print(FirebaseAuth.instance.currentUser!.email);
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
