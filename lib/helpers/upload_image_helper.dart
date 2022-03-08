import 'dart:async';
import 'dart:io' as io;

import 'package:family_tree/helpers/component_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<firebase_storage.UploadTask?> uploadFile(BuildContext context, XFile? file) async {
  if (file == null) {
    showSnackBar(context, "Photo not yet choose!");
    return null;
  }

  firebase_storage.UploadTask uploadTask;

  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('photo')
      .child('/file${DateTime.now().microsecondsSinceEpoch}.jpg');

  final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path});

  if (kIsWeb) {
    uploadTask = ref.putData(await file.readAsBytes(), metadata);
  } else {
    uploadTask = ref.putFile(io.File(file.path), metadata);
  }

  return Future.value(uploadTask);
}