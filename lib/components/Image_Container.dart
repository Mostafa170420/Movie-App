import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie1/Theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class Image_Container extends StatelessWidget {
  const Image_Container(
      {super.key, required this.imageUrl, required this.rate});
  final String imageUrl;
  final double rate;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 130,
            fit: BoxFit.fill,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(),
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          left: 8.0,
          child: Container(
            width: 40,
            height: 24,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: ColorPalette.darkPrimary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              rate.toString(),
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
