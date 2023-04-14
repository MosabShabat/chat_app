import 'package:chat_app/consts/conste.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../views/home_screen/home_screen.dart';

class AuthController extends GetxController {
//text controllers

  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var optController = List.generate(6, (index) => TextEditingController());

  //variables

  var isOptSent = false.obs;
  var formKey = GlobalKey<FormState>();

  //auth variables

  late final PhoneVerificationCompleted phoneVerificationCompleted;
  late final PhoneVerificationFailed phoneVerificationFailed;
  late PhoneCodeSent phoneCodeSent;
  String verificationID = '';

  //sendOtp method
  sendOtp() async {
    phoneVerificationCompleted = (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };
    phoneVerificationFailed = (FirebaseAuthException e) async {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    };
    phoneCodeSent = (String verificationId, int? resendToken) async {
      verificationID = verificationId;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+97${phoneController.text}',
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //verify otp

  verifyOtp(context) async {
    String otp = '';

    //getting all textFields data

    for (var i = 0; i < optController.length; i++) {
      otp += optController[i].text;
    }

    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);

      //getting user
      final User? user =
          (await auth.signInWithCredential(phoneAuthCredential)).user;

      if (user != null) {
        //store user into database
        DocumentReference store =
            FirebaseFirestore.instance.collection(collectionUser).doc(user.uid);
        await store.set({
          'id': user.uid,
          'name': userNameController.text.toString(),
          'phone': phoneController.text.toString(),
          'about': '',
          'image_url': ''
        }, SetOptions(merge: true));

        //showing toast of login

        VxToast.show(context, msg: loggedIn);
        Get.offAll(() => HomeScreen(), transition: Transition.downToUp);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
