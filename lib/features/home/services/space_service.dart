import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/space_model.dart';

class SpaceService {
  final firestore =
      FirebaseFirestore.instance;

  final auth =
      FirebaseAuth.instance;

  Future<void> createSpace({
    required String name,
    required double budget,
  }) async {

    final user =
        auth.currentUser!;

    final id =
        const Uuid().v4();

    final now =
        DateTime.now();

    final space =
        SpaceModel(
      id: id,
      name: name,
      budget: budget,
      month: now.month,
      year: now.year,
      ownerId: user.uid,
      members: [user.uid],
    );

    await firestore
        .collection("spaces")
        .doc(id)
        .set(
          space.toMap(),
        );
  }
}