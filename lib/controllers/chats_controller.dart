import 'package:chat_app/consts/conste.dart';
import 'package:chat_app/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  dynamic chatId;
  var chats = firebaseFirestore.collection(collectionChats);
  var userId = currentUser!.uid;

  var friendId = Get.arguments[1];

  var username =
      HomeController.instance.prefs.getStringList('user_details')![0];

  var friendName = Get.arguments[0];

  var messageController = TextEditingController();

  var isLoading = false.obs;

//creating chatroom
  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, userId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            chatId = snapshot.docs.single.id;
          } else {
            chats.add({
              'users': {userId: null, friendId: null},
              'friend_name': friendName,
              'user_name': username,
              'toId': '',
              'formId': '',
              'created_on': null,
              'last_msg': ''
            }).then((value) {
              {
                chatId = value.id;
              }
            });
          }
        });
    isLoading(false);
  }

  //send message method
  sendMessage(String msg) {
    if (msg.trim().isNotEmptyAndNotNull) {
      chats.doc(chatId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'formId': userId
      });

      chats.doc(chatId).collection(collectionMessages).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': userId
      }).then((value) {
        messageController.clear();
      });
    }
  }

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }
}
