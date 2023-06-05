import 'package:cloud_firestore/cloud_firestore.dart';

mixin FirebaseSerializerUtils {
  List<T> listFromQuerySnapshot<T>(
    QuerySnapshot snapshot,
    T Function(Map<String, dynamic> element) fromMap,
  ) {
    return snapshot.docs.map((e) => fromMap((e.data() as Map).cast())).toList();
  }

  T fromDocumentSnapshot<T>(
    DocumentSnapshot snapshot,
    T Function(Map<String, dynamic>) fromMap,
  ) {
    return fromMap((snapshot.data() as Map).cast());
  }
}
