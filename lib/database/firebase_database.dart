import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('Notes');

  // Create
  Future<void> addItem(String title, String items, int color) {
    return collectionRef.add({'title': title, 'items': items, 'color': color});
  }

  Stream<QuerySnapshot> getItems() {
    return collectionRef.snapshots();
  }

  // Update
  Future<void> updateItem(String id, String items) {
    return collectionRef.doc(id).update({'items': items});
  }

  // Delete
  Future<void> deleteItem(String id) {
    return collectionRef.doc(id).delete();
  }
}
