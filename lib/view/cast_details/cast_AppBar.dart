import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/data/cast.dart';

class CastAppBar extends StatelessWidget {
  CastAppBar({super.key, required this.cast});
  Cast cast;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      backgroundColor: darkTheme.scaffoldBackgroundColor,
      expandedHeight: 400,
      elevation: 0.0,
      pinned: true,
      stretch: true,

      flexibleSpace: FlexibleSpaceBar(
          stretchModes: const [
            StretchMode.blurBackground,
            StretchMode.zoomBackground
          ],
          background: CarouselSlider.builder(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              viewportFraction: 1,
              autoPlayAnimationDuration: const Duration(seconds: 2),
            ),
            itemCount: cast.images.length,
            itemBuilder: (context, index, realIndex) => CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              imageUrl: cast.images[index],
              fit: BoxFit.cover,
            ),
          )),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            alignment: Alignment.center,
            height: 32,
            decoration: BoxDecoration(
              color: darkTheme.scaffoldBackgroundColor,
              borderRadius: const BorderRadiusDirectional.vertical(
                  top: Radius.circular(22)),
            ),
            child: Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(53, 52, 75, 50),
                  borderRadius: BorderRadius.circular(100)),
            ),
          )),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: darkTheme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20)),
          child: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
