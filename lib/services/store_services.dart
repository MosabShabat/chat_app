import 'package:chat_app/consts/conste.dart';

class StoreServices {
  //get user data
  static getUser(String id) {
    return firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: id)
        .get();
  }

  //get all users from firebase users collection
  static getAllUsers() {
    return firebaseFirestore.collection(collectionUser).snapshots();
  }

  //get all chats
  static getChats(String chatId) {
    return firebaseFirestore
        .collection(collectionChats)
        .doc(chatId)
        .collection(collectionMessages)
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  //get all messages
  static getMessages() {
    return firebaseFirestore
        .collection(collectionChats)
        .where("users.${currentUser!.uid}", isEqualTo: null)
        .where("created_on", isNotEqualTo: null)
        .snapshots();
  }
}
