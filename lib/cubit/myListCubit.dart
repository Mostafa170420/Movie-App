import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie1/cubit/my_list_states.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/data/my_list.dart';

class MyListCubit extends Cubit<MyListStates> {
  MyListCubit() : super(MyListStates());
  static MyListCubit get(context) => BlocProvider.of(context);
  MyListRepository myListRepository = MyListRepository();
  List<MovieItem> myList = [];
  void getdata() async {
    try {
      emit(MyListLoadingStates());
      myList = await myListRepository.getMovies();
      if (myList.isNotEmpty) {
        emit(MyListSuccessStates(myList: myList));
      } else {
        emit(MyListEmptyStates());
      }
    } catch (e) {
      print(e);

      emit(MyListFailedStates());
    }
  }

  void addMovie({required MovieItem movie}) async {
    try {
      await myListRepository.addMovie(movie);
      myList = await myListRepository.getMovies();
      if (myList.isNotEmpty) {
        emit(MyListSuccessStates(myList: myList));
      } else {
        emit(MyListEmptyStates());
      }
    } catch (e) {
      print(e);
      emit(MyListFailedStates());
    }
  }

  void deleteMovie({required int index}) async {
    try {
      await myListRepository.deleteMovie(index);
      myList = await myListRepository.getMovies();
      if (myList.isNotEmpty) {
        emit(MyListSuccessStates(myList: myList));
      } else {
        emit(MyListEmptyStates());
      }
    } catch (e) {
      print(e);
      emit(MyListFailedStates());
    }
  }
}
