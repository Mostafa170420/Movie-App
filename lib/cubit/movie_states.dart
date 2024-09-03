part of 'movie_cubit.dart';

class MoviesStates {}

class MoviesLoadingStates extends MoviesStates {}

class MoviesSuccessStates extends MoviesStates {
  Map<String, List<MovieItem>> category;
  MoviesSuccessStates({required this.category});
}

class MoviesSuccessFromPaginnationStates extends MoviesStates {
  List<MovieItem> category;
  MoviesSuccessFromPaginnationStates({required this.category});
}

class MoviesFailedStates extends MoviesStates {
  String msg;
  MoviesFailedStates({required this.msg});
}

class MoviesLoadingFromPaginnationStates extends MoviesStates {}

class MoviesFailedFromPaginnationStates extends MoviesStates {
  String msg;
  MoviesFailedFromPaginnationStates({required this.msg});
}
