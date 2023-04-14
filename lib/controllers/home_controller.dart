import 'package:chat_app/consts/conste.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;

  static HomeController instance = Get.find();

  String username = '';
  String userImage = '';

  //get user details method
  getUserDetails() async {
    await firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) async {
      username = value.docs[0]['name'];
      userImage = value.docs[0]['image_url'];
      //here we are getting our current details stored in the value variable
      prefs = await SharedPreferences.getInstance();
      prefs.setStringList('user_details', [
        //store name and image url on index 0 and 1
        value.docs[0]['name'],
        value.docs[0]['image_url']
      ]);
    });
  }

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }
}
