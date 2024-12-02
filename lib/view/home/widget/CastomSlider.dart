import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/myListCubit.dart';
import 'package:movie1/data/my_list.dart';
import 'package:movie1/view/details/movieDetails.dart';
import 'package:shimmer/shimmer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'CustomRounded.dart';

class CastomSlider extends StatelessWidget {
  CastomSlider({super.key, required this.topRated});
  List topRated;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            autoPlay: true,
            height: size.width * 0.8,
            viewportFraction: 1,
            autoPlayAnimationDuration: const Duration(seconds: 2),
          ),
          itemCount: topRated.length,
          itemBuilder: (context, index, realIndex) => Container(
            child: Stack(children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: topRated[index].backdrop_path,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                  height: size.width,
                  width: MediaQuery.of(context).size.width,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(),
                  ),
                ),
              ),
              Positioned(
                bottom: 24,
                left: 16,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          topRated[index].title,
                          style: darkTheme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                        movieItem: topRated[index]),
                                  ));
                            },
                            child: const CustomIconButton(
                              icon: Icons.play_circle_rounded,
                              border: false,
                              text: 'Play',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.bottomSlide,
                                      title: 'Success',
                                      autoHide: const Duration(seconds: 2))
                                  .show();
                              MyListCubit.get(context)
                                  .addMovie(movie: topRated[index]);
                            },
                            child: const CustomIconButton(
                                border: true,
                                icon: Icons.add_rounded,
                                width: 100,
                                text: "My List"),
                          ),
                        ],
                      )
                    ]),
              ),
            ]),
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 25, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 37,
                      width: 37,
                      child: Image.asset("assets/logo.png")),
                  const Row(
                    children: [
                      Icon(
                        Iconsax.search_normal_1,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Iconsax.notification,
                        color: Colors.white,
                        size: 25,
                      ),
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }
}
//search-normal-1
//notification
