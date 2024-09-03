import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie1/Image_Container.dart';
import 'package:movie1/Theme/colors.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/movie_cubit.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/data/my_list.dart';
import 'package:movie1/details/movieDetails.dart';
import 'package:movie1/see_all.dart';
import 'package:shimmer/shimmer.dart';

class MovieList extends StatelessWidget {
  const MovieList(
      {super.key,
      required this.title,
      required this.category,
      required this.mapKey});
  final String title;
  final List<MovieItem> category;
  final String mapKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,
                  style: darkTheme.textTheme.displaySmall?.copyWith(shadows: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ])),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SeeAll(category: mapKey, title: title),
                      ));
                },
                child: Text(
                  "See all",
                  style: darkTheme.textTheme.bodyLarge
                      ?.copyWith(color: ColorPalette.darkPrimary, shadows: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(),
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                    onLongPress: () {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.scale,
                              btnOkText: "Save",
                              body: saveWidget(category[index].imagePath),
                              btnOkOnPress: () {
                                MyListMovies.addMovie(category[index]);
                              },
                              dialogBackgroundColor: Colors.transparent,
                              btnCancelOnPress: () {},
                              headerAnimationLoop: false)
                          .show();
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetails(movieItem: category[index]),
                          ));
                    },
                    child: Image_Container(
                      imageUrl: category[index].imagePath,
                      rate: category[index].rate,
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    width: 10.0,
                  ),
              itemCount: category.length),
        ),
      ],
    );
  }
}

Widget saveWidget(String imageUrl) => Container(
      width: 200,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: ColorPalette.shadow.withOpacity(0.3))],
        borderRadius: BorderRadius.circular(25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 200,
          fit: BoxFit.fill,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(),
          ),
        ),
      ),
    );
