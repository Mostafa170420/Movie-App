import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie1/Theme/dark_theme.dart';
import 'package:movie1/cubit/myListCubit.dart';
import 'package:movie1/cubit/my_list_states.dart';
import 'package:movie1/components/grid.dart';

class myList extends StatelessWidget {
  const myList({super.key});

  @override
  Widget build(BuildContext context) {
    MyListCubit.get(context).getdata();
    Size size = MediaQuery.of(context).size;
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
            return Center(
                child: CircularProgressIndicator(
              color: darkTheme.primaryColor,
            ));
          } else if (state is MyListSuccessStates) {
            return buildMovieGrid(state.myList, 0);
          } else if (state is MyListEmptyStates) {
            return Center(
              child: Text(
                "Empty",
                style: darkTheme.textTheme.bodyMedium,
              ),
            );
          } else
             return Center(
                child: Text("Error",style: darkTheme.textTheme.bodyMedium,));
        },
      ),
    );
  }
}
