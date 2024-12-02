import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/view/details/movieDetails.dart';
import 'package:shimmer/shimmer.dart';

class CastMovieItem extends StatelessWidget {
  const CastMovieItem({super.key, required this.movie});
  final MovieItem movie;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(movieItem: movie),
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: movie.imagePath,
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
          height: size.height / 5,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(),
          ),
        ),
      ),
    );
  }
}
