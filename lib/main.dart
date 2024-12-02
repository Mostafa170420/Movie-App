import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie1/cubit/auth_cubit.dart';
import 'package:movie1/cubit/movie_cubit.dart';
import 'package:movie1/cubit/myListCubit.dart';
import 'package:movie1/firebase_options.dart';
import 'package:movie1/view/login_signup/entry.dart';
import 'package:movie1/cubit/password_cubit.dart';
import 'view/home/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyWidget(), // Wrap your app
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesCubit(),
        ),
        BlocProvider(
          create: (context) => MyListCubit(),
        ),
        BlocProvider(
          create: (context) => PasswordCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser == null
            ? const EntryScrean()
            : Home(),
        routes: {
          "entry": (BuildContext context) => const EntryScrean(),
          "home": (BuildContext context) => Home(),
        },
      ),
    );
  }
}
