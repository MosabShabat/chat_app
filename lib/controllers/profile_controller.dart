import 'dart:io';

import 'package:chat_app/consts/conste.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();

  //variables for image
  var imgPath = ''.obs;
  var imgLink = '';
  var isloading = false.obs;
  //update profile method

  updateProfile(context) async {
    //store user into database
    var store =
        firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
    await store.set({
      'name': nameController.text,
      'about': aboutController.text,
      'image_url': imgLink
    }, SetOptions(merge: true));
    VxToast.show(context, msg: "Profile updated successfully!");
  }

  //image picking method

  pickImage(context, source) async {
    await Permission.photos.request();
    await Permission.camera.request();

    var status = await Permission.photos.status;
    print(status.isGranted);
    if (!status.isGranted) {
      try {
        final img =
            await ImagePicker().pickImage(source: source, imageQuality: 80);
        imgPath.value = img!.path;

        VxToast.show(context, msg: 'Image selected');
      } on PlatformException catch (e) {
        print(e.toString());
        VxToast.show(context, msg: e.toString());
      }
    } else {
      VxToast.show(context, msg: 'Permission denied');
    }
  }

  uploadProfileImage() async {
    var name = basename(imgPath.value);
    var destination = "images/${currentUser!.uid}/$name";
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imgPath.value));
    var d = await ref.getDownloadURL();
    imgLink = d;
  }

  //   updateProfile({name, email, image}) async {
  //   var store = FirebaseFirestore.instance
  //       .collection(myUserCollection)
  //       .doc(currentUser!.uid);
  //   await store.set({
  //     'name': name,
  //     'email': email,
  //     'image': image,
  //   }, SetOptions(merge: true));
  //   isloading(false);
  // }
}
