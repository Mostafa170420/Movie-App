import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/bottomNavigationBar_cubit.dart';
import 'package:movie1/cubit/movie_cubit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie1/view/home/myList_screan.dart';
import 'package:movie1/view/home/profile.dart';
import 'widget/home.dart';


class Home extends StatelessWidget {
  Home({super.key});
  List<Widget>screan=[
    home(),
    const myList(),
    const Profile()
  ];
  BottomNavBarCubit cubit=BottomNavBarCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>cubit,
      child: Scaffold(
          backgroundColor: darkTheme.scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: BlocBuilder<BottomNavBarCubit,int>(
              builder: (context, state) {
                return screan[state];
              },
            ),
          ),
          bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: GNav(
                onTabChange: (value) {
                 cubit.changeScrean(value);
                },
                  haptic: true,
                  tabBorderRadius: 10,
                  tabMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 200),
                  gap: 8,
                  color: darkTheme.colorScheme.onSurface,
                  activeColor: darkTheme.primaryColor,
                  iconSize: 24,
                  tabBackgroundColor: darkTheme.colorScheme.onPrimary,
                  padding: const EdgeInsets.all(10),
                  tabs: const [
                    GButton(
                      icon: Iconsax.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Iconsax.save_2,
                      text: 'My List',
                    ),
                    GButton(
                      icon: Iconsax.user,
                      text: 'Profile',
                    )
                  ]),
            ),
          )),
    );
  }
}
