import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<QueryDocumentSnapshot>> getDocs(
      String collectionId, String userId) async {
    try {
      var data = await firestore
          .collection(collectionId)
          .doc(userId)
          .collection("myList")
          .get();
      return data.docs;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser(
      String collectionId, String id, Map<String, dynamic> map) async {
    try {
      await firestore.collection(collectionId).doc(id).set(map);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDoc(String collectionId, String userId, String docId,
      Map<String, dynamic> map) async {
    try {
      await firestore
          .collection(collectionId)
          .doc(userId)
          .collection("myList")
          .doc(docId)
          .set(map);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteDoc(
    String collectionId,
    String userId,
    String docId,
  ) async {
    try {
      await firestore
          .collection(collectionId)
          .doc(userId)
          .collection("myList")
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDoc(
      String collectionId, String id, Map<String, dynamic> map) async {
    try {
      await firestore.collection(collectionId).doc(id).update(map);
    } catch (e) {
      rethrow;
    }
  }
}
