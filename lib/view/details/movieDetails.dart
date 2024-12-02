import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie1/Theme/colors.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/cast_cubit.dart';
import 'package:movie1/cubit/cast_states.dart';
import 'package:movie1/data/cast.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/view/cast_details/cast_home.dart';
import 'package:movie1/view/details/icons.dart';
import 'package:movie1/view/details/recommend.dart';
import 'package:movie1/view/details/video.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie1/components/fade.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({super.key, required this.movieItem});
  MovieItem movieItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CastCubit()..getData(movieItem),
      child: Scaffold(
          backgroundColor: darkTheme.scaffoldBackgroundColor,
          body: Stack(
            children: [
              Opacity(
                opacity: 0.4,
                child: CachedNetworkImage(
                  imageUrl: movieItem.imagePath,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  height: 320.0,
                  width: double.infinity,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 244),
                child: GradientColor(
                  height: 107,
                ),
              ),
              DelayedWidget(
                animationDuration: const Duration(milliseconds: 800),
                animation: DelayedAnimations.SLIDE_FROM_TOP,
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 75,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 250,
                                width: 180,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color:
                                          ColorPalette.shadow.withOpacity(0.3))
                                ], borderRadius: BorderRadius.circular(25)),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    child: CachedNetworkImage(
                                        imageUrl: movieItem.imagePath)),
                              ),
                              InkWell(
                                onTap: () {
                                  if (movieItem.youtubeKey.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieVideo(
                                                  videoId: movieItem.youtubeKey,
                                                )));
                                  }
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 80, 40, 0),
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      color: darkTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border(
                                          bottom: BorderSide(
                                        color: darkTheme.primaryColor,
                                      )),
                                      boxShadow: [
                                        BoxShadow(
                                          color: darkTheme.primaryColor
                                              .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                        ),
                                      ]),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SecondScrean(
                          title: movieItem.title,
                          description: movieItem.description,
                          rate: movieItem.rate,
                          date: movieItem.date,
                          adult: movieItem.adult,
                          original_language: movieItem.original_language,
                        ),
                        BlocBuilder<CastCubit, CastStates>(
                          builder: (context, state) {
                            if (state is CastLoadingStates) {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(top: 40),
                                child: CircularProgressIndicator(
                                  color: darkTheme.primaryColor,
                                ),
                              );
                            } else if (state is CastSuccessStates) {
                              return castt(state.casts, context);
                            } else {
                              return Container();
                            }
                          },
                        ),
                        BlocBuilder<CastCubit, CastStates>(
                          builder: (context, state) {
                            if (state is CastLoadingStates) {
                              return Container();
                            } else if (state is CastSuccessStates) {
                              return DelayedWidget(
                                delayDuration:
                                    const Duration(milliseconds: 300),
                                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                                child:
                                    RecommendWidget(recommend: state.recommend),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

Widget castt(List<Cast> castItems, context) => SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: castItems.length,
          itemBuilder: (context, index) => Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CastHome(cast: castItems[index])));
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(castItems[index].profilePath),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: SizedBox(
                            width: 65,
                            child: Text(
                              castItems[index].name,
                              style: darkTheme.textTheme.bodySmall,
                            )),
                      )
                    ],
                  ),
                ],
              )),
    );
