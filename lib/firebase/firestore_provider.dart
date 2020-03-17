import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinsta/constants/firebase_keys.dart';
import 'package:flutterinsta/data/user.dart';
import 'package:flutterinsta/firebase/transformer.dart';

class FirestoreProvider with Transformer {
  final Firestore _firestore = Firestore.instance;

  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference userRef =
        _firestore.collection(COLLECTION_USERS).document(userKey);
    final DocumentSnapshot snapshot = await userRef.get();
    return _firestore.runTransaction((Transaction tx) async {
      if (!snapshot.exists) {
        await tx.set(userRef, User.getMapForCreateUser(email));
      }
    });
  }

  Stream<User> connectMyUserData(String userKey) {
    return _firestore
        .collection(COLLECTION_USERS)
        .document(userKey)
        .snapshots()
        .transform(toUser);
  }

  Stream<List<User>> fetchAllUsers() {
    return _firestore
        .collection(COLLECTION_USERS)
        .snapshots()
        .transform(toUsers);
  }

  Stream<List<User>> fetchAllUsersExceptMine() {
    return _firestore
        .collection(COLLECTION_USERS)
        .snapshots()
        .transform(toUsers);
  }
}

//인스턴스 생성 (아무곳에서나 접근할 수 있도록 바깥에 생성)
FirestoreProvider firestoreProvider = FirestoreProvider();
