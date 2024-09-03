import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/movie_cubit.dart';
import 'package:movie1/grid.dart';

class SeeAll extends StatelessWidget {
  SeeAll({super.key, required this.category, required this.title});
  String category;
  String title;

  @override
  Widget build(BuildContext context) {
    MoviesCubit.get(context).getCategory(category);
    return Scaffold(
      backgroundColor: darkTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkTheme.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(53, 52, 75, 50),
                borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Iconsax.arrow_left_2,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        title: Text(
          title,
          style: darkTheme.textTheme.displaySmall,
        ),
      ),
      body: BlocBuilder<MoviesCubit, MoviesStates>(
        buildWhen: (previous, current) =>
            current is! MoviesLoadingFromPaginnationStates &&
            current is! MoviesFailedFromPaginnationStates,
        builder: (context, state) {
          if (state is MoviesLoadingStates) {
            return Center(
                child: Center(
              child: CircularProgressIndicator(color: darkTheme.primaryColor),
            ));
          } else if (state is MoviesSuccessFromPaginnationStates) {
            return grid(state.category, category, context);
          } else if (state is MoviesFailedStates)
            return Center(
                child: Text(
              state.msg,
              style: const TextStyle(color: Colors.white),
            ));
          else
            return Container();
        },
      ),
    );
  }
}

Widget grid(List category, String name, context) =>
    NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent &&
              notification is ScrollUpdateNotification) {
            MoviesCubit.get(context).getCategory(name, loading: true);
          }
          return true;
        },
        child: buildMovieGrid(category, 1));
