import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UserImageProvider with ChangeNotifier {
  final FirebaseAuth _userAuth ;
  final FirebaseStorage _storage ;

  UserImageProvider(this._userAuth,this._storage);

  Future<Either<Uint8List, String>> pickAnImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return Left(await file.readAsBytes());
    } else {
      return const Right('No image was selected');
    }
  }

  // Uploading an image to firebase storage then returning the download URL.
  Future<String> uploadAnImageToStorage({
    required String fileName,
    required Uint8List file,
    required bool isPost,
  }) async {
    Reference reference =
        _storage.ref().child(fileName).child(_userAuth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      reference = reference.child(id);
    }
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot snapShot = await uploadTask;
    String downloadUrl = await snapShot.ref.getDownloadURL();
    notifyListeners();
    return downloadUrl;
  }

  Future<String> getUserProfileImage() async {
    String photoUrl = '';
    DocumentReference userDocId = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    userDocId.get().then((DocumentSnapshot snapshot) => {
          photoUrl = (snapshot.data() as Map<String, dynamic>)['photoUrl'],
        });
    return photoUrl;
  }
}
