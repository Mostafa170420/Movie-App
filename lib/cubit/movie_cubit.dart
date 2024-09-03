import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie1/data/movie.dart';
part 'movie_states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesStates());
  static MoviesCubit get(context) => BlocProvider.of(context);
  int i = 1;
  String Now =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=fadb5d6a867181fbfa820bf958696c92&page=";
  String Upcoming =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=fadb5d6a867181fbfa820bf958696c92&page=";
  String TopRated =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=fadb5d6a867181fbfa820bf958696c92&page=";
  String Popular =
      "https://api.themoviedb.org/3/movie/popular?api_key=fadb5d6a867181fbfa820bf958696c92&page=";
  final Map<String, List<MovieItem>> _category = {
    "Now": [],
    "Upcoming": [],
    "TopRated": [],
    "Popular": []
  };
  void getData() async {
    emit(MoviesLoadingStates());
    try {
      Response now = await Dio().get(Now + i.toString());
      Response upcoming = await Dio().get(Upcoming + i.toString());
      Response topRated = await Dio().get(TopRated + i.toString());
      Response popular = await Dio().get(Popular + i.toString());
      MoviesData moviesData =
          MoviesData(now.data, upcoming.data, topRated.data, popular.data);
      if (moviesData.mapm.isNotEmpty) {
        _category["Now"]!.addAll(moviesData.mapm["Now"]!);
        _category["Upcoming"]!.addAll(moviesData.mapm["Upcoming"]!);
        _category["TopRated"]!.addAll(moviesData.mapm["TopRated"]!);
        _category["Popular"]!.addAll(moviesData.mapm["Popular"]!);
      }

      emit(MoviesSuccessStates(category: _category));
    } on DioException catch (e) {
      emit(MoviesFailedStates(msg: e.message!));
    }
  }

  void getCategory(String category, {bool loading = false}) async {
    if (loading) {
      emit(MoviesLoadingFromPaginnationStates());
    } else {
      emit(MoviesLoadingStates());
    }
    try {
      Response response;
      if (category == "Now") {
        response = await Dio().get(Now + i.toString());
      } else if (category == "Upcoming") {
        response = await Dio().get(Upcoming + i.toString());
      } else if (category == "TopRated") {
        response = await Dio().get(TopRated + i.toString());
      } else {
        response = await Dio().get(Popular + i.toString());
      }
      MoviesData moviesData = MoviesData.category(response.data, category);
      if (moviesData.mapm[category]!.isNotEmpty) {
        _category[category]!.addAll(moviesData.mapm[category]!);
        i++;
        emit(
            MoviesSuccessFromPaginnationStates(category: _category[category]!));
      }
    } on DioException catch (e) {
      if (loading) {
        emit(MoviesFailedFromPaginnationStates(
            msg: e.response!.data["status_message"]));
        await Future.delayed(const Duration(seconds: 2));
        emit(MoviesSuccessStates(category: _category));
      } else {
        emit(MoviesFailedStates(msg: e.message!));
      }
    }
  }
}
