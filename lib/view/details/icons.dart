import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/components/buttom.dart';
import 'package:movie1/view/details/subText.dart';

class SecondScrean extends StatelessWidget {
  SecondScrean(
      {super.key,
      required this.title,
      required this.description,
      required this.rate,
      required this.date,
      required this.adult,
      required this.original_language});
  String title, description, date, original_language;
  double rate;
  bool adult;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: darkTheme.textTheme.displaySmall?.copyWith(
                overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: height / 90,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                showRate(rate: rate, context: context),
                showRelease(date: date, context: context),
                BuildButton(
                  text: adult ? "18+" : "12+",
                  textColor: darkTheme.primaryColor,
                  iconButton: false,
                  border: true,
                  borderRadius: 5,
                  marginHorizontal: 10,
                ),
                BuildButton(
                    text: original_language.toUpperCase(),
                    textColor: darkTheme.primaryColor,
                    iconButton: false,
                    border: true,
                    borderRadius: 5),
                BuildButton(
                  text: "United States",
                  textColor: darkTheme.primaryColor,
                  iconButton: false,
                  border: true,
                  borderRadius: 5,
                  marginHorizontal: 10,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height / 80,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExpandableText(
              text: description,
              height: height,
            )),
      ],
    );
  }
}

Text showRelease({required String date, required BuildContext context}) {
  String dateString = date;
  DateTime dateTime = DateTime.parse(dateString);
  int year = dateTime.year;
  return Text(
    year.toString(),
    style:
        darkTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
  );
}

Row showRate({required double rate, required BuildContext context}) {
  return Row(
    children: [
      Icon(
        Iconsax.star1,
        size: 25,
        color: darkTheme.primaryColor,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        rate.toStringAsFixed(1),
        style: darkTheme.textTheme.bodyLarge?.copyWith(
            color: darkTheme.primaryColor, fontWeight: FontWeight.w600),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Icon(
          Iconsax.arrow_right_3,
          color: darkTheme.primaryColor,
        ),
      ),
    ],
  );
}
