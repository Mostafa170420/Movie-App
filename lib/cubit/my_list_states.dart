import 'package:movie1/data/movie.dart';

class MyListStates {}

class MyListLoadingStates extends MyListStates {}

class MyListSuccessStates extends MyListStates {
  List<MovieItem> myList;
  MyListSuccessStates({required this.myList});
}
