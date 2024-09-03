import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/details/movieDetails.dart';
import 'package:movie1/rating.dart';
import 'package:shimmer/shimmer.dart';

class RecommendWidget extends StatelessWidget {
  RecommendWidget({super.key, required this.recommend});
  List<MovieItem> recommend;
  @override
  Widget build(BuildContext context) {
    return recom(recommend, context);
  }
}

Widget recom(List movies, context) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended",
                style: darkTheme.textTheme.displaySmall?.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetails(movieItem: movies[index]),
                  )),
              child: SizedBox(
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: movies[index].backdrop_path,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        height: 130.0,
                        width: 250,
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
                    const SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              movies[index].title,
                              style:
                                  darkTheme.textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Rating(
                            rating: movies[index].rate / 2,
                            size: 18,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: movies.length,
          ),
        ),
      ],
    );
