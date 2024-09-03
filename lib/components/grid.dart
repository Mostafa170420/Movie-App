import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie1/Image_Container.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/movie_cubit.dart';
import 'package:movie1/cubit/myListCubit.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/data/my_list.dart';
import 'package:movie1/details/movieDetails.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Container buildMovieGrid(List category, int i) {
  return Container(
    margin: const EdgeInsets.only(top: 16),
    child: AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 155,
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
        ),
        itemBuilder: (context, index) {
          if (index == category.length) {
            return Center(
                child:
                    CircularProgressIndicator(color: darkTheme.primaryColor));
          } else {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: i == 0
                        ? myListItem(category, index, context, i)
                        : categoryItem(category, index, context),
                  )),
            );
          }
        },
        itemCount: category.length + i,
      ),
    ),
  );
}

Widget myListItem(List category, int index, context, int i) => SizedBox(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onLongPress: () => AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: 'Delete',
            btnOkOnPress: () {
              MyListMovies.removeMovie(index);
              MyListCubit.get(context).data();
            },
            btnCancelOnPress: () {},
            headerAnimationLoop: false,
            titleTextStyle: darkTheme.textTheme.displaySmall,
            dialogBackgroundColor: const Color.fromRGBO(52, 43, 45, 20))
          ..show(),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetails(movieItem: category[index]),
              ));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: category[index].imagePath,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.15,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
Widget categoryItem(
  List category,
  int index,
  context,
) =>
    InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(movieItem: category[index]),
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: category[index].imagePath,
          height: MediaQuery.of(context).size.height * 0.38,
          width: MediaQuery.of(context).size.width * 0.15,
          fit: BoxFit.cover,
        ),
      ),
    );
