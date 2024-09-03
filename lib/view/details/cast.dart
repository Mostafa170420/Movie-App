import 'package:flutter/material.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cast_details/cast_home.dart';
import 'package:movie1/data/cast.dart';

class CastWidget extends StatelessWidget {
  CastWidget({super.key, required this.castItems});

  List<Cast> castItems;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CastHome(cast: castItems[index])));
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(castItems[index].profilePath),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: SizedBox(
                          width: 65,
                          child: Text(castItems[index].name,
                              style: darkTheme.textTheme.bodySmall)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
