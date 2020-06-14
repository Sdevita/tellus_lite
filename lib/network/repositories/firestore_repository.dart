import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:telluslite/persistent/models/user_configuration.dart';

class FireStoreRepository {
  final fireStoreInstance = Firestore.instance;

  Future<UserConfiguration> loadUserConfiguration() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var snapshot = await fireStoreInstance
        .collection("users")
        .document(firebaseUser.uid)
        .get();
    print("Loaded : " + snapshot.data.toString());
    return UserConfiguration.fromJson(snapshot.data);
  }

  Future saveUserConfiguration(UserConfiguration userConfiguration) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var snapshot = await fireStoreInstance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userConfiguration.toJson());
    print("Saved user configuration");
  }
}
