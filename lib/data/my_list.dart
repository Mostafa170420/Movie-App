import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie1/components/constants.dart';
import 'package:movie1/data/movie.dart';
import 'package:movie1/remote/firestore_helper.dart';
import 'dart:math';

class MyListRepository {
  List<MovieItem> _myList = [];
  FirestoreHelper firestoreHelper = FirestoreHelper();

  Future<List<MovieItem>> getMovies() async {
    try {
      if (_myList.isEmpty) {
        var movies = await firestoreHelper.getDocs(
            "user", FirebaseAuth.instance.currentUser!.uid);
        _myList = movies
            .map(
              (doc) => MovieItem.fromFirebase(doc),
            )
            .toList();
        return _myList;
      } else {
        return _myList;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addMovie(MovieItem movieItem) async {
    try {
      await firestoreHelper.addDoc(
          "user",
          FirebaseAuth.instance.currentUser!.uid,
          movieItem.id.toString(),
          movieItem.movieMap());
      _myList.add(movieItem);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMovie(int index) async {
    try {
      await firestoreHelper.deleteDoc("user",
          FirebaseAuth.instance.currentUser!.uid, _myList[index].id.toString());
      _myList.removeAt(index);
    } catch (e) {
      rethrow;
    }
  }
}
