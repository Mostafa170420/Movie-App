import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie1/cubit/my_list_states.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/data/my_list.dart';

class MyListCubit extends Cubit<MyListStates> {
  MyListCubit() : super(MyListStates());
  static MyListCubit get(context) => BlocProvider.of(context);
  List<MovieItem> myList = [];
  void data() {
    emit(MyListLoadingStates());
    myList = MyListMovies.myList;
    if (myList.isNotEmpty) {
      emit(MyListSuccessStates(myList: myList));
    }
  }
}
