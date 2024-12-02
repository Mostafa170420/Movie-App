import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/movie_cubit.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/view/home/widget/CastomSlider.dart';
import 'package:movie1/view/home/widget/movie_list.dart';


class home extends StatelessWidget {
  home({super.key});
  MoviesCubit moviesCubit = MoviesCubit()..getData();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => moviesCubit,
        child: Scaffold(
          backgroundColor: darkTheme.scaffoldBackgroundColor,
          body: BlocBuilder<MoviesCubit, MoviesStates>(
            builder: (context, state) {
              if (state is MoviesLoadingStates) {
                return Center(
                    child: Image.asset(
                  "assets/Loading.gif",
                  fit: BoxFit.cover,
                ));
              } else if (state is MoviesSuccessStates) {
                return homeWidget(state.category, moviesCubit);
              } else {
                return Text(
                  "Failed",
                  style: darkTheme.textTheme.bodySmall,
                );
              }
            },
          ),
        ));
  }
}

Widget homeWidget(
        Map<String, List<MovieItem>> categorys, MoviesCubit moviesCubit) =>
    SingleChildScrollView(
        child: Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 400),
        childAnimationBuilder: (widget) => SlideAnimation(
          verticalOffset: 100,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: [
          CastomSlider(
            topRated: categorys["TopRated"]!,
          ),
          MovieList(
            title: "Most Popular",
            category: categorys["Popular"]!,
            mapKey: "Popular",
          ),
          MovieList(
            title: "Now Playing",
            category: categorys["Upcoming"]!,
            mapKey: "Upcoming",
          ),
          MovieList(
            title: "New Releases",
            category: categorys["Now"]!,
            mapKey: "Now",
          ),
          const SizedBox(height: 10),
        ],
      ),
    ));
