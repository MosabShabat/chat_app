import 'package:chat_app/consts/conste.dart';
import 'package:chat_app/services/store_services.dart';
import 'package:chat_app/views/chat_screen/chat.dart';
import 'package:chat_app/views/home_screen/components/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

Widget chatsComponents() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: StreamBuilder(
      stream: StoreServices.getMessages(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(bgColor),
            ),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child:
                "Start a conversation...".text.semiBold.color(textColor).make(),
          );
        } else {
          return ListView(
            children: snapshot.data!.docs.mapIndexed((currentValue, index) {
              var doc = snapshot.data!.docs[index];
              return messageBubble(doc);
            }).toList(),
          );
        }
      },
    ),
  );
}
