import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cast_details/cast_AppBar.dart';
import 'package:movie1/cubit/cast_cubit.dart';
import 'package:movie1/cubit/cast_states.dart';
import 'package:movie1/data/cast.dart';
import 'package:movie1/details/subText.dart';

class CastHome extends StatelessWidget {
  CastHome({super.key, required this.cast});
  Cast cast;
  CastCubit castCubit = CastCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => castCubit..getCastInformation(cast),
        child: Scaffold(
          backgroundColor: darkTheme.scaffoldBackgroundColor,
          body: BlocBuilder<CastCubit, CastStates>(
            builder: (context, state) {
              if (state is CastLoadingStates) {
                return Center(
                  child: CircularProgressIndicator(
                    color: darkTheme.primaryColor,
                  ),
                );
              } else if (state is CastInformationSuccessStates) {
                return CustomScrollView(
                  slivers: <Widget>[
                    CastAppBar(
                      cast: cast,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: DelayedWidget(
                          delayDuration: const Duration(milliseconds: 200),
                          animation: DelayedAnimations.SLIDE_FROM_TOP,
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(cast.name,
                                        style: darkTheme.textTheme.displaySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                    Image.asset(
                                      "assets/book.png",
                                      scale: 20,
                                    )
                                  ]),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Department",
                                        style: darkTheme.textTheme.displaySmall
                                            ?.copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(cast.department,
                                          style: darkTheme
                                              .textTheme.displaySmall
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  color: darkTheme.primaryColor,
                                                  fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Birthday",
                                        style: darkTheme.textTheme.displaySmall
                                            ?.copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(cast.birthday,
                                          style: darkTheme
                                              .textTheme.displaySmall
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  color: darkTheme.primaryColor,
                                                  fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Popularity",
                                        style: darkTheme.textTheme.displaySmall
                                            ?.copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(cast.popularity.toString(),
                                          style: darkTheme
                                              .textTheme.displaySmall
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  color: darkTheme.primaryColor,
                                                  fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ExpandableText(
                                text: cast.description,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else if (state is CastInformationFailedStates) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ));
  }
}
