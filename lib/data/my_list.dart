import 'package:movie1/data/movie.dart';

class MyListMovies {
  static List<MovieItem> myList = [];

  static void addMovie(MovieItem movieItem) {
    myList.add(movieItem);
  }

  static void removeMovie(int index) {
    myList.removeAt(index);
  }
}
