import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie1/cubit/cast_states.dart';
import 'package:movie1/data/cast.dart';
import 'package:movie1/data/movie.dart';

class CastCubit extends Cubit<CastStates> {
  CastCubit() : super(CastStates());
  final List<Cast> _casts = [];
  final List<MovieItem> _recommend = [];
  void getData(MovieItem movieItem) async {
    try {
      emit(CastLoadingStates());
      await movieItem.Recommend();
      await movieItem.getCast();
      _recommend.addAll(movieItem.recommend);
      _casts.addAll(movieItem.casts);

      emit(CastSuccessStates(casts: _casts, recommend: _recommend));
    } on DioException {
      emit(CastFailedStates());
    }
  }

  void getCastInformation(Cast cast) async {
    try {
      emit(CastLoadingStates());
      await cast.castInformation();
      emit(CastInformationSuccessStates(cast: cast));
    } on DioException {
      emit(CastInformationFailedStates());
    }
  }

  void getCastMovies(Cast cast) async {
    try {
      emit(CastLoadingStates());
      await cast.castMovies();
      emit(CastMoviesSuccessStates(movies: cast.movies));
    } on DioException {
      emit(CastFailedStates());
    }
  }
}
