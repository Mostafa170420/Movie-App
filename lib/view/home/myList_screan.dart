import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/myListCubit.dart';
import 'package:movie1/cubit/my_list_states.dart';
import 'package:movie1/grid.dart';

class myList extends StatelessWidget {
  const myList({super.key});

  @override
  Widget build(BuildContext context) {
    MyListCubit.get(context).data();
    return Scaffold(
      backgroundColor: darkTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkTheme.scaffoldBackgroundColor,
        title: Text(
          "My List",
          style: darkTheme.textTheme.displaySmall,
        ),
      ),
      body: BlocBuilder<MyListCubit, MyListStates>(
        builder: (context, state) {
          if (state is MyListLoadingStates) {
            return const Center(
                child: Text(
              "Empty",
              style: TextStyle(color: Colors.white),
            ));
          } else if (state is MyListSuccessStates)
            return buildMovieGrid(state.myList, 0);
          else
            return Container();
        },
      ),
    );
  }
}
