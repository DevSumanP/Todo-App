import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('Notes');

  Future<void> addItem(String title, String items, int color) async {
    try {
      await collectionRef.add({
        'title': title,
        'items': items,
        'color': color,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding item: $e");
    }
  }

  Stream<QuerySnapshot> getItems() {
    return collectionRef.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> updateItem(String id, String items) async {
    try {
      await collectionRef.doc(id).update({
        'items': items,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await collectionRef.doc(id).delete();
    } catch (e) {
      print("Error deleting document: $e");
    }
  }
}
