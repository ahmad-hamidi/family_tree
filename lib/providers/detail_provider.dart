import 'dart:collection';

import 'package:family_tree/config/database.dart';
import 'package:family_tree/models/family_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DetailProvider {
  Future<FamilyModel?> getFamilyDetail(String? id) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection(Database.familyTable)
          .doc(id ?? "")
          .snapshots()
          .first;

      Map<String, dynamic>? item = response.data();
      FamilyModel model = FamilyModel.mapping(item ?? HashMap());
      return model;
    } catch (e) {
      if (kDebugMode) {
        print("error get family detail $e");
      }
      return null;
    }
  }
}
