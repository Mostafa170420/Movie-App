import 'package:movie1/data/cast.dart';
import 'package:movie1/data/movie.dart';

class CastStates {}

class CastLoadingStates extends CastStates {}

class CastSuccessStates extends CastStates {
  List<Cast> casts;
  List<MovieItem> recommend;
  CastSuccessStates({required this.casts, required this.recommend});
}

class CastFailedStates extends CastStates {}

class CastInformationSuccessStates extends CastStates {
  Cast cast;
  CastInformationSuccessStates({required this.cast});
}

class CastMoviesSuccessStates extends CastStates {
  List<MovieItem> movies;
  CastMoviesSuccessStates({required this.movies});
}

class CastInformationFailedStates extends CastStates {}
