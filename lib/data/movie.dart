import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:movie1/data/cast.dart';

class MovieItem {
  late int id;
  late String imagePath,
      backdrop_path,
      title,
      description,
      date,
      original_language;
  late double rate;
  late bool adult;
  late String youtubeKey;
  late List<MovieItem> recommend = [];
  late List<Cast> casts = [];
  MovieItem.fromFirebase(DocumentSnapshot doc) {
    var map = doc.data() as Map;
    id = map["id"];
    backdrop_path = map["backdrop_path"];
    imagePath = map["poster_path"];
    title = map["title"];
    description = map["overview"];
    rate = map["vote_average"];
    date = map["release_date"];
    adult = map["adult"];
    original_language = map["original_language"];
  }
  MovieItem.fromApi(Map<String, dynamic> map) {
    id = map["id"];
    backdrop_path = "https://image.tmdb.org/t/p/w500${map["backdrop_path"]}";
    imagePath = "https://image.tmdb.org/t/p/w500${map["poster_path"]}";
    title = map["title"];
    description = map["overview"];
    rate = map["vote_average"];
    date = map["release_date"];
    adult = map["adult"];
    original_language = map["original_language"];
  }
  Future<void> Recommend() async {
    Response recommendations = await Dio().get(
        "https://api.themoviedb.org/3/movie/$id/recommendations?api_key=fadb5d6a867181fbfa820bf958696c92");
    var recomm = recommendations.data["results"] as List;
    recommend = [];
    for (var r in recomm) {
      if (r["backdrop_path"] == null) {
        continue;
      }
      recommend.add(MovieItem.fromApi(r));
    }
  }

  Future<void> getCast() async {
    Response credits = await Dio().get(
        "https://api.themoviedb.org/3/movie/$id/credits?api_key=fadb5d6a867181fbfa820bf958696c92");
    var cast = credits.data["cast"] as List;
    casts = [];
    for (var c in cast) {
      if (c["profile_path"] == null) {
        continue;
      }
      casts.add(Cast.fromApi(c));
    }
  }

  Future<void> getYoutube() async {
    Response videos = await Dio().get(
        "https://api.themoviedb.org/3/movie/$id/videos?api_key=fadb5d6a867181fbfa820bf958696c92");
    var video = videos.data["results"] as List;
    youtubeKey = video[0]["key"];
    print(youtubeKey);
  }

  Map<String, dynamic> movieMap() {
    return {
      "id": id,
      "backdrop_path": backdrop_path,
      "poster_path": imagePath,
      "title": title,
      "overview": description,
      "vote_average": rate,
      "release_date": date,
      "adult": adult,
      "original_language": original_language
    };
  }
}

class MoviesData {
  late Map<String, List<MovieItem>> mapm = {
    "Now": [],
    "Upcoming": [],
    "TopRated": [],
    "Popular": []
  };
  MoviesData(Map<String, dynamic> Now, Map<String, dynamic> Upcoming,
      Map<String, dynamic> TopRated, Map<String, dynamic> Popular) {
    movieList(Now, "Now");
    movieList(Upcoming, "Upcoming");
    movieList(TopRated, "TopRated");
    movieList(Popular, "Popular");
  }
  MoviesData.category(Map<String, dynamic> map, String category) {
    movieList(map, category);
  }
  void movieList(Map<String, dynamic> map, String category) {
    var movies = map["results"] as List;
    mapm[category] = List.from(movies.map((e) => MovieItem.fromApi(e)));
  }
}
