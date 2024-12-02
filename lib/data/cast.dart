import 'package:dio/dio.dart';
import 'package:movie1/data/movie.dart';

class Cast {
  late int id;
  late String name;
  late String profilePath;
  late String description;
  late String department;
  late String birthday;
  late double popularity;
  late List<String> images;
  late List<MovieItem> movies;
  Cast.fromApi(Map<String, dynamic> map) {
    name = map["name"];
    profilePath = "https://image.tmdb.org/t/p/w500${map["profile_path"]}";
    id = map["id"];
  }
  Future<void> castInformation() async {
    Response response = await Dio().get(
        "https://api.themoviedb.org/3/person/$id?api_key=fadb5d6a867181fbfa820bf958696c92");
    Response responseImage = await Dio().get(
        "https://api.themoviedb.org/3/person/$id/images?api_key=fadb5d6a867181fbfa820bf958696c92");
    var castInf = response.data;
    var castImg = responseImage.data;
    var castImages = castImg["profiles"] as List;
    description = castInf["biography"];
    department = castInf["known_for_department"];
    birthday = castInf["birthday"];
    popularity = castInf["popularity"];
    images = List.from(castImages.map((e) => image(e)));
  }

  Future<void> castMovies() async {
    Response response = await Dio().get(
        "https://api.themoviedb.org/3/person/$id/movie_credits?api_key=fadb5d6a867181fbfa820bf958696c92");
    var castMovies = response.data["cast"] as List;
    movies = [];
    for (var movie in castMovies) {
      if (movie["poster_path"] == null) {
        continue;
      }
      movies.add(MovieItem.fromApi(movie));
    }
  }

  String image(Map<String, dynamic> map) {
    return "https://image.tmdb.org/t/p/w500${map["file_path"]}";
  }
}

class CastData {}
